import 'package:flutter/material.dart';
import 'package:interiorx/constants.dart';
import 'package:interiorx/screens/product/product_screen.dart';

class Categories extends StatelessWidget {const Categories({super.key});
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": Icons.brush, "text": "Paintings", "category": "painting"},
      {"icon": Icons.wallpaper, "text": "Wallpaper", "category": "wallpaper"},
      {"icon": Icons.photo_album, "text": "Decoration Pieces", "category": "decore"},
      {"icon": Icons.map, "text": "Mats", "category": "mat"},
      {"icon": Icons.more_horiz, "text": "More"},];
    return Padding(padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(scrollDirection: Axis.horizontal,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
            categories.length,
                (index) => Padding(padding: const EdgeInsets.only(right: 15),
              child: CategoryCard(
                icon: categories[index]["icon"],
                text: categories[index]["text"],
                press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)  =>
                      ProductScreen(category: categories[index]["category"], type: "regular")));},),
            ),),),
      ),);}}

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key, required this.icon,
    required this.text, required this.press,}) : super(key: key);

  final IconData icon; final String text; final GestureTapCallback press;

  Widget build(BuildContext context) {
    return GestureDetector(onTap: press, child: Column(children: [
          Container(padding: const EdgeInsets.all(16), height: 56, width: 56,
            decoration: BoxDecoration(color: kSecondaryColor,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [BoxShadow(spreadRadius: 10, blurRadius: 10, color: kBorderColor,),],),
            child: Icon(icon),),
          const SizedBox(height: 20),
          Text(text, textAlign: TextAlign.center),
          Container(height: 2, width: 120, color: kPrimaryLightColor,),],
      ),);}}
