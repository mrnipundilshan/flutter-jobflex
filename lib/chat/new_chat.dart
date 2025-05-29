import 'package:flutter/material.dart';
import 'package:jobflex/widget/footer.dart' show Footer;

class NewChat extends StatelessWidget {
  const NewChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NewConversationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NewConversationScreen extends StatelessWidget {
  const NewConversationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xFF1C2D5E),
                    ),
                  ),
                  const SizedBox(width: 60),
                  const Text(
                    'New Conversation',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF1C2D5E),
                    ),
                  ),
                ],
              ),
            ),

            // Recipient Input
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                children: const [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Recipient',
                        hintStyle: TextStyle(
                          color: Color(0xFF1C2D5E),
                          fontSize: 14,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF1C2D5E)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF1C2D5E)),
                        ),
                      ),
                    ),
                  ),
                  Icon(Icons.add, color: Color(0xFF1C2D5E)),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Chat Area
            Expanded(child: Container()),

            // Message Input
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFF233A66),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF233A66),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(12),
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: const Footer(),
    );
  }
}
