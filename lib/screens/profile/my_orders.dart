import 'package:flutter/material.dart';
import 'package:interiorx/components/custom_app_bar.dart';
import 'package:interiorx/screens/profile/current_orders.dart';
import 'package:interiorx/screens/profile/history_orders.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: CustomAppBar(title: 'My Orders'),
        body: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Current'),
                Tab(text: 'History'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  CurrentOrdersScreen(),
                  HistoryOrdersScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
