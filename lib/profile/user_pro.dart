import 'package:flutter/material.dart';
import 'package:jobflex/widget/footer.dart';
import 'package:jobflex/screan/your_list.dart'; // Import YourListPage

class UserPro extends StatelessWidget {
  const UserPro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFECF1FA),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF233A66)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 600,
            decoration: const BoxDecoration(
              color: Color(0xFFECF1FA),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(
                            'img/User.jpg',
                          ), // Replace with your image
                        ),
                        const CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0xFFECF1FA),
                          child: Icon(
                            Icons.edit,
                            size: 18,
                            color: Color(0xFF233A66),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'R.S Rusiru',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2A44),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text('Age', style: TextStyle(color: Color(0xFFB9B9B9))),
                        Text(
                          'Status',
                          style: TextStyle(color: Color(0xFFB9B9B9)),
                        ),
                        Text('NIC', style: TextStyle(color: Color(0xFFB9B9B9))),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                // Full Name
                const Text(
                  'Full Name',
                  style: TextStyle(color: Color(0xFF2D4C82)),
                ),
                const Text(
                  'Regawan sudarshan Rusiru',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF233A66),
                  ),
                ),
                const SizedBox(height: 20),

                // Name with initials
                const Text(
                  'Name with initials',
                  style: TextStyle(color: Color(0xFF2D4C82)),
                ),
                const Text(
                  'R.S Rusiru',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF233A66),
                  ),
                ),
                const SizedBox(height: 20),

                // Email
                const Text(
                  'E-mail',
                  style: TextStyle(color: Color(0xFF2D4C82)),
                ),
                const Text(
                  'rusirusudarshan678@gmail.com',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF233A66),
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(height: 20),

                // Address
                const Text(
                  'Adress',
                  style: TextStyle(color: Color(0xFF2D4C82)),
                ),
                const Text(
                  'No 12, Galle Road, Colombo',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF233A66),
                  ),
                ),
                const SizedBox(height: 20),

                // Phone
                const Text(
                  'Phone number',
                  style: TextStyle(color: Color(0xFF2D4C82)),
                ),
                const Text(
                  '077 123 4567',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF233A66),
                  ),
                ),

                const SizedBox(height: 30),

                // Star rating (Centered)
                const Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.black),
                      Icon(Icons.star, color: Colors.black),
                      Icon(Icons.star, color: Colors.black),
                      Icon(Icons.star, color: Color(0xFFA4BBE4)),
                      Icon(Icons.star, color: Color(0xFFA4BBE4)),
                    ],
                  ),
                ),
                const SizedBox(height: 20), // Add some space before the button
                // Your List Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const YourListPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF233A66),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                      textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text("Your List"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF233A66),
      bottomNavigationBar: const Footer(),
    );
  }
}
