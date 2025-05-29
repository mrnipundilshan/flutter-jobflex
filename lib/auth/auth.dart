import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<User?> createUserWithEmaiAndPassword(
    String fullname,
    String email,
    String phone,
    String password,
    String role,
  ) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Store additional user details in Firestore
      if (credential.user != null) {
        await _firestore.collection('users').doc(credential.user!.uid).set({
          'fullname': fullname,
          'email': email,
          'phone': phone,
          'role': role,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      return credential.user;
    } catch (e) {
      log("account create failed: $e");
    }
    return null;
  }

  Future<Map<String, dynamic>?> logWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        // Get user role from Firestore
        final userDoc =
            await _firestore
                .collection('users')
                .doc(credential.user!.uid)
                .get();
        if (userDoc.exists) {
          return {'user': credential.user, 'role': userDoc.data()?['role']};
        }
      }
      return null;
    } catch (e) {
      log("user login failed");
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("something went wrong");
    }
  }
}
