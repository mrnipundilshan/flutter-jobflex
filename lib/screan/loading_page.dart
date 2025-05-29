import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  final Widget nextPage;

  const LoadingPage({Key? key, required this.nextPage}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    // Simulate a 1-second loading delay
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => widget.nextPage),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8EAF6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 120, // Increased size
              height: 120, // Increased size
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade900),
                strokeWidth:
                    8.0, // Increased stroke width for better visibility
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Loading...',
              style: TextStyle(
                fontSize: 24, // Increased font size
                color: Color(0xFF232C91),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please wait',
              style: TextStyle(
                fontSize: 16, // Increased font size
                color: Color(0xFF232C91),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
