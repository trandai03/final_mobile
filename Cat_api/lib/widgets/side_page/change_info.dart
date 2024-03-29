import 'package:cat_api/widgets/setting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangeInfoPage extends StatefulWidget {
  const ChangeInfoPage({super.key});

  @override
  State<ChangeInfoPage> createState() => _ChangeInfoPageState();
}

class _ChangeInfoPageState extends State<ChangeInfoPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final ageController = TextEditingController();
  var currentUser = FirebaseAuth.instance.currentUser;
  String? user_id;

  @override
  Future<String> userID() async {
    String tmp = "";
    var querySnapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: currentUser!.email)
        .get();

    for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
      tmp = documentSnapshot.id;
      break;
    }
    print("Ket qua tmp la: " + tmp);
    return tmp;
  }

  updateUser(String newFirstName, String newLastName, String newAge) async {
    try {
      String user_id = await userID();
      await FirebaseFirestore.instance.collection('user').doc(user_id).update({
        'first name': newFirstName,
        'last name': newLastName,
        'age': newAge,
      });
      print("Updated successfully!");
    } catch (error) {
      print("Error updating user data: $error");
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
          // first name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: firstNameController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'First Name',
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
          ),
          SizedBox(height: 10),
          // last name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: lastNameController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Last Name',
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // Age
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: ageController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Age',
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: () {
              updateUser(firstNameController.text, lastNameController.text,
                  ageController.text);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Text('Change Infomation successfully !!!'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SettingPage();
                        }));
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: Text(
              'UPDATE',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
