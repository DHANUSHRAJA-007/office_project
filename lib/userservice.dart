import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  /// ✅ Add address ONLY if not exists
  Future<String> addAddress(String address) async {
    final user = _auth.currentUser;

    if (user == null) return "User not logged in";

    final userRef = _firestore.collection('users').doc(user.uid);
    final doc = await userRef.get();

    if (!doc.exists) return "User document not found";

    /// 🔥 Check if address already exists
    if (doc.data()!.containsKey('address') &&
        doc['address'] != null &&
        doc['address'].toString().isNotEmpty) {
      return "Address already exists";
    }

    /// ✅ Add address
    await userRef.update({
      'address': address,
    });

    return "Address added successfully";
  }
}