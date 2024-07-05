// import 'package:flutter/material.dart';
// import 'package:interiorx/constants.dart';
// import 'package:interiorx/screens/product/product_screen.dart';
//
// class Recommendations extends StatelessWidget {
//   const Recommendations({Key? key,}) : super(key: key);
//   Widget build(BuildContext context) {
//     return InkWell(onTap: (){Navigator.push(context, MaterialPageRoute(
//         builder: (context)  => ProductScreen(category: "", type: "popular")));},
//       child: Container(width: double.infinity, margin: const EdgeInsets.all(20),
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16,),
//         decoration: BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.circular(20),),
//         child: Stack(children: [const Text.rich(TextSpan(style: TextStyle(color: Colors.white),
//             children: [TextSpan(text: 'Bringing you the most ', children: [
//               TextSpan(text: 'Popular Products\n', style: TextStyle(
//                 fontWeight: FontWeight.bold, fontSize: 20.0, color: kTextColor,),),],),
//               TextSpan(text: "Discover the hottest trends and ongoing designs.",
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),),],),),
//           Positioned(bottom: 0, right: 0,
//             child: Icon(Icons.arrow_forward, color: Colors.white,),),],),
//       ),);}}
//

import 'package:flutter/material.dart';
import 'package:interiorx/constants.dart';
import 'package:interiorx/screens/product/product_screen.dart';

class Recommendations extends StatelessWidget {
  const Recommendations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductScreen(category: "", type: "popular"),
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
                  padding: const EdgeInsets.only(left: 50.0, top: 25.0), // Adjust padding to avoid overlap with the diagonal banner
                  child: const Text(
                    "Discover the hottest trends and ongoing designs.",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    width: 80,
                    height: 50,
                    child: CustomPaint(
                      painter: DiagonalPainter(),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            'Popular',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
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

class DiagonalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
