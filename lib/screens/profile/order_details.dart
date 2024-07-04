import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interiorx/components/custom_app_bar.dart';
import 'package:interiorx/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interiorx/screens/profile/add_review.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;
  final String date;
  final String time;
  final String status;
  final String paymentMethod;
  final Map<String, dynamic> deliveryAddress;
  final double totalAmount;
  final List<Map<String, dynamic>> products; // List of products
  final bool isHistory; // To differentiate between current and history orders

  const OrderDetailsScreen({
    Key? key,
    required this.orderId,
    required this.date,
    required this.time,
    required this.status,
    required this.paymentMethod,
    required this.deliveryAddress,
    required this.totalAmount,
    required this.products,
    this.isHistory = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Order Details'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Items',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ...products.map((product) {
              double productPrice = (product['price'] as num).toDouble();
              int productQuantity = product['quantity'];
              double totalPrice = productPrice * productQuantity;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: ListTile(
                    leading: SizedBox(
                      width: 50,
                      height: 50,
                      child: SvgPicture.asset(
                        'assets/interiorx-logo.svg',
                        fit: BoxFit.cover,
                      ),
                      // child: Image.network(
                      //   product['https://ibb.co/c3tyWpF'],
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                    title: Text(product['name']),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Rs ${productPrice.toStringAsFixed(2)} x $productQuantity = Rs ${totalPrice.toStringAsFixed(2)}'),
                        // Text(
                        //     'x $productQuantity = Rs ${totalPrice.toStringAsFixed(2)}'),
                      ],
                    ),
                    contentPadding: EdgeInsets.all(10),
                    tileColor: kSecondaryColor,
                  ),
                ),
              );
            }).toList(),
            SizedBox(height: 20),
            Text(
              'Order Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Card(
              color: kSecondaryColor,
              margin: EdgeInsets.all(2),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('Order ID:', orderId),
                    _buildDetailRow('Order Date & Time:', '$date at $time'),
                    _buildDetailRow('Status:', status),
                    _buildDetailRow('Payment Method:', paymentMethod),
                    _buildDetailRow(
                        'Delivery Address:', deliveryAddress['address']),
                    Divider(height: 15),
                    _buildDetailRow('Total Amount:',
                        'Rs ${totalAmount.toStringAsFixed(2)}'),
                  ],
                ),
              ),
            ),
            if (isHistory) ...[
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  User? user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectProductForReviewScreen(
                          products: products,
                          userId: user.uid,
                        ),
                      ),
                    );
                  } else {
                    // Handle user not logged in
                    print('User not logged in');
                  }
                },
                child: Text('Feedback'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Reorder action
                },
                child: Text('Reorder'),
              ),
            ],
            if (status == 'Order Placed') ...[
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Cancel order action
                },
                child: Text('Cancel Order'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 40),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              overflow: TextOverflow.visible,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
