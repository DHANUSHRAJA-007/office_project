// import 'package:flutter/material.dart';

// class Skiponepage extends StatelessWidget {
//   const Skiponepage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final statusBar = MediaQuery.of(context).padding.top;

//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         // TOP GREEN BAR (STATUS AREA)
//         Container(
//           height: size.height * 0.08,
//           width: double.infinity,
//           color: Colors.green,
//         ),

//         // IMAGE WITH CURVE + SKIP
//        SizedBox(
//   height: size.height * 0.56,
//   width: double.infinity,
//   child: Stack(
//     children: [
//       ClipPath(
//         clipper: BottomInwardCurveClipper(),
//         child: Image.asset(
//           "assets/one.png",
//           width: double.infinity,
//           height: double.infinity,
//           fit: BoxFit.cover,
//         ),
//       ),

//       // ✅ SKIP — NOW CLEARLY VISIBLE
//       Positioned(
//         top: 16,
//         right: 16,
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
//           decoration: BoxDecoration(
//             color: Colors.black.withOpacity(0.45),
//             borderRadius: BorderRadius.circular(18),
//           ),
//           child: const Text(
//             "Skip",
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//     ],
//   ),
// ),


//         // TEXT SECTION
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.all(24),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 Text(
//                   "Fresh Groceries,\nDelivered Every Day",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.green,
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 12),
//                 Text(
//                   "Handpicked local produce delivered fresh\nfrom nearby farms to you.",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.black54,
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }


// class BottomInwardCurveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();

//     path.lineTo(0, size.height);
//     path.quadraticBezierTo(
//       size.width / 2,
//       size.height - 70,
//       size.width,
//       size.height,
//     );
//     path.lineTo(size.width, 0);
//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

import 'package:flutter/material.dart';

class Skiponepage extends StatelessWidget {
  const Skiponepage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
          children: [

            /// TOP GREEN BAR
            Container(
              height: 60,
              width: double.infinity,
              color: Colors.green,
            ),

            /// IMAGE (Flexible Space)
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  ClipPath(
                    clipper: BottomInwardCurveClipper(),
                    child: Image.asset(
                      "assets/one.png",
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Positioned(
                    top: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Skip",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// TEXT SECTION
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Fresh Groceries,\nDelivered Every Day",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Handpicked local produce delivered fresh\nfrom nearby farms to you.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        
    );
  }
}

class BottomInwardCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final curveHeight = size.height * 0.12;

    final path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
      size.width / 2,
      size.height - curveHeight,
      size.width,
      size.height,
    );
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
