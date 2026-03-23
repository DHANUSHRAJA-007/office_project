import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:office_project/firebase_options.dart';
import 'package:office_project/screens/cart_provider.dart';
import 'package:office_project/theme_controller.dart';
import 'package:provider/provider.dart';

/// 🔔 Background handler
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  print("🔔 Background Notification Received");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String tokenText = "Getting token...";

  @override
  void initState() {
    super.initState();
    setupFCM();
  }

  /// 🔥 FCM SETUP
  void setupFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request permission
    await messaging.requestPermission();

    // Get token
    String? token = await messaging.getToken();

    print("🔥 TOKEN: $token");

    setState(() {
      tokenText = token ?? "No Token Found";
    });

    // Foreground listener
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📩 Foreground Notification Received");
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, themeMode, _) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),

          /// 🔥 TEMP SCREEN TO SHOW TOKEN
          home: Scaffold(
            appBar: AppBar(title: const Text("FCM TOKEN")),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SelectableText(   // 👈 easy copy
                  tokenText,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}