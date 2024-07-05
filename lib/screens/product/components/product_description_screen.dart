import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interiorx/components/cart_icon_button.dart';
import 'package:interiorx/constants.dart';
import 'package:interiorx/models/product.dart';
import 'package:interiorx/screens/cart/cart_screen.dart';
import 'package:interiorx/screens/cart/components/product_item.dart';
import 'package:provider/provider.dart';
import 'package:interiorx/providers/cart_provider.dart';

class ProductDescriptionScreen extends StatelessWidget {
  static String routeName = "/product_description";

  const ProductDescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.48,
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          top: 10,
                          bottom: 50,
                          left: 10,
                          right: 10,
                          child: ClipRRect(
                            child: Image.network(
                              product.imageUrl,
                              fit: BoxFit.fitHeight,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                    child: Text('Image not available'));
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          top: 30,
                          left: 20,
                          child: IconButton(
                            icon:
                                const Icon(Icons.arrow_back, color: kTextColor),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                        const Positioned(
                          top: 30,
                          right: 20,
                          child: CartButton()
                        ),
                      ],
                    ),
                  ),
                  Container(
                    transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, -5),
                          blurRadius: 15.0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.productName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.productDescription,
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      '\$${(product.productPrice * (1 - product.salePerc / 100)).toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (product.salePerc > 0)
                                      Text(
                                        ' ( \$${product.productPrice.toStringAsFixed(2)})',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    if (product.salePerc > 0)
                                      Text(
                                        ' -${product.salePerc}%',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  product.rating.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${product.status}',
                          style: TextStyle(
                            color: product.status == 'In stock'
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: product.reviews
                              .map((review) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Card(
                                      elevation: 2.0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              review.username,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '${review.date.day}/ ${review.date.month}/ ${review.date.year}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(review.comment),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 6,
                  child: ElevatedButton(
                    onPressed: () {
                      cartProvider.addProduct(
                        CartItem(
                          id: product.id,
                          name: product.productName,
                          category: product.category,
                          price: product.productPrice,
                          imageUrl: product.imageUrl,
                        ),
                      );
                    },
                    child: const Text('Add to Cart'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      // Camera button logic
                    },
                    child: const Icon(Icons.camera_alt),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
