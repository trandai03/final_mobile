import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> registerUserWithEmailAndPassword(
      String strEmail, String strPassword) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: strEmail, password: strPassword);
      return credential.user;
    } catch (err) {
      print("Co loi tao User: $err");
    }
  }

  Future<User?> loginWithEmailAndPassword(
      String strEmail, String strPassword) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: strEmail, password: strPassword);
      return credential.user;
    } catch (err) {
      print("Co loi tao User: $err");
    }
  }
}
