import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:interiorx/providers/cart_provider.dart';
import 'package:interiorx/screens/cart/cart_screen.dart';
import 'package:interiorx/screens/cart/components/product_item.dart';
import 'package:interiorx/constants.dart';

class DemoProductUIScreen extends StatelessWidget {
  static String routeName = "/demoProductUIScreen";

  const DemoProductUIScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products', style: headingStyle),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart_outlined, size: 32,),
                if (cartProvider.cartItems.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red.shade400,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        '${cartProvider.totalQuantity}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
              ],
            ),
            onPressed: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            },
          ),
        ],
      ),
      body: ListView(
        children: const [
          ProductItem(
            id: '1',
            name: 'Product 1',
            category: 'Category 1',
            price: 29.99,
            imageUrl: 'https://static-01.daraz.pk/p/f8be3f6f3a628330b7b9580aca1a7988.jpg',
          ),
          ProductItem(
            id: '2',
            name: 'Product 2',
            category: 'Category 2',
            price: 19.99,
            imageUrl: 'https://static-01.daraz.pk/p/f8be3f6f3a628330b7b9580aca1a7988.jpg',
          ),
          ProductItem(
            id: '3',
            name: 'Product 3',
            category: 'Category 2',
            price: 19.99,
            imageUrl:
                'https://static-01.daraz.pk/p/f8be3f6f3a628330b7b9580aca1a7988.jpg',
          ),
          ProductItem(
            id: '4',
            name: 'Product 4',
            category: 'Category 2',
            price: 19.99,
            imageUrl:
                'https://static-01.daraz.pk/p/f8be3f6f3a628330b7b9580aca1a7988.jpg',
          ),
          ProductItem(
            id: '5',
            name: 'Product 5',
            category: 'Category 2',
            price: 19.99,
            imageUrl:
                'https://static-01.daraz.pk/p/f8be3f6f3a628330b7b9580aca1a7988.jpg',
          ),
        ],
      ),
    );
  }
}
