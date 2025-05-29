import 'package:flutter/material.dart';
import 'package:jobflex/widget/constants.dart';

class PassSucc extends StatelessWidget {
  const PassSucc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JPrimaryColor, // Dark blue background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Password Succesfull !!',
              style: TextStyle(fontSize: 32, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Icon(
              Icons.check_circle_outline,
              size: 250,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
