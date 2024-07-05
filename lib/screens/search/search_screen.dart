import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/product_card.dart';

class SearchScreen extends StatelessWidget {final String query;
  const SearchScreen({Key? key, required this.query}) : super(key: key);
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Search Results'),),
      body: SearchResults(query: query),);}}

class SearchResults extends StatelessWidget {final String query;
  const SearchResults({Key? key, required this.query}) : super(key: key);
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('products')
          .where('pd_name', isGreaterThanOrEqualTo: query)
          .where('pd_name', isLessThanOrEqualTo: query + '\uf8ff').get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());}
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));}
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No results found.'));}
        return Padding(padding: const EdgeInsets.all(20.0),
          child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, childAspectRatio: 0.75,),
            itemCount: snapshot.data!.docs.length, itemBuilder: (context, index) {
              var data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
              return ProductCard(
                id: snapshot.data!.docs[index].id,
                name: data['pd_name'] ?? 'No Name',
                desc: data['pd_desc'] ?? 'No Description',
                img: data['pd_img'] ?? 'https://via.placeholder.com/150',
                price: (data['price'] != null) ? (data['price'] as num).toDouble() : 0.0,
                type: data['type'] ?? 'regular',
                category: data['category'] ?? 'Unknown',);},
          ),);
      },);}}
