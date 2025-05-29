import 'package:flutter/material.dart';
import 'package:jobflex/widget/constants.dart';
import 'package:jobflex/widget/footer.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: JPrimaryLightColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF233A66)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Settings",
          style: TextStyle(fontSize: 20, color: Color(0xFF233A66)),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Container(
            height: 350,
            decoration: BoxDecoration(
              color: JPrimaryLightColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                SettingsItem(icon: Icons.language, title: 'Languages'),
                SettingsItem(icon: Icons.settings, title: 'Account Settings'),
                SettingsItem(
                  icon: Icons.notifications,
                  title: 'Notification Preferences',
                ),
                SettingsItem(icon: Icons.delete, title: 'Delete My Account'),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromRGBO(30, 50, 92, 1),
      bottomNavigationBar: const Footer(),
    );
  }
}

class SettingsItem extends StatelessWidget {
  const SettingsItem({super.key, required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 15, 30, 25),
      child: Row(
        children: [
          Icon(icon, color: JPrimaryColor),
          const SizedBox(width: 20),
          Text(title, style: TextStyle(fontSize: 16, color: JPrimaryColor)),
        ],
      ),
    );
  }
}
