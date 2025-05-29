import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SendCodePasswordScreen extends StatefulWidget {
  const SendCodePasswordScreen({super.key});

  @override
  State<SendCodePasswordScreen> createState() => _SendCodePasswordScreenState();
}

class _SendCodePasswordScreenState extends State<SendCodePasswordScreen> {
  List<String> code = ['', '', '', ''];
  int currentDigit = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECF1FA), // Light blue background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true, // Center the title
        title: const Text(
          "Please check your E-mail", // Title in AppBar
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF233A66),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF233A66)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10), // Reduced height
            const Text(
              "We're send a code to rusirusudarshan678@gmail.com",
              style: TextStyle(fontSize: 16, color: Color(0xFF233A66)),
            ),
            const SizedBox(height: 30),
            // Code Input Boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ), // Increased horizontal padding
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: const Color(0xFF233A66),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          code[index],
                          style: const TextStyle(
                            fontSize: 24,
                            color: Color(0xFF233A66),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Verify Button
            ElevatedButton(
              onPressed: () {
                // Add your verification logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF233A66),
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
                "Verify",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            // Send code again
            const Text(
              "Send code again 00:00",
              style: TextStyle(fontSize: 16, color: Color(0xFF233A66)),
            ),
            const Spacer(),
            // Number Pad
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF233A66),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNumberButton('1', 'ABC'),
                        _buildNumberButton('2', 'DEF'),
                        _buildNumberButton('3', 'GHI'),
                      ],
                    ),
                    const SizedBox(height: 10), // Space between rows
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNumberButton('4', 'JKL'),
                        _buildNumberButton('5', 'MNO'),
                        _buildNumberButton('6', 'PQR'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNumberButton('7', 'STV'),
                        _buildNumberButton('8', 'WXY'),
                        _buildNumberButton('9', ''),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNumberButton('*+#', ''),
                        _buildNumberButton('0', ''),
                        _buildBackspaceButton(), // Backspace icon will be placed here
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number, String letters) {
    return InkWell(
      onTap: () {
        setState(() {
          if (currentDigit < 4) {
            code[currentDigit] = number;
            currentDigit++;
          }
        });
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFFECF1FA),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                number,
                style: const TextStyle(fontSize: 24, color: Color(0xFF233A66)),
              ),
              if (letters.isNotEmpty)
                Text(
                  letters,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF233A66),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackspaceButton() {
    return InkWell(
      onTap: () {
        setState(() {
          if (currentDigit > 0) {
            currentDigit--;
            code[currentDigit] = '';
          }
        });
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFFECF1FA),
        ),
        child: const Center(
          child: Icon(Icons.backspace, size: 30, color: Color(0xFF233A66)),
        ),
      ),
    );
  }
}
