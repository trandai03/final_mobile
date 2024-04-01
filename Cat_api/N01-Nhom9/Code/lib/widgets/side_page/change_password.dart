import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePassWord extends StatefulWidget {
  const ChangePassWord({super.key});

  @override
  State<ChangePassWord> createState() => _ChangePassWordState();
}

class _ChangePassWordState extends State<ChangePassWord> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  var currentUser = FirebaseAuth.instance.currentUser;
  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  changePassword(String oldPassword, String newPassword) async {
    var email = currentUser?.email;
    if (email != null) {
      var cred =
          EmailAuthProvider.credential(email: (email), password: oldPassword);
      await currentUser!.reauthenticateWithCredential(cred).then((value) {
        currentUser!.updatePassword(newPassword);
      }).catchError((error) {
        print(error.toString());
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        title: Center(
            child: Text(
          'Change Password',
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // old password
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: oldPasswordController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Old Password',
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
          ),
          SizedBox(height: 10),
          // new password
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: newPasswordController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'New Password',
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: () async {
              await changePassword(
                oldPasswordController.text,
                newPasswordController.text,
              );
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Text('Change password successfully !!!'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: Text(
              'Change Password',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
