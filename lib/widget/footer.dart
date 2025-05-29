import 'package:flutter/material.dart';
import 'package:jobflex/chat/chat.dart'; // Import the Chat page
import 'package:jobflex/footer_pages/notification_page.dart';
import 'package:jobflex/screan/home.dart'; // Import the Home page
import 'package:jobflex/screan/loading_page.dart';
import 'package:jobflex/supportive_pages/help_center.dart'; // Import the Help Center page
import 'package:jobflex/footer_pages/more.dart';
import 'package:jobflex/screan/jobs.dart';

class Footer extends StatefulWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  int _currentIndex = 0;
  DateTime? _lastTapTime;

  void _handleNavigation(int index) {
    // Prevent multiple rapid taps
    final now = DateTime.now();
    if (_lastTapTime != null &&
        now.difference(_lastTapTime!) < const Duration(milliseconds: 500)) {
      return;
    }
    _lastTapTime = now;

    setState(() {
      _currentIndex = index;
    });

    // Navigation logic
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoadingPage(nextPage: Chat())),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoadingPage(nextPage: JobsScreen()),
        ),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoadingPage(nextPage: HomePage()),
        ),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoadingPage(nextPage: NotificationPage()),
        ),
      );
    } else if (index == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoadingPage(nextPage: More())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _handleNavigation,
      backgroundColor: const Color(0xFF233A66),
      selectedItemColor: const Color(0xFFECF1FA),
      unselectedItemColor: const Color(0xFFECF1FA),
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble, color: Color(0xFFECF1FA)),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.work, color: Color(0xFFECF1FA)),
          label: 'Jobs',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Color(0xFFECF1FA)),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications, color: Color(0xFFECF1FA)),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz, color: Color(0xFFECF1FA)),
          label: 'More',
        ),
      ],
    );
  }
}
