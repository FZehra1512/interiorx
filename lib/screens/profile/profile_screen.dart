import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:interiorx/components/custom_app_bar.dart';
import 'package:interiorx/screens/profile/components/menu_card.dart';
import 'package:interiorx/screens/profile/components/profile_pic.dart';
import 'package:interiorx/screens/profile/help_center.dart';
import 'package:interiorx/screens/profile/my_account.dart';
import 'package:interiorx/screens/profile/my_orders.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 20),
            MenuCard(
              text: "My Account",
              icon: Icon(Icons.person),
              press: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyAccount()))
              },
            ),
            MenuCard(
              text: "My Orders",
              icon: Icon(Icons.add_box),
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyOrders()));
              },
            ),
            // MenuCard(
            //   text: "Settings",
            //   icon: Icon(Icons.settings),
            //   press: () {},
            // ),
            MenuCard(
              text: "Help Center",
              icon: Icon(Icons.help_center),
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HelpCenter()));
              },
            ),
            MenuCard(
              text: "Log Out",
              icon: Icon(Icons.logout),
              press: () async {
                await FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
