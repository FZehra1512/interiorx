import 'package:flutter/material.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';
import 'package:interiorx/screens/home/home_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:interiorx/providers/cart_provider.dart';


class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key,}) : super(key: key);
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(child: SearchField()),
          const SizedBox(width: 16),
          IconBtnWithCounter(svgSrc: Icons.home,
            press: () => Navigator.pushNamed(context, HomeScreen.routeName),),
          const SizedBox(width: 8),
          // IconButton(
          //   icon: Stack(children: [
          //     const Icon(Icons.shopping_cart_outlined, size: 32,),
          //     if (cartProvider.cartItems.isNotEmpty)
          //       Positioned(right: 0, top: 0,
          //         child: Container(padding: const EdgeInsets.all(2),
          //           decoration: BoxDecoration(color: Colors.red.shade400,
          //             borderRadius: BorderRadius.circular(10),),
          //           constraints: const BoxConstraints(minWidth: 18, minHeight: 18,),
          //           child: Text('${cartProvider.totalQuantity}', style: const TextStyle(
          //             color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10,),
          //             textAlign: TextAlign.center,),
          //         ),
          //       )
          //     ],
          //   ),
          //   onPressed: () {Navigator.pushNamed(context, CartScreen.routeName);},
          // ),
          const SizedBox(width: 8),
          // IconButton(
          //   icon: const Icon(Icons.logout),
          //   onPressed: () async {
          //     await FirebaseAuth.instance.signOut();
          //     Navigator.pushReplacementNamed(context, SplashScreen.routeName);
          //   },
          // ),
        ],
      ),
    );
  }
}