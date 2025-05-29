import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 35, 58, 102),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: CupertinoColors.extraLightBackgroundGray,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(60),
                  bottomLeft: Radius.circular(60),
                ),
              ),
              height: 540,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 60),
                    // Back button and About us headline row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Back button
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Color.fromARGB(255, 35, 58, 102),
                              size: 28,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          // About us headline
                          Text(
                            "About Us",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 35, 58, 102),
                            ),
                          ),
                          // Empty SizedBox for alignment
                          SizedBox(width: 48),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    // Description text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "We are undergraduate students developing a mobile app to connect job seekers with employers. Understanding the challenges in finding part-time and freelance jobs, we aim to improve job market accessibility. Our expertise in mobile development and UI/UX design ensures a user-friendly experience. This project applies our academic skills to create real-world impact.",
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Contact Us section in the blue area
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Column(
                children: [
                  // Contact Us heading
                  Text(
                    "Contact Us",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  // Contact details
                  _buildContactItem(Icons.language, "www.jobflex.lk"),
                  _buildContactItem(Icons.email, "job@jobflex.ac.lk"),
                  _buildContactItem(Icons.phone, "+94 771236547"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build contact items
  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          SizedBox(width: 12),
          Text(text, style: TextStyle(fontSize: 18, color: Colors.white)),
        ],
      ),
    );
  }
}
