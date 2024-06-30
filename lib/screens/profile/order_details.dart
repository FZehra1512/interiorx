import 'package:flutter/material.dart';
import 'package:interiorx/components/custom_app_bar.dart';

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
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ...products.map((product) => ListTile(
                  leading: Image.network(product['image']),
                  title: Text(product['name']),
                  trailing: Text(
                      'Rs ${(product['price'] * product['quantity']).toStringAsFixed(2)}'),
                )),
            SizedBox(height: 20),
            Card(
              margin: EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Details',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Order ID:'), Text('$orderId')],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Order Date & Time:'),
                        Text('$date at $time')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text('Status:'), Text('$status')],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Payment Method:'),
                        Text('$paymentMethod')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Delivery Address:'),
                        Text('$deliveryAddress')
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Amount:'),
                        Text('Rs ${totalAmount.toStringAsFixed(2)}')
                      ],
                    ),
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
}
