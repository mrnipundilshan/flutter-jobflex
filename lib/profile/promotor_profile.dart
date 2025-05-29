import 'package:flutter/material.dart';
import 'package:jobflex/widget/footer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PromotorProfile extends StatefulWidget {
  const PromotorProfile({super.key});

  @override
  State<PromotorProfile> createState() => _PromotorProfileState();
}

class _PromotorProfileState extends State<PromotorProfile> {
  bool isEditing = false;
  bool isLoading = true;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController nameWithInitialsController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController officialPhoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userData =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();

        if (userData.exists) {
          setState(() {
            fullNameController.text = userData.data()?['fullname'] ?? '';
            nameWithInitialsController.text =
                userData.data()?['nameWithInitials'] ?? '';
            emailController.text = userData.data()?['email'] ?? '';
            addressController.text = userData.data()?['address'] ?? '';
            phoneController.text = userData.data()?['phone'] ?? '';
            ageController.text = userData.data()?['age'] ?? '';

            isLoading = false;
          });
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _saveUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
              'fullname': fullNameController.text,
              'nameWithInitials': nameWithInitialsController.text,
              'email': emailController.text,
              'address': addressController.text,
              'phone': phoneController.text,
              'age': ageController.text,
            });
      }
    } catch (e) {
      print('Error saving user data: $e');
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    nameWithInitialsController.dispose();
    emailController.dispose();
    addressController.dispose();
    phoneController.dispose();
    officialPhoneController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFECF1FA),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF233A66)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isEditing ? Icons.save : Icons.edit,
              color: Color(0xFF233A66),
            ),
            onPressed: () async {
              if (isEditing) {
                await _saveUserData();
              }
              setState(() {
                isEditing = !isEditing;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 660,
            decoration: BoxDecoration(
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
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('img/Promo.jpg'),
                        ),
                        if (isEditing)
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
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fullNameController.text,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2A44),
                          ),
                        ),
                        SizedBox(height: 4),
                        // Text(
                        //   'Age: ${ageController.text}',
                        //   style: TextStyle(color: Color(0xFFB9B9B9)),
                        // ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 60),
                _buildEditableField('Full Name', fullNameController),
                SizedBox(height: 20),
                _buildEditableField(
                  'Name with initials',
                  nameWithInitialsController,
                ),
                SizedBox(height: 20),
                _buildEditableField('E-mail', emailController),
                SizedBox(height: 20),
                _buildEditableField('Address', addressController),
                SizedBox(height: 20),
                _buildEditableField('Phone Number', phoneController),
                SizedBox(height: 20),
                _buildEditableField('Age', ageController),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFF233A66),
      bottomNavigationBar: const Footer(),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Color(0xFF2D4C82))),
        if (isEditing)
          TextField(
            controller: controller,
            style: TextStyle(fontSize: 16, color: Color(0xFF233A66)),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 8),
            ),
          )
        else
          Text(
            controller.text,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF233A66),
              decoration: label == 'E-mail' ? TextDecoration.underline : null,
            ),
          ),
      ],
    );
  }
}
