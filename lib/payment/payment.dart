import 'package:flutter/material.dart';
import 'package:jobflex/widget/footer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _picker = ImagePicker();
  bool _isLoading = false;
  File? _selectedImage;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController accountHolderController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController referenceNoteController = TextEditingController();

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
    }
  }

  Future<void> _submitPayment() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final user = _auth.currentUser;
        if (user == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please login to submit payment')),
          );
          return;
        }

        // Create payment data
        final paymentData = {
          'userEmail': emailController.text,
          'accountHolderName': accountHolderController.text,
          'bankName': bankNameController.text,
          'accountNumber': accountNumberController.text,
          'amount': amountController.text,
          'referenceNote': referenceNoteController.text,
          'promoterEmail': user.email,
          'submittedAt': FieldValue.serverTimestamp(),
          'status': 'pending',
        };

        // Save to Firestore
        await _firestore.collection('payments').add(paymentData);

        // Clear form
        emailController.clear();
        accountHolderController.clear();
        bankNameController.clear();
        accountNumberController.clear();
        amountController.clear();
        referenceNoteController.clear();
        setState(() {
          _selectedImage = null;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Payment details submitted successfully!'),
          ),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error submitting payment: $e')));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    accountHolderController.dispose();
    bankNameController.dispose();
    accountNumberController.dispose();
    amountController.dispose();
    referenceNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F6FF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF233A66)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Payment',
          style: TextStyle(color: Color(0xFF233A66)),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '• Please complete your payment via bank transfer or mobile payment. Once done, upload a clear photo or screenshot of your payment receipt below.',
                style: TextStyle(fontSize: 14, color: Color(0xFF233A66)),
              ),
              const SizedBox(height: 20),

              const SizedBox(height: 20),
              _buildTextField('User Email', controller: emailController),
              const SizedBox(height: 15),
              _buildTextField(
                'Account Holder Name',
                controller: accountHolderController,
              ),
              const SizedBox(height: 15),
              _buildTextField('Bank Name', controller: bankNameController),
              const SizedBox(height: 15),
              _buildTextField(
                'Account Number',
                controller: accountNumberController,
              ),
              const SizedBox(height: 15),
              _buildTextField('Amount', controller: amountController),
              const SizedBox(height: 15),
              _buildTextField(
                'Reference Note',
                hint: 'e.g., "Use your User ID as the reference"',
                controller: referenceNoteController,
              ),
              const SizedBox(height: 15),
              _buildUploadBox(),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitPayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF233A66),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child:
                      _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                            'Submit Payment',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }

  Widget _buildTextField(
    String label, {
    String? hint,
    TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint ?? '',
            filled: true,
            fillColor: const Color(0xFFDDE6FF),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadBox() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFB9B9B9),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFB9B9B9)),
        ),
        child:
            _selectedImage != null
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(_selectedImage!, fit: BoxFit.cover),
                )
                : const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.upload_file,
                        size: 40,
                        color: Color(0xFF233A66),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Upload Receipt",
                        style: TextStyle(color: Color(0xFF233A66)),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
