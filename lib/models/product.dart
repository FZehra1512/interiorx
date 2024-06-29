// lib/models/product_arguments.dart
class ProductArguments {
  final String productName;
  final String productDescription;
  final double productPrice;
  final String imageUrl;
  final double rating;

  ProductArguments({
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.imageUrl,
    required this.rating,
  });
}