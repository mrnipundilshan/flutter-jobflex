import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Job {
  final String title;
  final String company;
  final String location;

  final String imageUrl;
  final String jobId;
  final String status;
  final String userEmail;
  final DateTime appliedAt;
  final String applicationId;

  Job({
    required this.title,
    required this.company,
    required this.location,

    required this.imageUrl,
    required this.jobId,
    required this.status,
    required this.userEmail,
    required this.appliedAt,
    required this.applicationId,
  });
}

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int _selectedIndex = 0;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  List<Job> _recentJobs = [];
  List<Job> _closedJobs = [];
  List<Job> _savedJobs = [];

  @override
  void initState() {
    super.initState();
    _loadAppliedJobs();
  }

  Future<void> _acceptApplication(String applicationId) async {
    try {
      // Get the application data first
      final applicationDoc =
          await _firestore.collection('applied_jobs').doc(applicationId).get();

      if (!applicationDoc.exists) {
        throw Exception('Application not found');
      }

      final applicationData = applicationDoc.data()!;

      // Update the application status to 'closed'
      await _firestore.collection('applied_jobs').doc(applicationId).update({
        'status': 'closed',
      });

      // Save the hired user information
      try {
        final hiredUserData = {
          'userEmail': applicationData['userEmail'],
          'jobId': applicationData['jobId'],
          'jobTitle': applicationData['jobTitle'],
          'company': applicationData['company'],
          'hiredAt': FieldValue.serverTimestamp(),
          'status': 'active',
        };

        print('Attempting to add hired user data: $hiredUserData'); // Debug log

        // Create a new document with a custom ID
        final String hiredUserId =
            'hired_${applicationData['userEmail']}_${applicationData['jobId']}';

        await _firestore
            .collection('hired_users')
            .doc(hiredUserId)
            .set(hiredUserData);

        print(
          'Successfully created hired user document with ID: $hiredUserId',
        ); // Debug log

        // Reload the applications to reflect the changes
        await _loadAppliedJobs();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Application accepted and user hired successfully'),
          ),
        );
      } catch (hiredUserError) {
        print(
          'Error saving to hired_users collection: $hiredUserError',
        ); // Debug log
        // If hired_users collection fails, still update the application status
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Application accepted but error saving hired user: $hiredUserError',
            ),
          ),
        );
      }
    } catch (e) {
      print('Error in _acceptApplication: $e'); // Debug log
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error accepting application: $e')),
      );
    }
  }

  Future<void> _loadAppliedJobs() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      // Get all jobs posted by the current user (promoter)
      final postedJobsSnapshot =
          await _firestore
              .collection('jobs')
              .where('postedBy', isEqualTo: user.uid)
              .get();

      // Get all job IDs posted by the promoter
      final List<String> postedJobIds =
          postedJobsSnapshot.docs.map((doc) => doc.id).toList();

      if (postedJobIds.isEmpty) {
        setState(() {
          _recentJobs = [];
          _closedJobs = [];
          _savedJobs = [];
        });
        return;
      }

      // Get all applications for the posted jobs
      final appliedJobsSnapshot =
          await _firestore
              .collection('applied_jobs')
              .where('jobId', whereIn: postedJobIds)
              .get();

      // Create a map of job IDs to their data
      final Map<String, dynamic> postedJobsMap = {};
      for (var doc in postedJobsSnapshot.docs) {
        postedJobsMap[doc.id] = doc.data();
      }

      // Process applied jobs
      List<Job> recentJobs = [];
      List<Job> closedJobs = [];
      List<Job> savedJobs = [];

      for (var doc in appliedJobsSnapshot.docs) {
        final data = doc.data();
        final jobId = data['jobId'];
        final jobData = postedJobsMap[jobId];

        if (jobData != null) {
          final job = Job(
            title: data['jobTitle'] ?? '',
            company: data['company'] ?? '',
            location: jobData['location'] ?? '',

            imageUrl:
                'https://cdn3.careeraddict.com/uploads/article/58649/illustration-hotel-reception.jpg',
            jobId: jobId,
            status: data['status'] ?? 'pending',
            userEmail: data['userEmail'] ?? '',
            appliedAt: (data['appliedAt'] as Timestamp).toDate(),
            applicationId: doc.id,
          );

          if (data['status'] == 'pending') {
            recentJobs.add(job);
          } else if (data['status'] == 'closed') {
            closedJobs.add(job);
          } else if (data['status'] == 'saved') {
            savedJobs.add(job);
          }
        }
      }

      // Sort jobs by appliedAt timestamp (most recent first)
      recentJobs.sort((a, b) => b.appliedAt.compareTo(a.appliedAt));
      closedJobs.sort((a, b) => b.appliedAt.compareTo(a.appliedAt));
      savedJobs.sort((a, b) => b.appliedAt.compareTo(a.appliedAt));

      setState(() {
        _recentJobs = recentJobs;
        _closedJobs = closedJobs;
        _savedJobs = savedJobs;
      });
    } catch (e) {
      print('Error loading applied jobs: $e');
    }
  }

  Widget _buildJobList(List<Job> jobs) {
    return ListView.builder(
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        return JobCard(
          job: jobs[index],
          onAccept: _acceptApplication,
          key: UniqueKey(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Job> currentJobs;
    String title;

    switch (_selectedIndex) {
      case 0:
        currentJobs = _recentJobs;
        title = 'Pending Applications';
        break;
      case 1:
        currentJobs = _closedJobs;
        title = 'Closed Applications';
        break;
      case 2:
        currentJobs = _savedJobs;
        title = 'Saved Applications';
        break;
      default:
        currentJobs = _recentJobs;
        title = 'Pending Applications';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(title, style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFE8EAF6),
        child:
            currentJobs.isEmpty
                ? Center(
                  child: Text(
                    'No applications found',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                )
                : _buildJobList(currentJobs),
      ),
      backgroundColor: const Color.fromRGBO(30, 50, 92, 1),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Pending'),
          BottomNavigationBarItem(icon: Icon(Icons.lock), label: 'Closed'),
          BottomNavigationBarItem(icon: Icon(Icons.save), label: 'Saved'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final Job job;
  final Function(String) onAccept;

  const JobCard({super.key, required this.job, required this.onAccept});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(job.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Job Title: ${job.title}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Company: ${job.company}'),
                      Text('Location: ${job.location}'),

                      Text(
                        'Status: ${job.status.toUpperCase()}',
                        style: TextStyle(
                          color:
                              job.status == 'pending'
                                  ? Colors.orange
                                  : job.status == 'closed'
                                  ? Colors.red
                                  : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Applied by: ${job.userEmail}',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                      Text(
                        'Applied on: ${job.appliedAt.toString().split('.')[0]}',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (job.status == 'pending') ...[
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => onAccept(job.applicationId),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text('Accept Application'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
