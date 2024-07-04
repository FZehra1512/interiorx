import 'package:flutter/material.dart';
import 'package:interiorx/constants.dart';

class ProductCard extends StatelessWidget {
  final String name, desc, img, type, category;
  final double price;

  ProductCard({required this.name, required this.desc, required this.img,
    required this.price, required this.type, required this.category,});

  Widget build(BuildContext context) {
    return Scaffold(body: InkWell(onTap: (){
          // Navigator.push(context, MaterialPageRoute(builder: (context)  =>  );
        },
        child: Card(elevation: 8.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), ),
          child: Container(height: 350, width: 200,
            child: Column(children: [
                Stack(children: [
                    ClipRRect(borderRadius: BorderRadius.vertical(top: Radius.circular(20)), // Match the rounded corners of the Card
                      child: Image.network(img, fit: BoxFit.cover, height: 80, width: double.infinity,),),
                    Positioned(top: 20,
                      child: Container(width: 100, height: 20, color: kPrimaryColor,
                        child: Center(child: Text(type, style: TextStyle(color: Colors.white),),),
                      ),),],),
                Container(color: kPrimaryColor, padding: EdgeInsets.all(4.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Container(width: 100,
                            child: Text(name, softWrap: true, maxLines: 3, style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white,),),),
                          Text('\$${price.toStringAsFixed(2)}', style: TextStyle(color: Colors.white),),
                        ],),
                      SizedBox(height: 4),
                      Text(desc, style: TextStyle(color: Colors.white,),
                        maxLines: 3, overflow: TextOverflow.ellipsis, softWrap: true,),
                    ],),),
            ],),),
        ),),);}}
