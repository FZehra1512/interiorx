import 'package:flutter/material.dart';
import 'package:interiorx/screens/profile/order_details.dart';

class HistoryOrdersScreen extends StatelessWidget {
  const HistoryOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example static data, replace with dynamic data from your database
    List<Map<String, dynamic>> currentOrders = [
      {
        'orderId': '123456',
        'date': '2024-06-25',
        'time': '14:30',
        'status': 'Order Delivered',
        'totalProducts': 5,
        'price': 800.00,
        'products': [
          {
            'image': 'https://via.placeholder.com/150',
            'name': 'Product 1',
            'price': 100.00,
            'quantity': 2,
          },
          {
            'image': 'https://via.placeholder.com/150',
            'name': 'Product 2',
            'price': 200.00,
            'quantity': 1,
          },
        ]
      },
      {
        'orderId': '789012',
        'date': '2024-06-24',
        'time': '11:00',
        'status': 'Order Delivered',
        'totalProducts': 3,
        'price': 500.00,
        'products': [
          {
            'image': 'https://via.placeholder.com/150',
            'name': 'Product 3',
            'price': 250.00,
            'quantity': 1,
          },
          {
            'image': 'https://via.placeholder.com/150',
            'name': 'Product 4',
            'price': 250.00,
            'quantity': 1,
          },
        ]
      },
    ];

    return ListView.builder(
      itemCount: currentOrders.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderDetailsScreen(
                    orderId: currentOrders[index]['orderId'],
                    date: currentOrders[index]['date'],
                    time: currentOrders[index]['time'],
                    status: currentOrders[index]['status'],
                    paymentMethod: 'Credit Card', // Replace with real data
                    deliveryAddress:
                        '123, ABC Street, XYZ City', // Replace with real data
                    totalAmount: currentOrders[index]['price'],
                    products: currentOrders[index]['products'],
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
                      Text('Order ID: ${currentOrders[index]['orderId']}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(
                          '${currentOrders[index]['date']} - ${currentOrders[index]['time']}',
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
                              'Total Products: ${currentOrders[index]['totalProducts']}',
                              style: TextStyle(fontSize: 14)),
                          Text(
                              'Price: Rs ${currentOrders[index]['price'].toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          currentOrders[index]['status'],
                          style: TextStyle(fontSize: 14, color: Colors.white),
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
  }
}


// import 'package:flutter/material.dart';

// class HistoryOrdersScreen extends StatelessWidget {
//   const HistoryOrdersScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Example static data, replace with dynamic data from your database
//     List<Map<String, String>> historyOrders = [
//       {'title': 'Order #3', 'status': 'Delivered'},
//       {'title': 'Order #4', 'status': 'Canceled'},
//     ];

//     return ListView.builder(
//       itemCount: historyOrders.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(historyOrders[index]['title']!),
//           subtitle: Text(historyOrders[index]['status']!),
//           onTap: () {
//             // Navigate to order details
//           },
//         );
//       },
//     );
//   }
// }
