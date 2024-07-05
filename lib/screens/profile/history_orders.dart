import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:interiorx/screens/profile/order_details.dart';
import 'package:intl/intl.dart';

class HistoryOrdersScreen extends StatelessWidget {
  const HistoryOrdersScreen({Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>> fetchDeliveredOrders(String userId) async {
    List<Map<String, dynamic>> deliveredOrders = [];

    try {
      debugPrint('Fetching orders for user: $userId');

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('orders')
              .where('userId', isEqualTo: userId)
              .where('userId', isEqualTo: userId)
              .where('status', isEqualTo: 'delivered')
              .get();

      deliveredOrders = querySnapshot.docs
          .map((doc) => {
                'orderId': doc.id,
                ...doc.data(),
                'date':
                    DateFormat('yyyy-MM-dd').format(doc['createdAt'].toDate()),
                'time': DateFormat('HH:mm').format(doc['createdAt'].toDate())
              })
          .toList();

      debugPrint('Fetched ${deliveredOrders.length} delivered orders');
    } catch (e) {
      debugPrint('Error fetching orders: $e');
      debugPrintStack();
    }

    return deliveredOrders;
  }

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchDeliveredOrders(userId),
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          debugPrint('Waiting for orders data...');
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          debugPrint('Error: ${snapshot.error}');
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        List<Map<String, dynamic>> deliveredOrders = snapshot.data ?? [];

        if (deliveredOrders.isEmpty) {
          debugPrint('No delivered orders found');
          return Center(child: Text('No delivered orders found.'));
        }

        debugPrint('Displaying ${deliveredOrders.length} delivered orders');

        return ListView.builder(
          itemCount: deliveredOrders.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> order = deliveredOrders[index];

            return Card(
              margin: EdgeInsets.only(top: 12, left: 12, right: 12),
              child: InkWell(
                onTap: () {
                  debugPrint('Order tapped: ${order['orderId']}');
                  debugPrint(
                      'Passing these:${order['orderId']} - ${order['date']} - ${order['time']} - ${order['status']} - ${order['paymentMethod']} - ${order['deliveryAddress']} - ${order['totalAmount'].toDouble()} - ${order['products']}');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailsScreen(
                        orderId: order['orderId'],
                        date: order['date'],
                        time: order['time'],
                        status: order['status'],
                        paymentMethod: order['paymentMethod'],
                        deliveryAddress: order['deliveryAddress'],
                        totalAmount: order['totalAmount'].toDouble(),
                        products: List<Map<String, dynamic>>.from(order[
                            'products']), // Ensure products list is properly casted
                        isHistory: true,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Order ID: ${order['orderId']}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          // Text('${order['date']} - ${order['time']}',
                          //     style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      Text('${order['date']} - ${order['time']}',
                          style: TextStyle(fontSize: 14)),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Total Products: ${order['products'].length}',
                                  style: TextStyle(fontSize: 14)),
                              Text(
                                  'Price: Rs ${order['totalAmount'].toStringAsFixed(2)}',
                                  style: TextStyle(fontSize: 14)),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              order['status'],
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
