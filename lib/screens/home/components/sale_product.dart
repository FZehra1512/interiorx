import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math'; // Import the math library for the min function
import '../../../components/product_card.dart';

class SaleProduct extends StatelessWidget {
  final String type = "sale";

  const SaleProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products')
          .where('type', isEqualTo: type).snapshots(),
      builder: (context, snapshot) {
        print("sale");
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No products found'));
        }
        final itemCount = min(snapshot.data!.docs.length, 5); // Ensure itemCount does not exceed 5
        return Expanded(
          child: ListView.builder(shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  var data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  return ProductCard(
                    id: snapshot.data!.docs[index].id,
                    name: data['pd_name'] ?? 'No Name',
                    desc: data['pd_desc'] ?? 'No Description',
                    img: data['pd_img'] ?? 'https://via.placeholder.com/150',
                    price: (data['price'] != null) ? (data['price'] as num).toDouble() : 0.0,
                    type: data['type'] ?? 'regular',
                    category: data['category'] ?? 'Unknown',
                  );
                },

          ),
        );
      },
    );
  }
}
