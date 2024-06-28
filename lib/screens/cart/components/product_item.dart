import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:interiorx/providers/cart_provider.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String name;
  final String category;
  final double price;
  final String imageUrl;

  const ProductItem({super.key, 
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Card(
      child: ListTile(
        leading: Image.network(imageUrl),
        title: Text(name),
        subtitle: Text('$category - \$$price'),
        trailing: IconButton(
          icon: const Icon(Icons.add_shopping_cart),
          onPressed: () {
            cartProvider.addProduct(
              CartItem(
                id: id,
                name: name,
                category: category,
                price: price,
                imageUrl: imageUrl,
              ),
            );
          },
        ),
      ),
    );
  }
}
