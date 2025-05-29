import 'package:flutter/material.dart';
import 'package:jobflex/widget/footer.dart';

void main() {
  runApp(const ChatSearch());
}

class ChatSearch extends StatelessWidget {
  const ChatSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat List UI',
      debugShowCheckedModeBanner: false,
      home: const ChatListScreen(),
    );
  }
}

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final int _selectedIndex = 0;

  final List<Map<String, dynamic>> chatList = [
    {
      "name": "Tanya Nur",
      "message": "Thank your service.",
      "time": "1 mins ago",
      "unread": 5,
      "image": "assets/tanya.avif",
    },
    {
      "name": "keny Salgado",
      "message": "pls send more details",
      "time": "16 mins ago",
      "unread": 1,
      "image": "assets/keny.jpg",
    },
    {
      "name": "Avin Silva",
      "message": "can you?",
      "time": "1 hour ago",
      "unread": 0,
      "image": "assets/avin.jpg",
    },
    {
      "name": "Elvin Rudrigo",
      "message": "I'll inform later",
      "time": "4 hours ago",
      "unread": 0,
      "image": "assets/elvin.jpg",
    },
    {
      "name": "Shriya Fernando",
      "message": "Hi..!!",
      "time": "8 hours ago",
      "unread": 0,
      "image": "assets/shriya.jpg",
    },
    {
      "name": "Sathya Leno",
      "message": "Yeah...",
      "time": "12 hours ago",
      "unread": 0,
      "image": "assets/sathya.jpg",
    },
    {
      "name": "Henry Singh",
      "message": "i'll send pickup point",
      "time": "21 hours ago",
      "unread": 0,
      "image": "assets/henry.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF233A66),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: const [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 230),
                        child: Text(
                          "Search",
                          style: TextStyle(color: Colors.white54, fontSize: 16),
                        ),
                      ),
                    ),
                    Icon(Icons.search, color: Colors.white),
                  ],
                ),
              ),
            ),

            // Chat list
            Expanded(
              child: ListView.builder(
                itemCount: chatList.length,
                itemBuilder: (context, index) {
                  final chat = chatList[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(chat["image"]),
                    ),
                    title: Text(
                      chat["name"],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      chat["message"],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          chat["time"],
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        if (chat["unread"] > 0)
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF233A66),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              chat["unread"].toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
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
