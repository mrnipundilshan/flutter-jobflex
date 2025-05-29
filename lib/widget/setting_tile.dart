import 'package:flutter/material.dart';
import 'package:jobflex/models/setting.dart';
import 'package:jobflex/screan/loading_page.dart';
import 'package:jobflex/supportive_pages/about.dart';
import 'package:jobflex/supportive_pages/help_center.dart';
import 'package:jobflex/supportive_pages/invite_friend.dart';
import 'package:jobflex/supportive_pages/setting_page.dart';
import 'package:jobflex/payment/payment.dart';

class SettingTile extends StatelessWidget {
  final Setting setting;
  const SettingTile({Key? key, required this.setting}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        switch (setting.route) {
          case '/settingpage':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoadingPage(nextPage: SettingPage()),
              ),
            );
            break;
          case '/payment':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PaymentScreen()),
            );
            break;
          case '/invitefriend':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InviteFriend()),
            );
            break;
          case '/aboutus':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => About()),
            );
            break;

          case '/helpcenter':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HelpCenterPage()),
            );
            break;

          case '/privacy':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => About()),
            );
            break;
          // Add other routes as needed
          default:
            // Handle unknown routes
            break;
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(setting.icon, color: const Color(0xFF233A66)),
                const SizedBox(width: 20),
                Text(
                  setting.title,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF233A66),
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios_sharp, color: Color(0xFF233A66)),
          ],
        ),
      ),
    );
  }
}
