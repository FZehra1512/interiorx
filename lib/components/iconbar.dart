import 'package:flutter/material.dart';
import 'package:interiorx/screens/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:interiorx/components/icon_btn_with_counter.dart';
import 'package:interiorx/screens/home/home_screen.dart';
import 'package:interiorx/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:interiorx/screens/cart/cart_screen.dart';
import 'package:interiorx/providers/cart_provider.dart';
import '../../../constants.dart';

class IconBar extends StatelessWidget {
  const IconBar({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconBtnWithCounter(svgSrc: Icons.home, color: kTextColor,
          press: () => Navigator.pushNamed(context, HomeScreen.routeName),),
        IconButton(icon: Stack(
          children: [const Icon(Icons.shopping_cart_outlined, size: 32, color: kTextColor,),
            if (cartProvider.cartItems.isNotEmpty)
              Positioned(right: 0, top: 0,
                child: Container(padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(color: Colors.red.shade400,
                    borderRadius: BorderRadius.circular(10),),
                  constraints: const BoxConstraints(minWidth: 18, minHeight: 18,),
                  child: Text('${cartProvider.totalQuantity}', style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10,),
                    textAlign: TextAlign.center,),
                ),)],),
          onPressed: () {Navigator.pushNamed(context, CartScreen.routeName);},),
        IconBtnWithCounter(svgSrc: Icons.person_rounded, color: kTextColor,
          press: () => Navigator.pushNamed(context, ProfileScreen.routeName),),
        IconButton(icon: const Icon(Icons.logout), color: kTextColor,
          onPressed: () async {await FirebaseAuth.instance.signOut();
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);},),
      ],),);}}
