import 'package:flutter/material.dart';
import 'package:interiorx/constants.dart';
import 'package:interiorx/screens/home/home_screen.dart';
import 'package:interiorx/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:interiorx/providers/cart_provider.dart';
class OrderCompleteScreen extends StatelessWidget {
  static const routeName = '/orderComplete';

  const OrderCompleteScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: kPrimaryColor,
              size: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              'Thank you for your order!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Your order has been placed successfully. We will notify you once it is on the way.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                cartProvider.clearCart();
                Navigator.pushNamed(context, HomeScreen.routeName);
              },
              child: const Text(
                'Shop',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
