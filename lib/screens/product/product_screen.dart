import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/product_card.dart';

class ProductScreen extends StatelessWidget {
  final String category, type;
  ProductScreen({required this.category, required this.type});
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Screen'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: (type == 'regular')
            ? FirebaseFirestore.instance
                .collection('products')
                .where('category', isEqualTo: category)
                .snapshots()
            : FirebaseFirestore.instance
                .collection('products')
                .where('type', isEqualTo: type)
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No products found'));
          }
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.0,
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                return ProductCard(
                  id: snapshot.data!.docs[index].id,
                  name: data['pd_name'] ?? 'No Name',
                  desc: data['pd_desc'] ?? 'No Description',
                  img: data['pd_img'] ?? 'https://via.placeholder.com/150',
                  price: (data['price'] != null)
                      ? (data['price'] as num).toDouble()
                      : 0.0,
                  type: data['type'] ?? 'regular',
                  category: data['category'] ?? 'Unknown',
                );
              },
            ),
          );
        },
      ),
    );
  }
}
