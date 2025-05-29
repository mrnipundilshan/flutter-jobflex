import 'package:flutter/material.dart';

class PaymentError extends StatelessWidget {
  final Function? onSuccess; // Optional callback when OK is pressed
  final String? message; // Optional custom success message

  // ignore: use_super_parameters
  const PaymentError(
      {Key? key, this.onSuccess, this.message = "Payment Cancel !!"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E3A6C), // Dark navy blue background
      body: Column(
        children: [
          // Top light section with back button and success message
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFF0F4F9), // Light background color
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
              ),
            ),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: Color(0xFF1E3A6C), size: 30),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(height: 60),
                Text(
                  message ?? "Payment Cancel !!",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Image.asset(
            "Assets/error.png",
            width: 300,
            height: 300,
          ),

          SizedBox(
            height: 50,
          ),
          // Retry Button
          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: ElevatedButton(
              onPressed: () {
                // Execute the success callback if provided
                if (onSuccess != null) {
                  onSuccess!();
                }

                // Navigate back to previous screen
                Navigator.of(context).pop();

                // Alternatively, you can navigate to a specific screen like home
                // Navigator.of(context).pushReplacementNamed('/home');
                // or
                // Navigator.of(context).pushAndRemoveUntil(
                //   MaterialPageRoute(builder: (context) => HomeScreen()),
                //   (route) => false,
                // );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF0F4F9),
                minimumSize: const Size(150, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 3, // Added shadow for better button appearance
              ),
              child: const Text(
                "Retry",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1E3A6C),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
