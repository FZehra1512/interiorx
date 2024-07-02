import 'package:flutter/material.dart';
import 'package:interiorx/components/custom_card.dart';
import 'package:interiorx/constants.dart';


class AmountDetailsSection extends StatelessWidget {
  final double totalAmount;
  const AmountDetailsSection({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    const double shippingFees = 5.50;
    const double platformFees = 0.69;
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Amount', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12.0,),
          AmountDetailRow(title: 'Subtotal', amount: "\$ ${totalAmount.toStringAsFixed(2)}"),
          AmountDetailRow(title: 'Shipping Fee', amount: '\$ ${shippingFees.toStringAsFixed(2)}'),
          AmountDetailRow(title: 'Platform Fee', amount: '\$ ${platformFees.toStringAsFixed(2)}'),
          const Divider(color: kTextColor,),
          AmountDetailRow(
              title: 'Order Total', amount: '\$ ${(totalAmount + shippingFees + platformFees).toStringAsFixed(2)}', isBold: true),
        ],
      ),
    );
  }
}

class AmountDetailRow extends StatelessWidget {
  final String title;
  final String amount;
  final bool isBold;

  AmountDetailRow(
      {super.key,
      required this.title,
      required this.amount,
      this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(fontSize: 15, color: kTextColor,
                  fontWeight: isBold ? FontWeight.w600 : FontWeight.w400)),
          Text(amount,
              style: TextStyle(
                  fontSize: 15,
                  color: kTextColor,
                  fontWeight: isBold ? FontWeight.w600 : FontWeight.w400)),
        ],
      ),
    );
  }
}
