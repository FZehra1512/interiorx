import 'package:flutter/material.dart';
import 'package:interiorx/constants.dart';

class ProfilePic extends StatelessWidget {
  final Color backgroundColor;
  final double size;
  final Color iconColor;
  final IconData icon;

  const ProfilePic({
    super.key,
    this.backgroundColor = kPrimaryColor,
    this.size = 150,
    this.iconColor = Colors.white,
    this.icon = Icons.account_circle,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      child: Icon(
        icon,
        size: size,
        color: iconColor,
      ),
      maxRadius: size / 2,
    );
  }
}
