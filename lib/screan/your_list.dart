import 'package:flutter/material.dart';

class YourListPage extends StatelessWidget {
  const YourListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECF1FA), // Light blue background
      appBar: AppBar(
        backgroundColor: const Color(0xFFECF1FA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF233A66)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          "Your List",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF233A66),
          ),
        ),
      ),
      body: Column(
        children: [
          // Tab Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  // Handle Recent Jobs tap
                },
                child: const Text(
                  "Recent Jobs",
                  style: TextStyle(fontSize: 14, color: Color(0xFF233A66)),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Handle Closed jobs tap
                },
                child: const Text(
                  "Closed jobs",
                  style: TextStyle(fontSize: 14, color: Color(0xFF233A66)),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Handle Saved Jobs tap
                },
                child: const Text(
                  "Saved Jobs",
                  style: TextStyle(fontSize: 14, color: Color(0xFF233A66)),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Handle My List tap
                },
                child: const Text(
                  "My List",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF233A66),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          // Underline for "My List"
          Container(width: 50, height: 2, color: const Color(0xFF233A66)),
          const SizedBox(height: 20),

          // Job Cards
          Expanded(
            child: ListView(
              children: const [
                JobCard(
                  image: 'img/event_assistant.png',
                  jobTitle: 'Event Assistant',
                  company: 'SoundWave Events',
                  location: 'Negombo',
                  workingDay: '10 April 2025',
                  time: '5:00 PM - 11:00 PM',
                  payment: 'Rs. 2,000/night',
                ),
                JobCard(
                  image: 'img/gift_wrapper.png',
                  jobTitle: 'Gift Wrapper (Seasonal)',
                  company: 'Star Gifts & Decor',
                  location: 'Galle',
                  workingDay: 'Mon - Fri',
                  time: '10:00 AM - 4:00 PM',
                  payment: 'Rs. 1,200/day',
                  posted: '5 hours ago',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  const JobCard({
    Key? key,
    required this.image,
    required this.jobTitle,
    required this.company,
    required this.location,
    required this.workingDay,
    required this.time,
    required this.payment,
    this.posted,
  }) : super(key: key);

  final String image;
  final String jobTitle;
  final String company;
  final String location;
  final String workingDay;
  final String time;
  final String payment;
  final String? posted;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heart Icon
          const Padding(
            padding: EdgeInsets.only(top: 8.0, right: 8.0),
            child: Icon(Icons.favorite_border, color: Colors.redAccent),
          ),
          // Image
          Image.asset(image, width: 120, height: 120, fit: BoxFit.cover),
          const SizedBox(width: 10),
          // Job Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Job Title: $jobTitle",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF233A66),
                  ),
                ),
                Text(
                  "Company: $company",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF233A66),
                  ),
                ),
                Text(
                  "Location: $location",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF233A66),
                  ),
                ),
                Text(
                  "Working Day: $workingDay",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF233A66),
                  ),
                ),
                Text(
                  "Time: $time",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF233A66),
                  ),
                ),
                Text(
                  "Payment: $payment",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF233A66),
                  ),
                ),
                if (posted != null)
                  Text(
                    "Posted: $posted",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF233A66),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
