import 'package:flutter/material.dart';
import 'package:jobflex/widget/footer.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(backgroundColor:  Color(0xFFECF1FA)),
      backgroundColor:  Color(0xFF1F2A44),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 450,
              decoration: const BoxDecoration(
                color: Color(0xFFECF1FA),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFECF1FA),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back button and title
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Color(0xFF0A2B52)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Forgot Password',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color:  Color(0xFF1F2A44),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Don't worry! Enter your registered email address. We’ll send you a link to reset your password.",
                      style: TextStyle(
                        fontSize: 14,
                        color:  Color(0xFF1F2A44),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "E-mail Address",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color:  Color(0xFF1F2A44),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                      
                        hintText: 'Enter your E-mail Address',
                        filled: true,
                        fillColor: const Color(0xFFDAE3F3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Send password reset logic
                          final email = emailController.text;
                          if (email.isNotEmpty) {
                            // TODO: Integrate with Firebase or API
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Reset link sent to $email")),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const  Color(0xFF1F2A44),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          "Send code",
                          style: TextStyle(
                            color: Color(0xFFECF1FA),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
