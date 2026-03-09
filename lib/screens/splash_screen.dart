import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:office_project/screens/adminmain.dart';
import 'package:office_project/screens/loginpage.dart';
import 'package:office_project/screens/onboardingscreen.dart';
import 'package:office_project/screens/userhomepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
 int currentIndex = 0;
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () async {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        Get.offAll(() => const OnboardingScreen());
      } else {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        final role = doc.data()?['role'];

        if (role == 'admin') {
          Get.offAll(() => const Adminmain());
        } else if (role == 'user') {
          Get.offAll(() => HomePage(role: role,  key: HomePage.homeKey,        ) );
        } else {
          Get.offAll(() => const LoginPage()); // or User Home
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image(image: AssetImage("assets/logo.png"))),
    );
  }
}
