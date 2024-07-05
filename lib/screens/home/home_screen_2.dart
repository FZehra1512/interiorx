// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:interiorx/constants.dart';
// //import 'product_screen.dart'; // Import the ProductScreen

// class HomeScreen extends StatefulWidget {
//   static String routeName = "/home";

//   const HomeScreen({super.key});

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;
//   int _currentPage = 0; // Add this
//   final PageController _pageController = PageController(); // Add this
//   Timer? _timer; // Add this

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//       // Handle navigation to different screens here
//       // For example:
//       // if (index == 0) { // Navigate to Home }
//       // if (index == 1) { // Navigate to Cart }
//       // if (index == 2) { // Navigate to Profile }
//       // if (index == 3) { // Handle Logout }
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer.periodic(Duration(seconds: 3), (timer) {
//       // Change page every 5 seconds
//       if (_currentPage < 3) {
//         // Assuming you have 3 banners
//         _currentPage++;
//       } else {
//         _currentPage = 0;
//       }
//       _pageController.animateToPage(_currentPage,
//           duration: Duration(milliseconds: 1000), curve: Curves.ease);
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel(); // Cancel the timer when the widget is disposed
//     super.dispose();
//   }

//   Widget _buildBody() {
//     switch (_selectedIndex) {
//       case 0:
//         return _buildHomeContent();
//       case 1:
//         return Center(child: Text('Cart Screen'));
//       case 2:
//         return Center(child: Text('Profile Screen'));
//       case 3:
//         return Center(child: Text('Logout Screen'));
//       default:
//         return _buildHomeContent();
//     }
//   }

//   Widget _buildHomeContent() {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Top colored part with search bar
//           Container(
//             color: kPrimaryColor,
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//             child: Column(
//               children: [
//                 SizedBox(height: 40), // For status bar height
//                 TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Search',
//                     prefixIcon: Icon(Icons.search),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     filled: true,
//                     fillColor: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//               ],
//             ),
//           ),
//           // Categories section
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildCategory('Abstract'),
//                 _buildCategory('Portrait'),
//                 _buildCategory('Digital Art'),
//                 _buildCategory('Calligraphy'),
//               ],
//             ),
//           ),
//           // Banner section
//           Container(
//             height: 200,
//             child: PageView(
//               controller: _pageController,
//               children: [
//                 _buildBanner('Banner 1', 'assets/images/banner1.png'),
//                 _buildBanner('Banner 2', 'assets/images/banner2.jfif'),
//                 _buildBanner('Banner 3', 'assets/images/banner3.png'),
//                 _buildBanner('Banner 4', 'assets/images/banner4.png'),
//               ],
//             ),
//           ),
//           // Popular products section
//           Padding(
//             padding: EdgeInsets.all(20),
//             child: Text(
//               'Popular Products',
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Container(
//             height: 250,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               children: [
//                 _buildProductCard('Product 1',
//                     'assets/images/products/product1.jfif', '\$30'),
//                 _buildProductCard('Product 2',
//                     'assets/images/products/product2.jfif', '\$40'),
//                 _buildProductCard('Product 3',
//                     'assets/images/products/product3.jfif', '\$50'),
//               ],
//             ),
//           ),
//           // Additional banner section
//           Container(
//             height: 200,
//             child: PageView(
//               children: [
//                 _buildBanner('Banner 5', 'assets/banner5.png'),
//                 _buildBanner('Banner 6', 'assets/banner6.png'),
//               ],
//             ),
//           ),
//           // Sale section
//           Padding(
//             padding: EdgeInsets.all(20),
//             child: Text(
//               'Sale',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Container(
//             height: 200,
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               children: [
//                 _buildProductCard('Sale Product 1', 'assets/sale1.png', '\$20'),
//                 _buildProductCard('Sale Product 2', 'assets/sale2.png', '\$25'),
//                 _buildProductCard('Sale Product 3', 'assets/sale3.png', '\$15'),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCategory(String name) {
//     return Column(
//       children: [
//         Container(
//           height: 80,
//           width: 80,
//           decoration: BoxDecoration(
//             color: Colors.grey[200],
//             borderRadius: BorderRadius.circular(25),
//           ),
//           child: Icon(Icons.category, color: Colors.grey),
//         ),
//         SizedBox(height: 5),
//         Text(
//           name,
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ],
//     );
//   }

//   Widget _buildBanner(String title, String imagePath) {
//     return Padding(
//       padding: EdgeInsets.all(10),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(15),
//         child: Image.asset(
//           imagePath,
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }

//   Widget _buildProductCard(String title, String imagePath, String price) {
//     return GestureDetector(
//       onTap: () {
//         print('product card tapped');
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(
//         //     builder: (context) => ProductScreen(title: title),
//         //   ),
//         // );
//       },
//       child: Padding(
//         padding: EdgeInsets.all(10),
//         child: Container(
//           width: 150,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Image.asset(
//                   imagePath,
//                   height: 150,
//                   width: 150,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               SizedBox(height: 5),
//               Text(
//                 title,
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Text(price),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _buildBody(),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_cart),
//             label: 'Cart',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.logout),
//             label: 'Logout',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: kPrimaryColor,
//         unselectedItemColor: Colors.grey,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
