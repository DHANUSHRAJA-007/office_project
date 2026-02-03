import 'package:flutter/material.dart';
import 'package:office_project/screens/cretepass.dart';
import 'package:office_project/screens/forgotpass.dart';
import 'package:office_project/screens/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:office_project/screens/loginpage.dart';
import 'package:office_project/screens/signuppage.dart';
import 'package:office_project/screens/verificationpage.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

void main() {
  //   WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'office_project',
      home: Homepage(),
    );
  }
}
