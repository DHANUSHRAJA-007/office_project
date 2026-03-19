import 'package:flutter/material.dart';

class Skiponepage extends StatelessWidget {
  final VoidCallback onSkip;
  const Skiponepage({super.key, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textScale = size.width / 375; // scale based on screen width

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            // TOP GREEN BAR
            Container(
              height: size.height * 0.07,
              width: double.infinity,
              color: Colors.green,
            ),

            // IMAGE SECTION
            Flexible(
              flex: 6,
              child: SizedBox(
                width: double.infinity,
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

                    // SKIP BUTTON
                    Positioned(
                      top: 10,
                      right: 10,
                      child: TextButton(
                        onPressed: onSkip,
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14 * textScale,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // TEXT SECTION
            Flexible(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.06,
                  vertical: size.height * 0.02,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Fresh Groceries,\nDelivered Every Day",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),

                    SizedBox(height: size.height * 0.02),

                    Text(
                      "Handpicked local produce delivered fresh\nfrom nearby farms to you.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14 ,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomInwardCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height);

    path.quadraticBezierTo(
      size.width / 2,
      size.height - size.height * 0.12,
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
// import 'package:flutter/material.dart';

// class Skiponepage extends StatelessWidget {
//   const Skiponepage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             /// TOP GREEN BAR
//             Container(height: 60, width: double.infinity, color: Colors.green),

//             /// IMAGE (Flexible Space)
//             Expanded(
//               flex: 5,
//               child: Stack(
//                 children: [
//                   ClipPath(
//                     clipper: BottomInwardCurveClipper(),
//                     child: Image.asset(
//                       "assets/one.png",
//                       width: double.infinity,
//                       height: double.infinity,
//                     ),
//                   ),

//                   Positioned(
//                     right: 20,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 6,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.black.withOpacity(0.5),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: const Text(
//                         "Skip",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             /// TEXT SECTION
//             Expanded(
//               flex: 3,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     Text(
//                       "Fresh Groceries,\nDelivered Every Day",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.green,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 12),
//                     Text(
//                       "Handpicked local produce delivered fresh\nfrom nearby farms to you.",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: Colors.black54, fontSize: 14),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class BottomInwardCurveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final curveHeight = size.height * 0.12;

//     final path = Path();
//     path.lineTo(0, size.height);
//     path.quadraticBezierTo(
//       size.width / 2,
//       size.height - curveHeight,
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
