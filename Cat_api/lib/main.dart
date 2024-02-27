import 'dart:io';
import 'package:cat_api/widgets/homepage.dart';
import 'package:cat_api/widgets/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCmyER6TNPQrBGZ1kT2posEH3jS52uGlb8",
            appId: "1:437172282524:web:fc2ab1f05e9ee4c38b7959",
            messagingSenderId: "437172282524",
            projectId: "shop-cat-eb9d3"));
  } else if (Platform.isAndroid) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAT24ig8DHD_ONpO1STs91NoiS1ZqUdGjE",
            appId: "1:437172282524:android:8bb0b3ad433a59088b7959",
            messagingSenderId: "437172282524",
            projectId: "shop-cat-eb9d3"));
  } else
    await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Cat Api",
      routes: {
        "/": (context) => MyHomePage(),
        "/register": (context) => MyRegister(),
        // "/login": (context) => MyLogin(),
        // "/content": (context) => MyContent(),
      },
    );
  }
}
