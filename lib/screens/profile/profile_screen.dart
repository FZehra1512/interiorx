import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:interiorx/screens/profile/components/menu_card.dart';
import 'package:interiorx/screens/profile/components/profile_pic.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.all(100),
          child: Text(
            'Profile',
            style: TextStyle(fontSize: 20),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(30),
          child: const Icon(
            Icons.arrow_back_ios,
            size: 25,
          ),
        ),
        toolbarHeight: 120,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 20),
            MenuCard(
              text: "My Account",
              icon: Icon(Icons.person),
              press: () => {},
            ),
            MenuCard(
              text: "Notifications",
              icon: Icon(Icons.notification_important),
              press: () {},
            ),
            MenuCard(
              text: "Settings",
              icon: Icon(Icons.settings),
              press: () {},
            ),
            MenuCard(
              text: "Help Center",
              icon: Icon(Icons.help_center),
              press: () {},
            ),
            MenuCard(
              text: "Log Out",
              icon: Icon(Icons.logout),
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}
