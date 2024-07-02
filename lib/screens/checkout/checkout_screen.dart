import 'package:flutter/material.dart';
import 'package:interiorx/screens/checkout/components/amount_details.dart';
import 'package:interiorx/screens/checkout/components/section_header.dart';
import 'package:interiorx/screens/checkout/components/shipping_address.dart';
import 'package:interiorx/theme.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:interiorx/screens/checkout/components/order_items.dart';
import 'package:provider/provider.dart';
import 'package:interiorx/providers/cart_provider.dart';

class CheckoutScreen extends StatelessWidget {
  static String routeName = "/checkout";

  const CheckoutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final double totalAmount = cartProvider.totalPrice;
    return Scaffold(
      appBar: AppBar(
        leading: buildBackIconButton(context),
        title: const Text('Checkout', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            OrderItemsSection(cartProvider: cartProvider,),
            const SizedBox(height: 12),
            AmountDetailsSection(totalAmount: totalAmount,),
            const SizedBox(height: 12),
            const ShippingAddressSection(),
            const SizedBox(height: 12),
            const PaymentMethodSection(),
            const SizedBox(height: 12),
            const ApplyVoucherSection(),
            const SizedBox(height: 12),
            const CheckoutButton(),
          ],
        ),
      ),
    );
  }
}






class PaymentMethodSection extends StatelessWidget {
  const PaymentMethodSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: 'Payment Method',
              onTap: () {
                showMaterialModalBottomSheet(
                  context: context,
                  builder: (context) => const PaymentMethodsModal(),
                );
              },
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.payment),
                SizedBox(width: 8),
                Text('Paypal', style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ApplyVoucherSection extends StatelessWidget {
  const ApplyVoucherSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Have a promo code? Enter here',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Apply'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
      ),
      child: const Text('Checkout \$1615.4', style: TextStyle(fontSize: 18)),
    );
  }
}


class PaymentMethodsModal extends StatelessWidget {
  const PaymentMethodsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Payment Method'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const Center(
        child: Text('List of payment methods and option to add new method'),
      ),
    );
  }
}
