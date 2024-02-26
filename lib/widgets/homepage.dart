import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trang chu"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).popAndPushNamed("/register"),
              child: Text('Đăng ký'),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
                foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).popAndPushNamed("/login"),
              child: Text(
                "Đăng nhập",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
                foregroundColor: MaterialStatePropertyAll<Color>(Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
