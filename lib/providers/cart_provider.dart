import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];

  CartProvider() {
    _loadCartItems();
  }

  List<CartItem> get cartItems => _cartItems;

  void addProduct(CartItem item) {
    final existingIndex = _cartItems.indexWhere((cartItem) => cartItem.id == item.id);
    if (existingIndex != -1) {
      _cartItems[existingIndex].quantity += item.quantity;
    } else {
      _cartItems.add(item);
    }
    _saveCartItems();
    notifyListeners();
  }

  void removeProduct(String productId) {
    _cartItems.removeWhere((item) => item.id == productId);
    _saveCartItems();
    notifyListeners();
  }

  void updateQuantity(String productId, int quantity) {
    final index = _cartItems.indexWhere((item) => item.id == productId);
    if (index != -1) {
      _cartItems[index].quantity = quantity;
      _saveCartItems();
      notifyListeners();
    }
  }

  void clearCart() async {
    _cartItems.clear();
    _saveCartItems();
    notifyListeners();
  }
  void _saveCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('cart', jsonEncode(_cartItems));
  }

  void _loadCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartString = prefs.getString('cart');
    if (cartString != null) {
      List<dynamic> cartJson = jsonDecode(cartString);
      _cartItems = cartJson.map((json) => CartItem.fromJson(json)).toList();
      notifyListeners();
    }
  }

  double get totalPrice {
    return _cartItems.fold(
        0.0, (total, current) => total + current.price * current.quantity);
  }

  int get totalQuantity {
    return _cartItems.fold(0, (total, current) => total + current.quantity);
  }
}

class CartItem {
  final String id;
  final String name;
  final String category;
  final double price;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
    };
  }
}


// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

// class CartProvider with ChangeNotifier {
//   List<CartItem> _cartItems = [];

//   CartProvider() {
//     _loadCartItems();
//   }

//   List<CartItem> get cartItems => _cartItems;

//   void addProduct(CartItem item) {
//     final existingIndex =
//         _cartItems.indexWhere((cartItem) => cartItem.id == item.id);
//     if (existingIndex != -1) {
//       _cartItems[existingIndex].quantity += item.quantity;
//     } else {
//       _cartItems.add(item);
//     }
//     _saveCartItems();
//     notifyListeners();
//   }

//   void removeProduct(String productId) {
//     _cartItems.removeWhere((item) => item.id == productId);
//     _saveCartItems();
//     notifyListeners();
//   }

//   void updateQuantity(String productId, int quantity) {
//     final index = _cartItems.indexWhere((item) => item.id == productId);
//     if (index != -1) {
//       _cartItems[index].quantity = quantity;
//       _saveCartItems();
//       notifyListeners();
//     }
//   }

//   void clearCart() async {
//     _cartItems.clear();
//     _saveCartItems();
//     notifyListeners();
//   }

//   void _saveCartItems() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('cart', jsonEncode(_cartItems));
//   }

//   void _loadCartItems() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? cartString = prefs.getString('cart');
//     if (cartString != null) {
//       List<dynamic> cartJson = jsonDecode(cartString);
//       _cartItems = cartJson.map((json) => CartItem.fromJson(json)).toList();
//       notifyListeners();
//     }
//   }

//   double get totalPrice {
//     return _cartItems.fold(
//         0.0, (total, current) => total + current.price * current.quantity);
//   }

//   int get totalQuantity {
//     return _cartItems.fold(0, (total, current) => total + current.quantity);
//   }
// }

// class CartItem {
//   final String id;
//   final String name;
//   final String category;
//   final double price;
//   final String imageUrl;
//   int quantity;

//   CartItem({
//     required this.id,
//     required this.name,
//     required this.category,
//     required this.price,
//     required this.imageUrl,
//     this.quantity = 1,
//   });

//   factory CartItem.fromJson(Map<String, dynamic> json) {
//     return CartItem(
//       id: json['id'],
//       name: json['name'],
//       category: json['category'],
//       price: json['price'],
//       imageUrl: json['imageUrl'],
//       quantity: json['quantity'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'category': category,
//       'price': price,
//       'imageUrl': imageUrl,
//       'quantity': quantity,
//     };
//   }
// }

