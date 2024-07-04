import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:interiorx/components/custom_app_bar.dart';
import 'package:interiorx/constants.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;
  final String date;
  final String time;
  final String status;
  final String paymentMethod;
  final String deliveryAddress;
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
            //SizedBox(height: 10),
            ...products.map((product) => Padding(
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
                            child: Image.network(
                              product['image'],
                              fit: BoxFit.cover,
                            )),
                        title: Text(product['name']),
                        trailing: Text(
                            'Rs ${(product['price'] * product['quantity']).toStringAsFixed(2)}'),
                        contentPadding: EdgeInsets.all(10),
                        tileColor: kSecondaryColor),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Text(
              'Order Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
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
                    _buildDetailRow('Delivery Address:', deliveryAddress),
                    Divider(
                      height: 15,
                    ),
                    _buildDetailRow('Total Amount:',
                        'Rs ${totalAmount.toStringAsFixed(2)}'),
                  ],
                ),
              ),
            ),
            if (isHistory) ...[
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Feedback action
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
                  // Feedback action
                },
                child: Text('Cancel Order'),
              ),
            ]
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
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 40,
          ),
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
