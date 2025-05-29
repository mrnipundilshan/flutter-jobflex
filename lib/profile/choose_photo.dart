import 'package:flutter/material.dart';

class ChoosePhoto extends StatelessWidget {
  const ChoosePhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F7FE),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF233A66)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Change your profile photo',
          style: TextStyle(color: Color(0xFF233A66), fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const CircleAvatar(
                  radius: 70,
                  backgroundColor: Color(0xFFDAE3F3),
                  backgroundImage: AssetImage('img/User.jpg'), // Replace with your image
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const CircleAvatar(
                      radius: 70,
                      backgroundColor: Color(0xFFDAE3F3),
                      child: Icon(
                        Icons.person,
                        size: 70,
                        color: Color(0xFF233A66),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5, right: 5),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 20,
                        color: Color(0xFF233A66),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 50),
            decoration: const BoxDecoration(
              color: Color(0xFF233A66),
              borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color:Color(0xFFDAE3F3) ,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 30,
                        color: Color(0xFF1F2A44),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Camera',
                      style: TextStyle(color:  Color(0xFFDAE3F3), fontSize: 16),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color:  Color(0xFFDAE3F3),
                      ),
                      child: const Icon(
                        Icons.image,
                        size: 30,
                        color:Color(0xFF233A66),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Gallery',
                      style: TextStyle(color: Color(0xFFDAE3F3), fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}