import 'package:flutter/material.dart';
import 'package:jobflex/auth/auth.dart';
import 'package:jobflex/startpages/loging.dart';

class SignUpPage extends StatefulWidget {
  final String role;
  SignUpPage({super.key, required this.role});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cpasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final contentHeight = screenHeight - 220; // subtract logo height

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF0B2B56), // navy blue background
        body: Column(
          children: [
            // Top image
            SizedBox(
              width: double.infinity,
              child: Image.asset(
                'assets/jobflex_logo.png',
                fit: BoxFit.cover,
                height: 220,
              ),
            ),

            // Main content (no navy blue gap at the bottom)
            Expanded(
              child: Transform.translate(
                offset: const Offset(0, -20), // overlap slightly with image
                child: Container(
                  height: contentHeight + 20, // ensure it fills screen
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F9FF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 22,
                            color: Color(0xFF0B2B56),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildLabeledField("Full Name", fullnameController),
                        _buildLabeledField(
                          "E-mail",
                          emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        _buildLabeledField(
                          "Phone number",
                          phoneController,
                          keyboardType: TextInputType.phone,
                        ),
                        _buildLabeledField(
                          "Password",
                          passwordController,
                          isObscure: true,
                        ),
                        _buildLabeledField(
                          "Confirm password",
                          cpasswordController,
                          isObscure: true,
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () {
                              _signup();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0B2B56),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: const [
                            Expanded(child: Divider(color: Colors.grey)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Or",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Expanded(child: Divider(color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/google_icon.png', height: 40),
                            const SizedBox(width: 30),
                            Image.asset('assets/facebook_icon.png', height: 40),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/login',
                                );
                              },
                              child: Text(
                                "Already have an account? ",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Text(
                              "Log in",
                              style: TextStyle(
                                color: Colors.pinkAccent,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signup() async {
    // Validate passwords match
    if (passwordController.text != cpasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    } else {
      // Validate passwords match

      final user = await AuthService().createUserWithEmaiAndPassword(
        fullnameController.text,
        emailController.text,
        phoneController.text,
        passwordController.text,
        widget.role, // Add the missing fifth argument (role)
      );

      if (user != null) {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Text(
                  "ACCOUNT STATUS",
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
                content: Text(
                  "ACCOUNT SUCCESSFULLY CREATED",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Dismiss the alert

                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => LogingScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.grey[800], fontSize: 16),
                    ),
                  ),
                ],
              ),
        );
      }
    }
  }

  Widget _buildLabeledField(
    String label,
    TextEditingController texteditingcontroller, {
    bool isObscure = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF0B2B56),
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: texteditingcontroller,
          obscureText: isObscure,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFE0E0E0),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
