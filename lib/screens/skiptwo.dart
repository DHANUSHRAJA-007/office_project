// import 'package:flutter/material.dart';

// class Skiptwopage extends StatelessWidget {
//   const Skiptwopage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final statusBar = MediaQuery.of(context).padding.top;

//     final greenHeight = size.height * 0.08;
//     final imageHeight = size.height * 0.58;

//     return Column(
//       children: [
//         SizedBox(
//           height: greenHeight + imageHeight,
//           width: double.infinity,
//           child: Stack(
//             children: [
//               // GREEN STRIP (TOP ONLY)
//               Container(
//                 height: greenHeight,
//                 width: double.infinity,
//                 color: Colors.green,
//               ),

//               // IMAGE
//               Positioned(
//                 top: greenHeight,
//                 child: SizedBox(
//                   height: imageHeight,
//                   width: size.width,
//                   child: Image.asset(
//                     "assets/two.png",
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),

//               // SKIP BUTTON (INSIDE IMAGE)
//               Positioned(
//                 top: greenHeight + statusBar + 12,
//                 right: 20,
//                 child: TextButton(
//                   onPressed: () {
//                     // skip action (PageController handled in parent)
//                   },
//                   style: TextButton.styleFrom(
//                     backgroundColor: Colors.black.withOpacity(0.45),
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(18),
//                     ),
//                   ),
//                   child: const Text(
//                     "Skip",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),

//         // TEXT SECTION (UNCHANGED)
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.all(24),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 Text(
//                   "Fast Delivery,\nRight to Your Door",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.green,
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 12),
//                 Text(
//                   "Quick and reliable delivery ensures\nfreshness every time.",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.black54),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:office_project/screens/skip3page.dart';

class Skiptwopage extends StatelessWidget {
  const Skiptwopage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// TOP GREEN STRIP
        Container(height: 60, width: double.infinity, color: Colors.green),

        /// IMAGE SECTION (Flexible)
        Expanded(
          flex: 5,
          child: Stack(
            children: [
              /// IMAGE
              Positioned.fill(
                child: Image.asset("assets/two.png", fit: BoxFit.fitHeight),
              ),

              /// SKIP BUTTON
              Positioned(
                top: 20,
                right: 20,
                child: InkWell(
                  onTap: () {
                    Get.to(Skip3page());
                  },
                  child: Positioned(
                    right: 10,
                    child: TextButton(
                      onPressed: () {
                        Get.to(Skip3page());
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
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
                  "Fast Delivery,\nRight to Your Door",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Quick and reliable delivery ensures\nfreshness every time.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
