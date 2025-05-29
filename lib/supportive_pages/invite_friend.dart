import 'package:flutter/material.dart';
import 'package:jobflex/widget/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InviteFriend extends StatelessWidget {
  const InviteFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InviteFriendScreen(),
    );
  }
}

class InviteFriendScreen extends StatefulWidget {
  const InviteFriendScreen({super.key});

  @override
  State<InviteFriendScreen> createState() => _InviteFriendScreenState();
}

class _InviteFriendScreenState extends State<InviteFriendScreen> {
  final int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF233A66),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                color: Color(0xFFDAE3F3),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
          ),
          Positioned(
            top:
                MediaQuery.of(context).size.height *
                0.1, // Restored position for arrow and title
            left: screenWidth * 0.1,
            right: screenWidth * 0.1,
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.arrow_back, color: Color(0xFF2B3A67)),
                    SizedBox(width: 65),
                    Text(
                      "Invite Friend",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF2B3A67),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ), // Added space between header and invite card
                Image.asset(
                  'assets/invite_illustration.jpg',
                  height: MediaQuery.of(context).size.height * 0.32,
                  width: screenWidth * 0.8,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: screenWidth * 0.8,
                  color: const Color(0xFF3A4F88),
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                  ), // Increased padding for more space
                  child: Column(
                    children: [
                      const Text(
                        "Invite Your Friends",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ), // Increased space between text and button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDCE6F2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 10,
                          ),
                          child: Text(
                            "Invite",
                            style: TextStyle(
                              color: Color(0xFF294378),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top:
                MediaQuery.of(context).size.height *
                0.68, // Further lowered position for "Share"
            left: screenWidth * 0.1,
            right: screenWidth * 0.1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Share",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: const [
                        SocialIcon(
                          icon: FontAwesomeIcons.whatsapp,
                          color: Colors.green,
                        ),
                        SizedBox(height: 10),
                        SocialIcon(
                          icon: FontAwesomeIcons.twitter,
                          color: Colors.lightBlue,
                        ),
                      ],
                    ),
                    Column(
                      children: const [
                        SocialIcon(
                          icon: FontAwesomeIcons.facebookF,
                          color: Colors.blue,
                        ),
                        SizedBox(height: 10),
                        SocialIcon(
                          icon: FontAwesomeIcons.envelope,
                          color: Colors.purple,
                        ),
                      ],
                    ),
                    const SocialIcon(
                      icon: FontAwesomeIcons.instagram,
                      color: Colors.pink,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SocialIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const SocialIcon({super.key, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color,
      radius: 25,
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}
