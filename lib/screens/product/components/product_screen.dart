import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interiorx/constants.dart';
import 'package:interiorx/models/product.dart';

class ProductDescriptionScreen extends StatelessWidget {
  static String routeName = "/product_description";

  const ProductDescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductArguments args = ModalRoute.of(context)!.settings.arguments as ProductArguments;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.48,
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          // borderRadius: BorderRadius.only(
                          //   bottomLeft: Radius.circular(50),
                          //   bottomRight: Radius.circular(50),
                          // ),
                          child: Image.network(
                            args.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 30,
                        left: 20,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      Positioned(
                        top: 30,
                        right: 20,
                        child: IconButton(
                          icon: Icon(Icons.favorite_border, color: Colors.white),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40.0),
                    boxShadow: [
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
                        args.productName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        args.productDescription,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Price: \$${args.productPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                args.rating.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex:6,
                            child: ElevatedButton(
                              onPressed: () {
                                // Add to cart logic
                              },
                              child: const Text('Add to Cart'),
                            ),
                          ),
                          Expanded(
                            flex: 0,
                            child: SizedBox(width:3),
                          ),
                          Expanded(
                            flex:1,
                            child: ElevatedButton(
                              onPressed: () {
                                // Add to cart logic
                              },
                              child: Icon(Icons.camera_alt),
                            ),
                          ),
                        ],
                      ),
                    ],
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
