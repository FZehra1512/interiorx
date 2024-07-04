import 'package:flutter/material.dart';
import 'package:interiorx/components/custom_card.dart';
import 'package:interiorx/constants.dart';


class AmountDetailsSection extends StatefulWidget {
  final GlobalKey<AmountDetailsSectionState> key;
  final double totalAmount;
  const AmountDetailsSection({required this.totalAmount, required this.key}) : super(key: key);

  @override
  AmountDetailsSectionState createState() => AmountDetailsSectionState();
}

class AmountDetailsSectionState extends State<AmountDetailsSection> {
double orderTotalAmount = 0;

  @override
  void initState() {
    super.initState();
    _calculateOrderTotal();
  }

  void _calculateOrderTotal() {
    const double shippingFees = 150.0;
    const double platformFees = 11.99;
    setState(() {
      orderTotalAmount = widget.totalAmount + shippingFees + platformFees;
    });
  }

  double getTotalAmount() {
    return orderTotalAmount;
  }
  @override
  void didUpdateWidget(covariant AmountDetailsSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.totalAmount != widget.totalAmount) {
      _calculateOrderTotal();
    }
  }

  @override
  Widget build(BuildContext context) {
    const double shippingFees = 150.0;
    const double platformFees = 11.99;

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Amount',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12.0),
          AmountDetailRow(
              title: 'Subtotal',
              amount: "Rs. ${widget.totalAmount.toStringAsFixed(2)}"),
          AmountDetailRow(
              title: 'Shipping Fee',
              amount: 'Rs. ${shippingFees.toStringAsFixed(2)}'),
          AmountDetailRow(
              title: 'Platform Fee',
              amount: 'Rs. ${platformFees.toStringAsFixed(2)}'),
          const Divider(color: kTextColor),
          AmountDetailRow(
            title: 'Order Total',
            amount: 'Rs. ${orderTotalAmount.toStringAsFixed(2)}',
            isBold: true,
          ),
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
