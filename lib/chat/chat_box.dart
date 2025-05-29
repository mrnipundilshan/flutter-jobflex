import 'package:flutter/material.dart';
import 'package:jobflex/widget/footer.dart';

class ChatBox extends StatelessWidget {
  const ChatBox({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat UI',
      debugShowCheckedModeBanner: false,
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final int _currentIndex = 0;

  final List<Map<String, dynamic>> messages = [
    {"text": "Hi!", "isSender": false},
    {"text": "Hi, Good Morning.", "isSender": true},
    {"text": "you're hired.", "isSender": false},
    {"text": "Your shift starts tomorrow at 10 a.m", "isSender": false},
    {"text": "K", "isSender": true},
    {"text": "Thank your Service.", "isSender": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Profile
            Padding(
              padding: EdgeInsets.all(40.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/tanya.avif'),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Tanya Nur',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            // Chat Messages
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: messages.length + 1,
                itemBuilder: (context, index) {
                  if (index == 4) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "04 April 2025",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    );
                  }
                  if (index > 4) index -= 1;
                  final message = messages[index];
                  return Align(
                    alignment:
                        message['isSender']
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF233A66),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        message['text'],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Typing Input Field (above navigation bar)
            Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF233A66),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: SizedBox.shrink(), // No text inside
                    ),
                  ),
                  SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: Color(0xFF233A66),
                    child: Icon(Icons.send, color: Colors.white),
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
