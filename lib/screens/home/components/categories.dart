import 'package:flutter/material.dart';
import 'package:interiorx/constants.dart';
import 'package:interiorx/screens/product/product_screen.dart';

class Categories extends StatelessWidget {const Categories({super.key});
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": Icons.brush, "text": "Abstract", "category": "painting"},
      {"icon": Icons.photo, "text": "Portrait", "category": "wallpaper"},
      {"icon": Icons.perm_media, "text": "Digital Art", "category": "decore"},
      {"icon": Icons.type_specimen, "text": "Calligraphy", "category": "mat"},];
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
          Container(padding: const EdgeInsets.all(4), height: 40, width: 40,
            decoration: BoxDecoration(color: kSecondaryColor,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [BoxShadow(spreadRadius: 10, blurRadius: 10, color: kBorderColor,),],),
            child: Icon(icon),),
          const SizedBox(height: 20),
          Text(text, textAlign: TextAlign.center, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
          Container(height: 2, width: 80, color: kPrimaryLightColor,),],
      ),);}}
