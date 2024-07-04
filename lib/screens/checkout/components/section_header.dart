import 'package:flutter/material.dart';
import 'package:interiorx/constants.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SectionHeader({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        GestureDetector(
          onTap: onTap,
          child: const Text('Change', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }
}
