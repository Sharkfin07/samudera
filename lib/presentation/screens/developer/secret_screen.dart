// ! Why Are You Here?
import 'package:flutter/material.dart';

class SecretScreen extends StatelessWidget {
  const SecretScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("")),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
        child: Column(
          children: [
            Text(
              "Why Are You Here?",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(32),
              child: Image.asset("assets/images/s3cr3t.jpg"),
            ),
          ],
        ),
      ),
    );
  }
}
