import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/route_manager.dart';
import 'package:office_project/screens/aboutuspage.dart';
import 'package:office_project/screens/adminmain.dart';
import 'package:office_project/screens/cart_provider.dart';
import 'package:office_project/screens/home.dart';
import 'package:office_project/screens/privacypolicy.dart';
import 'package:office_project/screens/product.dart';
import 'package:office_project/screens/signuppage.dart';
import 'package:office_project/screens/termsandcond.dart';
import 'package:office_project/screens/userhomepage.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'screens/loginpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CartProvider())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce Starter',
      home: LoginPage(),
    );
  }
}
