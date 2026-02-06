import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'package:office_project/firebase_options.dart';
import 'package:office_project/theme_controller.dart';
import 'package:office_project/screens/loginpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
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

          home: const LoginPage(),
        );
      },
    );
  }
}