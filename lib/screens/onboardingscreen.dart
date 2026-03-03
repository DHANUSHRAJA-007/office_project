// import 'package:flutter/material.dart';
// import 'skipone.dart';
// import 'skiptwo.dart';
// import 'skip3page.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _controller = PageController();
//   int currentIndex = 0;

//   void nextPage() {
//     if (currentIndex < 2) {
//       _controller.nextPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       backgroundColor: Colors.white,

//       body: Stack(
//         children: [
//           // 🔥 REMOVE TOP SYSTEM PADDING (THIS FIXES GAP)
//           MediaQuery.removePadding(
//             context: context,
//             removeTop: true,
//             child: PageView(
//               controller: _controller,
//               onPageChanged: (index) {
//                 setState(() => currentIndex = index);
//               },
//               children: [
//                 const Skiponepage(),
//                 const Skiptwopage(),
//                 const Skip3page(),
//               ],
//             ),
//           ),

//           // DOTS + NEXT BUTTON
//           Positioned(
//             bottom: 40,
//             left: 20,
//             right: 20,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: List.generate(
//                     3,
//                     (index) => Container(
//                       margin: const EdgeInsets.only(right: 6),
//                       width: 10,
//                       height: 10,
//                       decoration: BoxDecoration(
//                         color: currentIndex == index
//                             ? Colors.green
//                             : Colors.grey.shade300,
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                   ),
//                 ),
//                 FloatingActionButton(
//                   backgroundColor: Colors.green,
//                   onPressed: nextPage,
//                   child: const Icon(Icons.arrow_forward),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'skipone.dart';
import 'skiptwo.dart';
import 'skip3page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  void nextPage() {
    if (currentIndex < 2) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipToLast() {
    _controller.animateToPage(
      2,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            /// PAGE CONTENT
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() => currentIndex = index);
                },
                children: [
                  Skiponepage(
                    onSkip:skipToLast
                  ),
                   Skiptwopage(onSkip: skipToLast,),
                  const Skip3page(),
                ],
              ),
            ),

            /// BOTTOM CONTROLS (Reserved space)
            SizedBox(
              height: 90,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  /// DOTS CENTER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: currentIndex == index ? 18 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? Colors.green
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),

                  /// NEXT BUTTON
                  if (currentIndex != 2)
                    Positioned(
                      right: 20,
                      child: FloatingActionButton(
                        shape: CircleBorder(),
                        backgroundColor: Colors.green,
                        onPressed: nextPage,
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
