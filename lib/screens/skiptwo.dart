import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_project/screens/skip3page.dart';

class Skiptwopage extends StatelessWidget {
  final VoidCallback onSkip;

  const Skiptwopage({super.key, required this.onSkip});

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

                  child: TextButton(
                    onPressed: onSkip,
                    child: Text("Skip", style: TextStyle(color: Colors.black)),
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
