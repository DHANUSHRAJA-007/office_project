import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, dynamic>? userData;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        setState(() => loading = false);
        return;
      }

      final doc =
          await _firestore.collection('users').doc(user.uid).get();

      if (doc.exists) {
        setState(() {
          userData = doc.data();
          loading = false;
        });
      } else {
        setState(() => loading = false);
      }
    } catch (e) {
      debugPrint("PROFILE ERROR: $e");
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 🔄 Loading state
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    // ❌ No user data
    if (userData == null) {
      return const Center(child: Text("User data not found"));
    }

    return  Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Profile"),
            // 👤 NAME
            Text(
              userData!['name'] ?? 'N/A',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),

            // 📧 EMAIL
            Text(
              userData!['email'] ?? 'N/A',
              style: const TextStyle(color: Colors.grey),
            ),

            const Divider(height: 32),

            // 📞 PHONE
            Row(
              children: [
                const Icon(Icons.phone, size: 18),
                const SizedBox(width: 8),
                Text(userData!['phonenumber'] ?? 'N/A'),
              ],
            ),
            const SizedBox(height: 12),

            // 🧑‍💼 ROLE
            Row(
              children: [
                const Icon(Icons.verified_user, size: 18),
                const SizedBox(width: 8),
                Text(
                  userData!['role']?.toString().toUpperCase() ?? 'N/A',
                ),
              ],
            ),

            const Spacer(),

            // 🚪 LOGOUT (optional)
            ElevatedButton.icon(
              onPressed: ()  {
                
              },
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      
    );
  }
}
