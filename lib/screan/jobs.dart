import 'package:flutter/material.dart';
import 'package:jobflex/screan/user_applied_jobs.dart';
import 'package:jobflex/widget/constants.dart';
import 'package:jobflex/widget/footer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({Key? key}) : super(key: key);

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/userhome');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check_box, size: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserAppliedJobs()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            _firestore
                .collection('jobs')
                .where('status', isEqualTo: 'active')
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No jobs available'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final doc = snapshot.data!.docs[index];
              final data = doc.data() as Map<String, dynamic>;

              return JobCard(
                jobTitle: data['jobTitle'] ?? '',
                company: data['category'] ?? '',
                location: data['location'] ?? '',
                workingDay: 'Contact for details',
                time: 'Contact for details',
                payment: 'Contact for details',
                email: data['email'] ?? '',
                imageUrl:
                    'https://cdn3.careeraddict.com/uploads/article/58649/illustration-hotel-reception.jpg',
                jobId: doc.id,
              );
            },
          );
        },
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}

class JobCard extends StatefulWidget {
  final String jobTitle;
  final String company;
  final String location;
  final String workingDay;
  final String time;
  final String payment;
  final String email;
  final String imageUrl;
  final String jobId;

  const JobCard({
    Key? key,
    required this.jobTitle,
    required this.company,
    required this.location,
    required this.workingDay,
    required this.time,
    required this.payment,
    required this.email,
    required this.imageUrl,
    required this.jobId,
  }) : super(key: key);

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  bool _hasApplied = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkApplicationStatus();
  }

  Future<void> _checkApplicationStatus() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final appliedJobs =
            await FirebaseFirestore.instance
                .collection('applied_jobs')
                .where('jobId', isEqualTo: widget.jobId)
                .where('userEmail', isEqualTo: user.email)
                .get();

        setState(() {
          _hasApplied = appliedJobs.docs.isNotEmpty;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _applyForJob(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please login to apply for jobs')),
        );
        return;
      }

      // Save application
      await FirebaseFirestore.instance.collection('applied_jobs').add({
        'jobId': widget.jobId,
        'userEmail': user.email,
        'jobTitle': widget.jobTitle,
        'company': widget.company,
        'appliedAt': FieldValue.serverTimestamp(),
        'status': 'pending',
      });

      setState(() {
        _hasApplied = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Application submitted successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error applying for job: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: const Color.fromARGB(255, 210, 226, 255),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.imageUrl),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.jobTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Company: ${widget.company}'),
                      Text('Location: ${widget.location}'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Working Day: ${widget.workingDay}'),
            Text('Time: ${widget.time}'),
            Text('Payment: ${widget.payment}'),
            Text('email: ${widget.email}'),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _hasApplied ? null : () => _applyForJob(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _hasApplied ? Colors.grey : JPrimaryColor,
                      foregroundColor: JPrimaryLightColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(_hasApplied ? 'Applied' : 'Apply'),
                  ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
