import 'package:flutter/cupertino.dart';

class Setting {
  final String title;
  final String route;
  final IconData icon;

  Setting({required this.title, required this.route, required this.icon});
}

final List<Setting> settings = [
  Setting(
    title: "Settings",
    route: "/settingpage",
    icon: CupertinoIcons.settings,
  ),
  Setting(
    title: "Payment",
    route: "/payment",
    icon: CupertinoIcons.creditcard_fill,
  ),
  Setting(
    title: "invite your friend",
    route: "/invitefriend",
    icon: CupertinoIcons.person_add_solid,
  ),
  Setting(
    title: "About us",
    route: "/aboutus",
    icon: CupertinoIcons.info_circle_fill,
  ),
  Setting(
    title: "Help Center",
    route: "/helpcenter",
    icon: CupertinoIcons.question_circle_fill,
  ),
  Setting(title: "Privacy", route: "/privacy", icon: CupertinoIcons.lock_fill),
];
