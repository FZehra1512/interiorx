import 'dart:async';

import 'package:flutter/material.dart';
import 'package:interiorx/constants.dart';
import 'package:interiorx/screens/cart/cart_screen.dart';
import 'package:interiorx/screens/cart/demo_product_UI.dart';
import 'package:interiorx/screens/checkout/checkout_screen.dart';
import 'package:interiorx/screens/home/home_screen.dart';
import 'package:interiorx/screens/login/login.dart';
import 'package:interiorx/screens/profile/profile_screen.dart';
import 'package:interiorx/models/product.dart';
import 'package:interiorx/screens/product/components/product_description_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _startProgress();
    Timer(const Duration(seconds: 5), () {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.pushReplacementNamed(
            context, PagesAvailibityButtonScreen.routeName);
      } else {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
    });
  }

  void _startProgress() {
    Timer.periodic(const Duration(milliseconds: 50), (Timer timer) {
      setState(() {
        if (_progress >= 1.0) {
          timer.cancel();
        } else {
          _progress +=
              0.015; // Adjusting the increment to ensure it fills in 5 seconds
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: kPrimaryGradientColor,
            ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/InteriorX.png",
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 24,),
                  const Text(
                    'InteriorX',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 38,
                    ),
                  ),
                ],
              )
            ),
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: _progress,
                  minHeight: 12.0,
                  backgroundColor: kTextColor,
                  valueColor: const AlwaysStoppedAnimation(kPrimaryLightColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PagesAvailibityButtonScreen extends StatefulWidget {
  static String routeName = "/pages-buttons";

  const PagesAvailibityButtonScreen({super.key});
  State<PagesAvailibityButtonScreen> createState() =>
      _PagesAvailibityButtonScreenState();
}

class _PagesAvailibityButtonScreenState
    extends State<PagesAvailibityButtonScreen> {
  int currentPage = 0;

  Future<Product> fetchProduct() async {
    DocumentSnapshot document = await FirebaseFirestore.instance
        .collection('products')
        .doc('DP0001')
        .get();
    return Product.fromMap(document.data() as Map<String, dynamic>);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                Product product = await fetchProduct();
                Navigator.pushNamed(
                  context,
                  ProductDescriptionScreen.routeName,
                  arguments: product,
                );
              },
              child: const Text("Product Description Page"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, CheckoutScreen.routeName);
              },
              child: const Text("Checkout Page"),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, DemoProductUIScreen.routeName);
              },
              child: const Text("Demo Product UI for Cart"),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
              child: const Text("Cart"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, ProfileScreen.routeName);
              },
              child: const Text("Profile Page"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.routeName);
              },
              child: const Text("Login Page"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, HomeScreen.routeName);
              },
              child: const Text("Home Page"),
            ),
          ],
        ),
      ),
    );
  }
}
