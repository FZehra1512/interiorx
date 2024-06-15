import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  static String routeName = "/checkout";
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Center(
        child: const Text('Welcome to Checkout Screen'),
      ),
    );
  }
}
