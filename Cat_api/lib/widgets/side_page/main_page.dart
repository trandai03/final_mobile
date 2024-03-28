import 'package:cat_api/widgets/navigation.dart';
import 'package:cat_api/widgets/side_page/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Mainpage extends StatelessWidget {
  const Mainpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return NavigationBarApp();
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
