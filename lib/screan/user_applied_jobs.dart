import 'package:flutter/material.dart';
import 'package:jobflex/widget/footer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAppliedJobs extends StatefulWidget {
  const UserAppliedJobs({Key? key}) : super(key: key);

  @override
  State<UserAppliedJobs> createState() => _UserAppliedJobsState();
}

class _UserAppliedJobsState extends State<UserAppliedJobs> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // Check if user is logged in
    if (_auth.currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Applications'),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushNamed(context, '/userhome');
            },
          ),
        ),
        body: const Center(
          child: Text('Please login to view your applications'),
        ),
        bottomNavigationBar: const Footer(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Applications'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/userhome');
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            _firestore
                .collection('applied_jobs')
                .where('userEmail', isEqualTo: _auth.currentUser?.email)
                .orderBy('appliedAt', descending: true)
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('You haven\'t applied for any jobs yet'),
            );
          }

          // Create a map to store unique jobs by jobId
          final Map<String, DocumentSnapshot> uniqueJobs = {};
          for (var doc in snapshot.data!.docs) {
            final data = doc.data() as Map<String, dynamic>;
            final jobId = data['jobId'] as String;
            final userEmail = data['userEmail'] as String?;

            // Double check that this application belongs to the current user
            if (userEmail == _auth.currentUser?.email &&
                !uniqueJobs.containsKey(jobId)) {
              uniqueJobs[jobId] = doc;
            }
          }

          return ListView.builder(
            itemCount: uniqueJobs.length,
            itemBuilder: (context, index) {
              final doc = uniqueJobs.values.elementAt(index);
              final data = doc.data() as Map<String, dynamic>;

              return AppliedJobCard(
                jobTitle: data['jobTitle'] ?? '',
                company: data['company'] ?? '',
                appliedAt:
                    (data['appliedAt'] as Timestamp?)?.toDate() ??
                    DateTime.now(),
                status: data['status'] ?? 'pending',
                jobId: data['jobId'] ?? '',
              );
            },
          );
        },
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}

class AppliedJobCard extends StatelessWidget {
  final String jobTitle;
  final String company;
  final DateTime appliedAt;
  final String status;
  final String jobId;

  const AppliedJobCard({
    Key? key,
    required this.jobTitle,
    required this.company,
    required this.appliedAt,
    required this.status,
    required this.jobId,
  }) : super(key: key);

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'accepted':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon() {
    switch (status.toLowerCase()) {
      case 'accepted':
        return Icons.check;
      case 'rejected':
        return Icons.close;
      default:
        return Icons.hourglass_empty;
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
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: _getStatusColor(),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(_getStatusIcon(), color: Colors.white, size: 30),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jobTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Company: $company'),
                      Text(
                        'Applied on: ${appliedAt.toString().split(' ')[0]}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getStatusColor().withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Status: ${status.toUpperCase()}',
                style: TextStyle(
                  color: _getStatusColor(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
