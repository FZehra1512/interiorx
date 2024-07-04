import 'package:flutter/material.dart';
import 'package:interiorx/screens/cart/cart_screen.dart';
import 'package:interiorx/screens/cart/demo_product_UI.dart';
import 'package:interiorx/screens/checkout/checkout_screen.dart';
import 'package:interiorx/screens/login/login.dart';
import 'package:interiorx/screens/profile/profile_screen.dart';
import 'package:interiorx/models/product.dart';
import 'package:interiorx/screens/product/components/product_description_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  const SplashScreen({super.key});
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentPage = 0;

  Future<Product> fetchProduct() async {
    DocumentSnapshot document = await FirebaseFirestore.instance.collection('products').doc('DP0001').get();
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
              onPressed: () {Navigator.pushNamed(context, CheckoutScreen.routeName);},
              child: const Text("Checkout Page"),),
            const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, DemoProductUIScreen.routeName);
              },
              child: const Text("Demo Product UI for Cart"),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
              child: const Text("Cart"),
            ),
            ElevatedButton(
              onPressed: () {Navigator.pushNamed(context, ProfileScreen.routeName);},
              child: const Text("Profile Page"),),
            ElevatedButton(
              onPressed: () {Navigator.pushNamed(context, LoginScreen.routeName);},
              child: const Text("Login Page"),),
          ],
        ),
      ),
    );
  }
}