import 'package:flutter/material.dart';

class PaymentSuccessfulScreen extends StatelessWidget {
  const PaymentSuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A2A4B), // Dark blue background
      body: Column(
        children: [
          // Top Section (Curved)
          Container(
            height:
                MediaQuery.of(context).size.height *
                0.3, // Adjust height as needed
            decoration: const BoxDecoration(
              color: Color(0xFFECF1FA), // Light blue background
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                40,
                16,
                0,
              ), // Adjust padding as needed
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color(0xFF233A66),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Payment Successful !!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF233A66),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Image Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                'img/payment_successful.png', // Replace with your image asset
                fit: BoxFit.contain,
              ),
            ),
          ),

          // OK Button Section
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: ElevatedButton(
              onPressed: () {
                // Add your navigation logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(
                  0xFFECF1FA,
                ), // Light blue button color
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "OK",
                style: TextStyle(color: Color(0xFF233A66)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}