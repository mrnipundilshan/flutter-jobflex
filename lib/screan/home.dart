import 'package:flutter/material.dart';
import 'package:jobflex/screan/user_catagoried_job.dart';
import 'package:jobflex/widget/constants.dart';
import 'package:jobflex/widget/footer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    _getUserName();
  }

  Future<void> _getUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
      if (userDoc.exists) {
        setState(() {
          userName = userDoc.data()?['fullname'] ?? '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final jobCategories = [
      {
        'title': 'Event Crew',
        'image': 'img/Adobe illustrations - Steve Scott.jpeg',
      },
      {'title': 'Super market', 'image': 'img/super_market.png'},
      {'title': 'Supportive team', 'image': 'img/supportive_team.png'},
      {'title': 'Marketing', 'image': 'img/marketing.png'},
      {'title': 'Pet care', 'image': 'img/pet_care.png'},
      {'title': 'Health Care', 'image': 'img/health_care.png'},
    ];

    return Scaffold(
      backgroundColor: JPrimaryLightColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your Job\nNeeds',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search, size: 30),
                    onPressed: () {
                      // Add search functionality here
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Hi $userName, Find Your Next Flex Job Today!',
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: jobCategories.length,
                  itemBuilder: (context, index) {
                    return _buildCategoryCard(
                      jobCategories[index]['title'] as String,
                      jobCategories[index]['image'] as String,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }

  Widget _buildCategoryCard(String title, String image) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder:
                (BuildContext context) => UserCatagoriedJob(jobcatagory: title),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(image, fit: BoxFit.contain),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
