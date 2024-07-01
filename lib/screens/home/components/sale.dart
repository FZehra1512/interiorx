import 'package:flutter/material.dart';
import 'package:interiorx/constants.dart';
import 'package:interiorx/screens/product/product_screen.dart';

class Sale extends StatelessWidget {
  const Sale({Key? key,});
  Widget build(BuildContext context) {
    return InkWell(onTap: (){Navigator.push(context, MaterialPageRoute(
        builder: (context)  => ProductScreen(category: "", type: "sale")));},
      child: Container(width: double.infinity, margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16,),
        decoration: BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.circular(20),),
        child: Stack(children: [const Text.rich(TextSpan(style: TextStyle(color: Colors.white),
            children: [TextSpan(text: 'Special Seasonal ', children: [
              TextSpan(text: 'Sale\n', style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20.0, color: kTextColor,),),],),
              TextSpan(text: "Discounts upto 50% on products of all categories",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),),],),),
          Positioned(bottom: 0, right: 0,
            child: Icon(Icons.arrow_forward, color: Colors.white,),),],),
      ),
    );
  }
}