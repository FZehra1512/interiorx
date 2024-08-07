import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:interiorx/components/cart_icon_button.dart';
import 'package:interiorx/constants.dart';
import 'package:interiorx/screens/login/login.dart';
import 'package:interiorx/screens/profile/profile_screen.dart';
import '../../components/product_card.dart';
import '../../components/home_header.dart';
import '../../components/iconbar.dart';
import 'package:interiorx/components/icon_btn_with_counter.dart';
import 'package:provider/provider.dart';
import 'package:interiorx/screens/cart/cart_screen.dart';
import 'package:interiorx/providers/cart_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'components/categories.dart';
import 'components/highlights.dart';
import '../../components/recommendations.dart';
import 'components/sale.dart';
import 'components/new_product.dart';
import 'components/popular_product.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HomeHeader(),
              // IconBar(),
              SizedBox(height: 20),
              Categories(),
              SizedBox(height: 20),
              Sale(),
              SizedBox(height: 20),
              // _buildProductList(
              //   'sale',
              //   'Sale Products',
              // ),
              SizedBox(height: 20),
              Highlights(),
              SizedBox(height: 20),
              // _buildProductList(
              //   'new arrival',
              //   'Highlighted Products',
              // ),
              SizedBox(height: 20),
              Recommendations(),
              SizedBox(height: 20),
              // _buildProductList(
              //   'popular',
              //   'Popular Products',
              // ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kSecondaryColor,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: IconBtnWithCounter(
              svgSrc: Icons.home,
              color: kTextColor,
              press: () => Navigator.pushNamed(context, HomeScreen.routeName),
            ),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: CartButton(),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: IconBtnWithCounter(
              svgSrc: Icons.person_rounded,
              color: kTextColor,
              press: () =>
                  Navigator.pushNamed(context, ProfileScreen.routeName),
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: const Icon(Icons.logout),
              color: kTextColor,
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
            ),
            label: 'Logout',
          ),
        ],
      ),
    );
  }

//   Widget _buildProductList(String type, String title) {
//     return Container(
//       height: 200, // Adjust height as needed
//       child: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('products')
//             .where('type', isEqualTo: type)
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//           if (snapshot.data!.docs.isEmpty) {
//             return Center(child: Text('No $title found.'));
//           }
//           var products = snapshot.data!.docs;
//           return ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               var data = products[index];
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ProductCard(
//                   name: data['pd_name'] ?? 'No Name',
//                   desc: data['pd_desc'] ?? 'No Description',
//                   img: data['pd_img'] ?? 'https://via.placeholder.com/150',
//                   price: (data['price'] != null) ? (data['price'] as num).toDouble() : 0.0,
//                   type: data['type'] ?? 'regular',
//                   category: data['category'] ?? 'Unknown',
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
}
