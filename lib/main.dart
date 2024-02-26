import 'dart:io';
import 'package:final_mobile/widgets/homepage.dart';
import 'package:final_mobile/widgets/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
              apiKey: "AIzaSyAT24ig8DHD_ONpO1STs91NoiS1ZqUdGjE",
              appId: "1:437172282524:android:bcfffa64fab985558b7959",
              messagingSenderId: "437172282524",
              projectId: "shop-cat-eb9d3"))
      : await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Firebase authentication",
      routes: {
        "/": (context) => MyHomePage(),
        "/register": (context) => MyRegister(),
        // "/login": (context) => MyLogin(),
        // "/content": (context) => MyContent(),
      },
    );
  }
}
