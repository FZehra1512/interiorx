import 'package:flutter/material.dart';
import 'package:interiorx/constants.dart';

class CustomCard extends StatelessWidget {
  final Widget child;

  const CustomCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 55, 24, 93).withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(1, 1),
          )
        ],
      ),
      child: child,
    );
  }
}
