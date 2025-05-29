import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobflex/widget/promoter_footer.dart';

class JobEventCrew extends StatefulWidget {
  final String jobcatagory;
  const JobEventCrew({Key? key, required this.jobcatagory}) : super(key: key);

  @override
  State<JobEventCrew> createState() => _JobEventCrewState();
}

class _JobEventCrewState extends State<JobEventCrew> {
  final _formKey = GlobalKey<FormState>();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> _submitJob() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final user = _auth.currentUser;
        if (user == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please login to post a job')),
          );
          return;
        }

        // Create job data
        final jobData = {
          'jobTitle': jobTitleController.text,
          'category': widget.jobcatagory,
          'skills': skillsController.text,
          'location': locationController.text,
          'email': emailController.text,
          'contact': contactController.text,
          'description': descriptionController.text,
          'postedBy': user.uid,
          'postedAt': FieldValue.serverTimestamp(),
          'status': 'active',
        };

        // Save to Firestore
        await _firestore.collection('jobs').add(jobData);

        // Clear form
        jobTitleController.clear();
        categoryController.clear();
        skillsController.clear();
        locationController.clear();
        emailController.clear();
        contactController.clear();
        descriptionController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Job posted successfully!')),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error posting job: $e')));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF2FB),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF233A66),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Enter your Service/Job',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF233A66),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Form
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildField('Job Title', jobTitleController),

                      _buildField('Skills', skillsController),
                      _buildField('Location', locationController),
                      _buildField('E-mail', emailController),
                      _buildField('Contact', contactController),
                      _buildField(
                        'Description',
                        descriptionController,
                        maxLines: 4,
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildButton(
                            'Submit',
                            _isLoading ? null : () => _submitJob(),
                          ),
                          _buildButton('Cancel', () {
                            Navigator.pop(context);
                          }),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: PromoterFooter(),
    );
  }

  // Widget for text fields
  Widget _buildField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          fillColor: Color(0xFFDDE6FF),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // Widget for submit and cancel buttons
  Widget _buildButton(String label, VoidCallback? onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF233A66),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Text(label, style: const TextStyle(color: Color(0xFFEAF2FB))),
    );
  }
}
