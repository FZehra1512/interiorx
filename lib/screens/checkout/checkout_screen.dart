import 'dart:async';

import 'package:flutter/material.dart';
import 'package:interiorx/components/custom_card.dart';
import 'package:interiorx/constants.dart';
import 'package:interiorx/screens/checkout/components/amount_details.dart';
import 'package:interiorx/screens/checkout/components/complete_order.dart';
import 'package:interiorx/screens/login/login.dart';
import '/screens/checkout/components/payment_method.dart';
import '/screens/checkout/components/shipping_address.dart';
import 'package:interiorx/theme.dart';
import 'package:interiorx/screens/checkout/components/order_items.dart';
import 'package:provider/provider.dart';
import 'package:interiorx/providers/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class CheckoutScreen extends StatefulWidget {
  static String routeName = "/checkout";
  const CheckoutScreen({super.key});

  @override
  CheckoutScreenState createState() => CheckoutScreenState();
}

class CheckoutScreenState extends State<CheckoutScreen> {
  final GlobalKey<ShippingAddressSectionState> _shippingAddressKey =
      GlobalKey<ShippingAddressSectionState>();
  final GlobalKey<PaymentMethodSectionState> _paymentMethodKey =
      GlobalKey<PaymentMethodSectionState>();
  final GlobalKey<AmountDetailsSectionState> _amountDetailsKey =
      GlobalKey<AmountDetailsSectionState>();

  double _totalAmount = 0.0;
  final _voucherController = TextEditingController();
  final _voucherCodes = {
    'VOUCHER10': 0.1, // 10% discount
    'VOUCHER20': 0.2, // 20% discount
    'VOUCHER30': 0.3, // 30% discount
  };

  @override
  void initState() {
    super.initState();
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    _totalAmount = cartProvider.totalPrice;
  }

  void _applyVoucher() {
    final voucherCode = _voucherController.text.toUpperCase();
    if (_voucherCodes.containsKey(voucherCode)) {
      final discountPercentage = _voucherCodes[voucherCode]!;
      final discountAmount = _totalAmount * discountPercentage;
      final newTotalAmount = _totalAmount - discountAmount;

      // Update the totalAmount
      setState(() {
        _totalAmount = newTotalAmount;
      });

      // Show discount snackbar for 3 seconds
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: kTextColor,
          padding: const EdgeInsets.all(8.0),
          content: SizedBox(
            width: 400,
            child: Column(
              children: [
                Text('You got ${discountPercentage * 100}% discount!', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),), 
                Text('Your Subtotal is now ${_totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                )
              ],),
          ),
          duration: const Duration(seconds: 5),
        ),
      );

      // Clear the voucher code text field
      _voucherController.clear();
    } else {
      // Show error message if the voucher code is invalid
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid voucher code')),
      );
    }
  }

  void _placeOrder(BuildContext context, CartProvider cartProvider) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      return;
    }

    final shippingAddressState = _shippingAddressKey.currentState;
    final paymentMethodState = _paymentMethodKey.currentState;
    final amountDetailsState = _amountDetailsKey.currentState;

    if (shippingAddressState == null ||
        paymentMethodState == null ||
        amountDetailsState == null) {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      return;
    }

    Map<String, dynamic>? deliveryAddress = shippingAddressState.getAddress();
    String paymentMethod = paymentMethodState.getPaymentMethod();
    double totalOrderAmount = amountDetailsState.getTotalAmount();
    List<Map<String, dynamic>> products = cartProvider.cartItems.map((item) {
      return {
        'id': item.id,
        'name': item.name,
        'price': item.price,
        'quantity': item.quantity,
      };
    }).toList();

    final orderData = {
      'userId': user.uid,
      'status': 'Order Placed',
      'deliveryAddress': deliveryAddress,
      'paymentMethod': paymentMethod,
      'totalAmount': totalOrderAmount,
      'products': products,
      'createdAt': FieldValue.serverTimestamp(),
    };
    await FirebaseFirestore.instance.collection('orders').add(orderData);

    // Pop the current screen
    Future.delayed(const Duration(milliseconds: 100), () {
      cartProvider.clearCart();
    });
    Navigator.pushReplacementNamed(context, OrderCompleteScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: buildBackIconButton(context),
        title: const Text(
          'Checkout',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [

            OrderItemsSection(cartProvider: cartProvider),
            const SizedBox(height: 12),
            AmountDetailsSection(
              totalAmount: _totalAmount,
              key: _amountDetailsKey,
            ),
            const SizedBox(height: 12),
            ShippingAddressSection(key: _shippingAddressKey),
            const SizedBox(height: 12),
            PaymentMethodSection(key: _paymentMethodKey),
            const SizedBox(height: 12),


            // Apply Voucher 
            CustomCard(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _voucherController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                        hintText: 'Enter promo code',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: _applyVoucher,
                      child: const Text('Apply'),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 22),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: BottomAppBar(
          elevation: 0.0,
          height: 90,
          padding: const EdgeInsets.only(
              top: 18.0, bottom: 18.0, left: 26.0, right: 26.0),
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () => _placeOrder(context, cartProvider),
              child: const Text(
                'Complete Order',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

