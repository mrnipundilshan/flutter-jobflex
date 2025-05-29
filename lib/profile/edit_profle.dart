import 'package:flutter/material.dart';

class EditProfle extends StatelessWidget {
  const EditProfle({super.key});

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
          'Edit Profile',
          style: TextStyle(color: Color(0xFF233A66), fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('img/User.jpg'), // Replace with your image
                ),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Color(0xFFB9B9B9),
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Color(0xFFECF1FA),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFECF1FA),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 30,
                        color: Color(0xFF233A66),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text('Full Name', style: TextStyle(color: Color(0xFFB9B9B9))),
            _buildEditableText('Regawan sudarshan Rusiru'),
            const SizedBox(height: 20),
            const Text('Name with initials', style: TextStyle(color: Color(0xFFB9B9B9))),
            _buildEditableText('R.S Rusiru'),
            const SizedBox(height: 20),
            const Text('E-mail', style: TextStyle(color: Color(0xFFB9B9B9))),
            _buildEditableText('rusirusudarshan678@gmail.com'),
            const SizedBox(height: 20),
            const Text('Address', style: TextStyle(color: Color(0xFFB9B9B9))),
            _buildEditableText('No 123, Galle Road, Colombo'),
            const SizedBox(height: 20),
            const Text('Phone number', style: TextStyle(color: Color(0xFFB9B9B9))),
            _buildEditableText('077-1234556'),
            const SizedBox(height: 20),
            const Text('Age', style: TextStyle(color: Color(0xFFB9B9B9))),
            _buildEditableText('25 Yr'),
            const SizedBox(height: 20),
            const Text('Status', style: TextStyle(color: Color(0xFFB9B9B9))),
            _buildEditableText('Student/Employee'),
            const SizedBox(height: 20),
            const Text('NIC', style: TextStyle(color: Color(0xFFB9B9B9))),
            _buildEditableText('0000000000000'),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableText(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: const TextStyle(fontSize: 16)),
        const Icon(Icons.edit, color: Color(0xFF233A66)),
      ],
    );
  }
}