// // lib/models/product_arguments.dart
// class ProductArguments {
//   final String productName;
//   final String productDescription;
//   final double productPrice;
//   final String imageUrl;
//   final double rating;
//
//   ProductArguments({
//     required this.productName,
//     required this.productDescription,
//     required this.productPrice,
//     required this.imageUrl,
//     required this.rating,
//   });
// }

// lib/models/product.dart

class Review {
  final String comment;
  final DateTime date;
  final String username;

  Review({
    required this.comment,
    required this.date,
    required this.username,
  });

  factory Review.fromMap(Map<String, dynamic> data) {
    return Review(
      comment: data['comment'] ?? '',
      date: (data['date']?? '').toDate(),
      username: data['username'] ?? '',
    );
  }
}

class Product {
  final String productName;
  final String productDescription;
  final double productPrice;
  final double salePerc;
  final String imageUrl;
  final double rating;
  final List<Review> reviews;
  final String status; // New field for product status

  Product({
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.salePerc,
    required this.imageUrl,
    required this.rating,
    required this.reviews,
    required this.status, // Initialize status in constructor
  });

  factory Product.fromMap(Map<String, dynamic> data) {
    List<Review> reviews = [];
    if (data['reviews'] != null) {
      data['reviews'].forEach((key, value) {
        reviews.add(Review.fromMap(value));
      });
    }

    return Product(
      productName: data['pd_name'] ?? '',
      productDescription: data['pd_desc'] ?? '',
      productPrice: data['price'] ?? 0.0,
      salePerc: data['sale_perc'] ?? 0.0,
      imageUrl: data['pd_img'] ?? '',
      rating: data['ratings'] ?? 0.0,
      reviews: reviews,
      status: data['status'] ?? '', // Assign status from data
    );
  }
}
