// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // ================= SIGN UP =================
//   Future<User?> signUp({
//     required String email,
//     required String password,
//     String role = 'user', // default role
//   }) async {
//     UserCredential userCredential =
//         await _auth.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );

//     // Save user role in Firestore
//     await _firestore
//         .collection('users')
//         .doc(userCredential.user!.uid)
//         .set({
//       'email': email,
//       'role': role,
//       'createdAt': FieldValue.serverTimestamp(),
//     });

//     return userCredential.user;
//   }

//   // ================= SIGN IN =================
//   Future<String> signIn({
//     required String email,
//     required String password,
//   }) async {
//     UserCredential userCredential =
//         await _auth.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );

//     final uid = userCredential.user!.uid;

//     final doc =
//         await _firestore.collection('users').doc(uid).get();

//     if (!doc.exists) {
//       throw Exception('User data not found');
//     }

//     return doc['role']; // 'admin' or 'user'
//   }

//   // ================= SIGN OUT =================
//   Future<void> signOut() async {
//     await _auth.signOut();
//   }

//   // ================= CURRENT USER ROLE =================
//   Future<String?> getCurrentUserRole() async {
//     final user = _auth.currentUser;
//     if (user == null) return null;

//     final doc =
//         await _firestore.collection('users').doc(user.uid).get();

//     return doc.data()?['role'];
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 🔐 SIGN UP
  Future<void> signUp({
    required String email,
    required String password,
    required String role, // 'admin' or 'user'
  }) async {
    UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = userCredential.user!.uid;

    await _firestore.collection('users').doc(uid).set({
      'email': email,
      'role': role,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // 🔐 LOGIN + GET ROLE
  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential =
        await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = userCredential.user!.uid;

    final doc =
        await _firestore.collection('users').doc(uid).get();

    if (!doc.exists) {
      throw 'User record not found';
    }

    final role = doc.data()!['role'];

    return role.toString().trim().toLowerCase();
  }

  // 🚪 LOGOUT
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
