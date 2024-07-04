import 'package:flutter/material.dart';
import 'package:interiorx/screens/cart/cart_screen.dart';
import 'package:interiorx/screens/cart/demo_product_UI.dart';
import 'package:interiorx/screens/checkout/checkout_screen.dart';
import 'package:interiorx/screens/login/login.dart';
import 'package:interiorx/screens/profile/profile_screen.dart';
import 'package:interiorx/models/product.dart';
import 'package:interiorx/screens/product/components/product_description_screen.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  const SplashScreen({super.key});
  State<SplashScreen> createState() => _SplashScreenState();}

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
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.routeName);
              },
              child: const Text("Login Page"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  ProductDescriptionScreen.routeName,
                  arguments: ProductArguments(
                    productName: 'Decorative Wall Pannel',
                    productDescription: 'Elevate your interior with sophisticated and stylish wall panels, perfect for adding texture and visual interest to any space."',
                    productPrice: 50,
                    imageUrl: 'https://tse1.mm.bing.net/th?id=OIP.5laJbazcaMnI8wNtHnwZ0AHaHa&pid=Api&P=0&h=220', // Replace with actual image URL
                    rating: 4.5,
                  ),
                );
              },
              child: const Text("Product Description Page"),
            ),
          ],
        ),
      ),
    );
  }
}