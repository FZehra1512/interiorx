import 'package:flutter/material.dart';
import 'package:interiorx/components/custom_card.dart';
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


class CheckoutScreen extends StatelessWidget {
  static String routeName = "/checkout";

  final GlobalKey<ShippingAddressSectionState> _shippingAddressKey = GlobalKey<ShippingAddressSectionState>();
  final GlobalKey<PaymentMethodSectionState> _paymentMethodKey = GlobalKey<PaymentMethodSectionState>();
  final GlobalKey<AmountDetailsSectionState> _amountDetailsKey = GlobalKey<AmountDetailsSectionState>();

  CheckoutScreen({super.key});

  void _placeOrder(BuildContext context, CartProvider cartProvider) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Navigator.pushNamed(context, LoginScreen.routeName);
      return;
    }

    final shippingAddressState = _shippingAddressKey.currentState;
    final paymentMethodState = _paymentMethodKey.currentState;
    final amountDetailsState = _amountDetailsKey.currentState;

    if (shippingAddressState == null || paymentMethodState == null || amountDetailsState == null) {
      Navigator.pushNamed(context, LoginScreen.routeName);
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
      'status': 'Placed',
      'deliveryAddress': deliveryAddress,
      'paymentMethod': paymentMethod,
      'totalAmount': totalOrderAmount,
      'products': products,
      'createdAt': FieldValue.serverTimestamp(),
    };
    await FirebaseFirestore.instance.collection('orders').add(orderData);

    // Pop the current screen
    Navigator.pushNamed(context, OrderCompleteScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final double totalAmount = cartProvider.totalPrice;
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
            // AmountDetailsSection(
            //     key: _amountDetailsKey, totalAmount: totalAmount),
            AmountDetailsSection(totalAmount: totalAmount, key: _amountDetailsKey,),   
            const SizedBox(height: 12),
            ShippingAddressSection(key: _shippingAddressKey),
            const SizedBox(height: 12),
            PaymentMethodSection(key: _paymentMethodKey),

            const SizedBox(height: 12),
            const ApplyVoucherSection(),
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


class ApplyVoucherSection extends StatelessWidget {
  const ApplyVoucherSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Row(
        children: [
          const Expanded(
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                hintText: 'Enter promo code',
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 100,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Apply'),
            ),
          )
        ],
      ),
    );
  }
}




