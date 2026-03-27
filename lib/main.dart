import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:office_project/firebase_options.dart';
import 'package:office_project/screens/adminmain.dart';
import 'package:office_project/screens/cart_provider.dart';
import 'package:office_project/screens/productdetailspage.dart';
import 'package:office_project/screens/product_card.dart';
import 'package:office_project/screens/product_card.dart';
import 'package:office_project/screens/productdetailspage.dart';
import 'package:office_project/screens/splash_screen.dart';
import 'package:office_project/screens/successpage.dart';
import 'package:office_project/screens/user_homescreen.dart';
import 'package:office_project/screens/userprofile.dart';
import 'package:office_project/screens/view_orders.dart';
import 'package:office_project/theme_controller.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CartProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, themeMode, _) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'E-Commerce Starter',
          themeMode: themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home:SplashScreen()
        );
      },
    );
  }
}
