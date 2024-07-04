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
                              'Order ID: ${order['orderId'].substring(0, 10)}...',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text('${order['date']} - ${order['time']}',
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),
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











// import 'package:flutter/material.dart';
// import 'package:interiorx/screens/profile/order_details.dart';

// class CurrentOrdersScreen extends StatelessWidget {
//   const CurrentOrdersScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Example static data, replace with dynamic data from your database
//     List<Map<String, dynamic>> currentOrders = [
//       {
//         'orderId': '123456',
//         'date': '2024-06-25',
//         'time': '14:30',
//         'status': 'Order Placed',
//         'totalProducts': 5,
//         'price': 800.00,
//         'products': [
//           {
//             'image': 'https://via.placeholder.com/150',
//             'name': 'Product 1',
//             'price': 100.00,
//             'quantity': 2,
//           },
//           {
//             'image': 'https://via.placeholder.com/150',
//             'name': 'Product 2',
//             'price': 200.00,
//             'quantity': 1,
//           },
//         ]
//       },
//       {
//         'orderId': '789012',
//         'date': '2024-06-24',
//         'time': '11:00',
//         'status': 'Order Dispatched',
//         'totalProducts': 3,
//         'price': 500.00,
//         'products': [
//           {
//             'image': 'https://via.placeholder.com/150',
//             'name': 'Product 3',
//             'price': 250.00,
//             'quantity': 1,
//           },
//           {
//             'image': 'https://via.placeholder.com/150',
//             'name': 'Product 4',
//             'price': 250.00,
//             'quantity': 1,
//           },
//         ]
//       },
//     ];

//     return ListView.builder(
//       itemCount: currentOrders.length,
//       itemBuilder: (context, index) {
//         return Card(
//           margin: EdgeInsets.only(top: 12, left: 12, right: 12),
//           child: InkWell(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => OrderDetailsScreen(
//                     orderId: currentOrders[index]['orderId'],
//                     date: currentOrders[index]['date'],
//                     time: currentOrders[index]['time'],
//                     status: currentOrders[index]['status'],
//                     paymentMethod: 'Credit Card', // Replace with real data
//                     deliveryAddress:
//                         '123, ABC Street, XYZ City', // Replace with real data
//                     totalAmount: currentOrders[index]['price'],
//                     products: currentOrders[index]['products'],
//                     isHistory: false,
//                   ),
//                 ),
//               );
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(15),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Order ID: ${currentOrders[index]['orderId']}',
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.bold)),
//                       Text(
//                           '${currentOrders[index]['date']} - ${currentOrders[index]['time']}',
//                           style: TextStyle(fontSize: 14)),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                               'Total Products: ${currentOrders[index]['totalProducts']}',
//                               style: TextStyle(fontSize: 14)),
//                           Text(
//                               'Price: Rs ${currentOrders[index]['price'].toStringAsFixed(2)}',
//                               style: TextStyle(fontSize: 14)),
//                         ],
//                       ),
//                       Container(
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                         decoration: BoxDecoration(
//                           color:
//                               currentOrders[index]['status'] == 'Order Placed'
//                                   ? Colors.purpleAccent
//                                   : Colors.deepPurple,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Text(
//                           currentOrders[index]['status'],
//                           style: TextStyle(fontSize: 14, color: Colors.white),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }












// import 'package:flutter/material.dart';
// import 'package:interiorx/screens/profile/order_details.dart';

// class CurrentOrdersScreen extends StatelessWidget {
//   const CurrentOrdersScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 5, // Replace with your data count
//       itemBuilder: (context, index) {
//         return Card(
//           margin: EdgeInsets.all(8),
//           child: ListTile(
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Order ID: 12345'),
//                 Text('2024-06-30'),
//                 Text('14:00'),
//               ],
//             ),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Divider(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Total Products: 3'),
//                         Text('Price: Rs 800.00'),
//                       ],
//                     ),
//                     Container(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: index % 2 == 0
//                             ? Colors.purpleAccent
//                             : Colors.deepPurple,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Text(
//                         index % 2 == 0 ? 'Placed' : 'Dispatched',
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => OrderDetailsScreen(
//                     orderId: '12345',
//                     date: '2024-06-30',
//                     time: '14:00',
//                     status: index % 2 == 0 ? 'Placed' : 'Dispatched',
//                     paymentMethod: 'Credit Card',
//                     deliveryAddress: '123, ABC Street, XYZ City',
//                     totalAmount: 800.00,
//                     products: [
//                       {
//                         'image': 'https://via.placeholder.com/150',
//                         'name': 'Product 1',
//                         'price': 100.00,
//                         'quantity': 2,
//                       },
//                       {
//                         'image': 'https://via.placeholder.com/150',
//                         'name': 'Product 2',
//                         'price': 200.00,
//                         'quantity': 1,
//                       },
//                       {
//                         'image': 'https://via.placeholder.com/150',
//                         'name': 'Product 3',
//                         'price': 50.00,
//                         'quantity': 4,
//                       },
//                     ],
//                     isHistory: false, // Set to true for history orders
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }





// import 'package:flutter/material.dart';

// class CurrentOrdersScreen extends StatelessWidget {
//   const CurrentOrdersScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Example static data, replace with dynamic data from your database
//     List<Map<String, String>> currentOrders = [
//       {
//         'orderId': '123456',
//         'date': '2024-06-25',
//         'time': '14:30',
//         'status': 'Order Placed',
//         'totalProducts': '5',
//         'price': 'Rs 800.00'
//       },
//       {
//         'orderId': '789012',
//         'date': '2024-06-24',
//         'time': '11:00',
//         'status': 'Order Dispatched',
//         'totalProducts': '3',
//         'price': 'Rs 500.00'
//       },
//     ];

//     return ListView.builder(
//       itemCount: currentOrders.length,
//       itemBuilder: (context, index) {
//         return Card(
//           margin: EdgeInsets.all(8.0),
//           child: InkWell(
//             onTap: () {
//               showModalBottomSheet(
//                 context: context,
//                 builder: (context) {
//                   return OrderDetailsBottomSheet(
//                       orderDetails: currentOrders[index]);
//                 },
//               );
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(15),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('Order ID: ${currentOrders[index]['orderId']}',
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.bold)),
//                       Text(
//                           '${currentOrders[index]['date']} - ${currentOrders[index]['time']}',
//                           style: TextStyle(fontSize: 14)),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                               'Total Products: ${currentOrders[index]['totalProducts']}',
//                               style: TextStyle(fontSize: 14)),
//                           Text('Price: ${currentOrders[index]['price']}',
//                               style: TextStyle(fontSize: 14)),
//                         ],
//                       ),
//                       Container(
//                         padding:
//                             EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                         decoration: BoxDecoration(
//                           color:
//                               currentOrders[index]['status'] == 'Order Placed'
//                                   ? Colors.blue
//                                   : Colors.green,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Text(
//                           currentOrders[index]['status']!,
//                           style: TextStyle(fontSize: 14, color: Colors.white),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


