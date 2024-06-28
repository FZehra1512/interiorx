import 'package:flutter/material.dart';
import 'package:interiorx/screens/checkout/checkout_screen.dart';
import 'package:interiorx/screens/profile/profile_screen.dart';
import 'package:interiorx/screens/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, CheckoutScreen.routeName);
              },
              child: const Text("Checkout Page"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, ProfileScreen.routeName);
              },
              child: const Text("Profile Page"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context,  HomeScreen.routeName);
              },
              child: const Text("Home Page"),
            ),
          ],
        ),
      ),
    );
  }
}
