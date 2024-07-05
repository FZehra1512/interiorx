// import 'package:flutter/material.dart';
// import 'package:interiorx/constants.dart';
// import 'package:interiorx/screens/product/product_screen.dart';
//
// class Highlights extends StatelessWidget {
//   const Highlights({Key? key,});
//   Widget build(BuildContext context) {
//     return InkWell(onTap: (){Navigator.push(context, MaterialPageRoute(
//         builder: (context)  => ProductScreen(category: "", type: "new arrival")));},
//       child: Container(width: double.infinity, margin: const EdgeInsets.all(20),
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16,),
//         decoration: BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.circular(20),),
//         child: Stack(children: [const Text.rich(TextSpan(style: TextStyle(color: Colors.white),
//             children: [TextSpan(text: 'Take a look at the ', children: [
//               TextSpan(text: 'New Arrivals\n', style: TextStyle(
//                 fontWeight: FontWeight.bold, fontSize: 20.0, color: kTextColor,),),],),
//               TextSpan(text: "Unique and vibrant products available in all categories",
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

class Highlights extends StatelessWidget {
  const Highlights({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(category: "", type: "new arrival"),
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
                  padding: const EdgeInsets.only(left: 50.0), // Adjust padding to avoid overlap with the bow
                  child: const Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: 'Take a look at the ',
                          children: [
                            TextSpan(
                              text: 'New Arrivals\n',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kTextColor,
                              ),
                            ),
                          ],
                        ),
                        TextSpan(
                          text: "Unique and vibrant products available in all categories",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  child: Container(
                    width: 30,
                    color: Colors.black,
                    child: Center(
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: const Text(
                          'New Arrival',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold, fontSize: 10
                          ),
                        ),
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
