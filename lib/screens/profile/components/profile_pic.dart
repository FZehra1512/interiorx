import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Icon(
        Icons.person,
        size: 70,
      ),
      maxRadius: 50,
    );
  }
}
