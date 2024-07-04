import 'package:flutter/material.dart';
import 'package:interiorx/screens/home/components/search_field.dart';
import 'package:interiorx/screens/search/search_screen.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Expanded(child: SearchField(onSearch: (query) {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => SearchScreen(query: query),),);},
            ),),);}}
