import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontSize: 22),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(12),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 25,
          ),
          onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
        ),
      ),
      toolbarHeight: 120,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}
