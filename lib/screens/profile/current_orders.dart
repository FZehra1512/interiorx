import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:interiorx/screens/profile/order_details.dart';
import 'package:intl/intl.dart';

class CurrentOrdersScreen extends StatelessWidget {
  const CurrentOrdersScreen({Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>> fetchCurrentOrders(String userId) async {
    List<Map<String, dynamic>> currentOrders = [];

    try {
      debugPrint('Fetching current orders for user: $userId');

      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('orders')
              .where('userId', isEqualTo: userId)
              .where('status',
                  whereIn: ['Order Placed', 'Order Dispatched']).get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> orderData = doc.data();
        DateTime createdAt = orderData['createdAt'].toDate();
        DateTime now = DateTime.now();

        if (orderData['status'] == 'Order Placed' &&
            now.difference(createdAt).inHours >= 2) {
          await FirebaseFirestore.instance
              .collection('orders')
              .doc(doc.id)
              .update({'status': 'Order Dispatched'});
          orderData['status'] = 'Order Dispatched';
        }

        currentOrders.add({
          'orderId': doc.id,
          ...orderData,
          'date': DateFormat('yyyy-MM-dd').format(createdAt),
          'time': DateFormat('HH:mm').format(createdAt),
        });
      }

      debugPrint('Fetched ${currentOrders.length} current orders');
    } catch (e) {
      debugPrint('Error fetching current orders: $e');
      debugPrintStack();
    }

    return currentOrders;
  }

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchCurrentOrders(userId),
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          debugPrint('Waiting for current orders data...');
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          debugPrint('Error: ${snapshot.error}');
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        List<Map<String, dynamic>> currentOrders = snapshot.data ?? [];

        if (currentOrders.isEmpty) {
          debugPrint('No current orders found');
          return Center(child: Text('No current orders found.'));
        }

        debugPrint('Displaying ${currentOrders.length} current orders');

        return ListView.builder(
          itemCount: currentOrders.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> order = currentOrders[index];

            return Card(
              margin: EdgeInsets.only(top: 12, left: 12, right: 12),
              child: InkWell(
                onTap: () {
                  debugPrint('Order tapped: ${order['orderId']}');
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
                        products:
                            List<Map<String, dynamic>>.from(order['products']),
                        isHistory: false,
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
                              color: order['status'] == 'Order Placed'
                                  ? Colors.purpleAccent
                                  : Colors.deepPurple,
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
