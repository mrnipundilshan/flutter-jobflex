import 'package:flutter/material.dart';
import 'package:jobflex/auth/auth.dart';
import 'package:jobflex/models/setting.dart';
import 'package:jobflex/widget/footer.dart';
import 'package:jobflex/widget/promoter_footer.dart';
import 'package:jobflex/widget/setting_tile.dart';
import 'package:jobflex/profile/promotor_profile.dart'; // Import the PromotorProfile page
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminMore extends StatefulWidget {
  const AdminMore({super.key});

  @override
  State<AdminMore> createState() => _AdminMoreState();
}

class _AdminMoreState extends State<AdminMore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF233A66)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "More",
          style: TextStyle(fontSize: 20, color: Color(0xFF233A66)),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PromotorProfile(),
                    ), // Navigate to PromotorProfile
                  );
                },
                child: const AvatarCard(),
              ),
              const SizedBox(height: 20),
              Column(
                children: List.generate(
                  settings.length,
                  (index) => Column(
                    children: [
                      SettingTile(setting: settings[index]),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    AuthService().signOut();
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xFF233A66),
                  ),
                  child: const Text("Sign Out"),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const PromoterFooter(),
    );
  }
}

class AvatarCard extends StatefulWidget {
  const AvatarCard({super.key});

  @override
  State<AvatarCard> createState() => _AvatarCardState();
}

class _AvatarCardState extends State<AvatarCard> {
  String userName = '';
  String userRole = '';

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
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
          userRole = userDoc.data()?['role'] ?? '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset('img/supermarket.png', scale: 5),
        ),
        const SizedBox(width: 23),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName.isEmpty ? "Loading..." : userName,
              style: const TextStyle(fontSize: 25, color: Color(0xFF233A66)),
            ),
            Text(
              userRole.isEmpty ? "Loading..." : "I am a $userRole",
              style: const TextStyle(fontSize: 12, color: Color(0xFF233A66)),
            ),
          ],
        ),
      ],
    );
  }
}
