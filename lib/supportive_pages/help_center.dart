import 'package:flutter/material.dart';
import 'package:jobflex/widget/footer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HelpCenterPage(),
    );
  }
}

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDAE3F3), // Light blue background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button & Title
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Help center",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF233A66), // Navy Blue
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              const Text(
                "We’re here to help you with anything & everything on JOBFLEX .",
                style: TextStyle(
                  color: Color(0xFF233A66), // Navy Blue
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 16),

              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Search your Issue",
                    hintStyle: TextStyle(
                      color: Color(0xFFB9B9B9), // Ash
                    ),
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Help Options
              const HelpOption(icon: Icons.help_outline, label: "FAQs"),
              const HelpOption(icon: Icons.mail_outline, label: "Contact Us"),
              const HelpOption(
                icon: Icons.payment_outlined,
                label: "Payment Issues",
              ),
              const HelpOption(
                icon: Icons.account_circle_outlined,
                label: "Account Issues",
              ),
              const HelpOption(
                icon: Icons.description_outlined,
                label: "Terms & policies",
              ),

              const SizedBox(height: 20),

              // Trending Questions
              const Text(
                "Trending question?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF233A66), // Navy Blue
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              const TrendingQuestion(text: "How to apply a job?"),
              const TrendingQuestion(text: "How do I get paid?"),
              const TrendingQuestion(text: "How to reset my password?"),
              const TrendingQuestion(text: "Why is my account under review?"),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}

class HelpOption extends StatelessWidget {
  final IconData icon;
  final String label;

  const HelpOption({required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF233A66)),
      title: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF233A66),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {},
    );
  }
}

class TrendingQuestion extends StatelessWidget {
  final String text;

  const TrendingQuestion({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFFB9B9B9), // Ash color
        ),
      ),
    );
  }
}
