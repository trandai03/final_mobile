import 'dart:io';
import 'dart:ui';
import 'package:cat_api/widgets/side_page/main_page.dart';

import 'modules/routes.dart';
import 'package:get/get.dart';
import 'package:cat_api/widgets/home_page.dart';
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
    return GetMaterialApp(
      title: 'CatApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SFProMedium',
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: Colors.red,
        ),
      ),
      initialRoute: '/main_page',
      getPages: routes,
    );

    // home: HomePage(),
    // routes: {
    //   "/homepage": (context) => HomePage(),
    //   // "/register": (context) => RegisterPage(showLoginPage: showLoginPage),
    //   // "/login": (context) => MyLogin(),
    //   // "/content": (context) => MyContent(),
    //   // "/login": (context) => LoginPage(),
    // },
  }
}
