import 'package:flutter/material.dart';
import 'package:interiorx/constants.dart';
import 'package:provider/provider.dart';
import 'package:interiorx/screens/cart/cart_screen.dart';
import 'package:interiorx/providers/cart_provider.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return IconButton(
      icon: Stack(
        children: [
          const Icon(
            Icons.shopping_cart_outlined,
            size: 32,
            color: kTextColor,
          ),
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
            ),
        ],
      ),
      onPressed: () {
        Navigator.pushNamed(context, CartScreen.routeName);
      },
    );
  }
}
