import 'package:flutter/material.dart';
import 'package:interiorx/constants.dart';
import 'package:interiorx/screens/product/product_screen.dart';

class Recommendations extends StatelessWidget {
  const Recommendations({Key? key,}) : super(key: key);
  Widget build(BuildContext context) {
    return InkWell(onTap: (){Navigator.push(context, MaterialPageRoute(
        builder: (context)  => ProductScreen(category: "", type: "popular")));},
      child: Container(width: double.infinity, margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16,),
        decoration: BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.circular(20),),
        child: Stack(children: [const Text.rich(TextSpan(style: TextStyle(color: Colors.white),
            children: [TextSpan(text: 'Bringing you the most ', children: [
              TextSpan(text: 'Popular Products\n', style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20.0, color: kTextColor,),),],),
              TextSpan(text: "Discover the hottest trends and ongoing designs.",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),),],),),
          Positioned(bottom: 0, right: 0,
            child: Icon(Icons.arrow_forward, color: Colors.white,),),],),
      ),);}}

