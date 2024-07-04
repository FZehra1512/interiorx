import 'package:flutter/material.dart';
import 'package:interiorx/components/custom_card.dart';
import 'package:interiorx/constants.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PaymentMethod {
  final String name;
  final String imageUrl;

  const PaymentMethod({required this.name, required this.imageUrl});
}
class PaymentMethodSection extends StatefulWidget {
  final GlobalKey<PaymentMethodSectionState> key;
  const PaymentMethodSection({required this.key}) : super(key: key);

  @override
  PaymentMethodSectionState createState() => PaymentMethodSectionState();
}

class PaymentMethodSectionState extends State<PaymentMethodSection> {
  final List<PaymentMethod> paymentMethods = const [
    PaymentMethod(name: 'COD', imageUrl: 'assets/images/cod.jpg'),
    PaymentMethod(name: 'JazzCash', imageUrl: 'assets/images/jazzcash.png'),
    PaymentMethod(name: 'EasyPaisa', imageUrl: 'assets/images/easypaisa.jpg'),
    PaymentMethod(name: 'Visa', imageUrl: 'assets/images/visa.png'),
    PaymentMethod(name: 'Mastercard', imageUrl: 'assets/images/mastercard.png'),
    PaymentMethod(name: 'Bank Transfer', imageUrl: 'assets/images/banktransfer.jpg'),
  ];

  String _selectedPaymentMethodName = "COD";

  void _selectPaymentMethod(String name) {
    setState(() {
      _selectedPaymentMethodName = name;
    });
  }

  String getPaymentMethod() {
    return _selectedPaymentMethodName;
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Payment Methods",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 110, // Adjust the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: paymentMethods.length,
              itemBuilder: (context, index) {
                final paymentMethod = paymentMethods[index];
                final isSelected = paymentMethods[index].name == _selectedPaymentMethodName;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => _selectPaymentMethod(paymentMethods[index].name),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    border: Border.all(
                                      color: isSelected ? kPrimaryColor : Colors.grey.shade500,
                                      width: 1,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16.0),
                                    child: Image.asset(
                                      paymentMethod.imageUrl,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: kPrimaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ]
                        )
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        paymentMethod.name,
                        style: const TextStyle(fontSize: 12, color: kTextColor, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
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
