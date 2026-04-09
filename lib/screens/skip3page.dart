import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'loginpage.dart';
import 'signuppage.dart';

class Skip3page extends StatelessWidget {
  const Skip3page({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// TOP GREEN BAR
        Container(height: 60, width: double.infinity, color: Colors.green),

        /// IMAGE
        Expanded(
          flex: 5,
          child: Image.asset(
            "assets/three.png",
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),

        /// BUTTON SECTION
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// LOGIN BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Get.off(() => const LoginPage());
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// SIGN UP BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.green),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Get.off(() => const SignupPage());
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.green),
                    ),
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
