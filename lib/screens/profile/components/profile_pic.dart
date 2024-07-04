import 'package:flutter/material.dart';
import 'package:interiorx/constants.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: kPrimaryColor,
      child: Icon(
        Icons.account_circle,
        size: 150,
        color: Colors.white,
      ),
      maxRadius: 80,
    );
  }
}
