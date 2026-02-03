import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ✅ Sign Up
  Future<User?> signUp({required String email, required String password}) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Store user details in Firestore with timestamps
    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'uid': userCredential.user!.uid,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(), // Signup timestamp
      // Initial login time
    });

    return userCredential.user;
  }

  // ✅ Sign In
  Future<User?> signIn({required String email, required String password}) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Update lastLogin timestamp on every login
    await _firestore.collection('users').doc(userCredential.user!.uid).update({
      
    });

    return userCredential.user;
  }

  // ✅ Get user details from Firestore
  Future<Map<String, dynamic>?> getUserDetails(String uid) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return doc.data() as Map<String, dynamic>;
    }
    return null;
  }
}
