import 'package:flutter/material.dart';
import 'components/categories.dart';
import 'components/sale.dart';
import '../../components/home_header.dart';
import 'components/highlights.dart';
import '../../components/recommendations.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  const HomeScreen({super.key});
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(
        child: SingleChildScrollView(padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(children: [HomeHeader(),
              Categories(), SizedBox(height: 20,),
              Sale(), SizedBox(height: 20,),
              Highlights(), SizedBox(height: 20,),
              Recommendations(),],),),
      ),);}}

