// import 'package:flutter/material.dart';
// import 'package:interiorx/constants.dart';
// import 'package:interiorx/screens/product/product_screen.dart';
//
// class Sale extends StatelessWidget {
//   const Sale({Key? key,});
//   Widget build(BuildContext context) {
//     return InkWell(onTap: (){Navigator.push(context, MaterialPageRoute(
//         builder: (context)  => ProductScreen(category: "", type: "sale")));},
//       child: Container(width: double.infinity, margin: const EdgeInsets.all(20),
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16,),
//         decoration: BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.circular(20),),
//         child: Stack(children: [const Text.rich(TextSpan(style: TextStyle(color: Colors.white),
//             children: [TextSpan(text: 'Special Seasonal ', children: [
//               TextSpan(text: 'Sale\n', style: TextStyle(
//                 fontWeight: FontWeight.bold, fontSize: 20.0, color: kTextColor,),),],),
//               TextSpan(text: "Discounts upto 50% on products of all categories",
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),),],),),
//           Positioned(bottom: 0, right: 0,
//             child: Icon(Icons.arrow_forward, color: Colors.white,),),],),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:interiorx/constants.dart';
import 'package:interiorx/screens/product/product_screen.dart';

class Sale extends StatelessWidget {
  const Sale({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(category: "", type: "sale"),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.zero, // Remove border radius
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Center(
                    child: const Text(
                      "Special seasional sale up to 50% on products of all categories",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    color: Colors.black,
                    child: const Text(
                      'Sale up to 50%',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold, fontSize: 10
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    color: Colors.black,
                    child: const Text(
                      'View more',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold, fontSize: 10
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

