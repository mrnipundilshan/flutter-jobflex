import 'package:flutter/material.dart';
import 'package:jobflex/widget/constants.dart';
import 'package:jobflex/widget/footer.dart';
import 'categories.dart'; // Import the categories.dart file
import 'package:cloud_firestore/cloud_firestore.dart';

class UserCatagoriedJob extends StatefulWidget {
  final String jobcatagory;
  const UserCatagoriedJob({Key? key, required this.jobcatagory})
    : super(key: key);

  @override
  State<UserCatagoriedJob> createState() => _UserCatagoriedJobState();
}

class _UserCatagoriedJobState extends State<UserCatagoriedJob> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jobs',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoriesScreen()),
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
                .where('category', isEqualTo: widget.jobcatagory)
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
              );
            },
          );
        },
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}

class JobCard extends StatelessWidget {
  final String jobTitle;
  final String company;
  final String location;
  final String workingDay;
  final String time;
  final String payment;
  final String email;
  final String imageUrl;

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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: const Color.fromARGB(
        255,
        210,
        226,
        255,
      ), // Set the card color to light blue
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
                    shape: BoxShape.circle, // Make the image circular
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(imageUrl),
                    ),
                  ),
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
                      Text('Location: $location'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Working Day: $workingDay'),
            Text('Time: $time'),
            Text('Payment: $payment'),
            Text('email: $email'),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: JPrimaryColor,
                    foregroundColor: JPrimaryLightColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Apply'),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: JPrimaryColor,
                    foregroundColor: JPrimaryLightColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
