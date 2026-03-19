import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_project/screens/loginpage.dart';
import 'package:office_project/screens/privacypolicy.dart';
import 'package:office_project/screens/reports.dart';
import 'package:office_project/screens/termsandcond.dart';

class Userprofile extends StatefulWidget {
  const Userprofile({super.key});

  @override
  State<Userprofile> createState() => _UserprofileState();
}

class _UserprofileState extends State<Userprofile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ================= UPDATE USER =================
  Future<void> updateUser(String name, String email, String phoneNumber) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('users').doc(user.uid).update({
      'name': name,
      'email': email,
      'phonenumber': phoneNumber,
    });
  }

  // ================= EDIT DIALOG =================
  void openEditDialog({
    required String name,
    required String email,
    required String phone,
  }) {
    final nameController = TextEditingController(text: name);
    final emailController = TextEditingController(text: email);
    final phoneController = TextEditingController(text: phone);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Edit Profile",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Material(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                await updateUser(
                  nameController.text.trim(),
                  emailController.text.trim(),
                  phoneController.text.trim(),
                );
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;

    if (user == null) {
      return const Center(child: Text("User not logged in"));
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: _firestore.collection('users').doc(user.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Scaffold(
            body: Center(child: Text("User data not found")),
          );
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.green,

            title: const Text(
              "Profile",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15),
            child: ListView(
              children: [
                // ================= PROFILE HEADER =================
                Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.green,
                      child: Text(
                        data['name'] != null
                            ? data['name'][0].toUpperCase()
                            : "U",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    // USER DETAILS
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['name'] ?? "No Name",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            data['phonenumber'] ?? "No Phone",
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(
                            data['email'] ?? "No Email",
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),

                    // EDIT BUTTON
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          191,
                          255,
                          224,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      onPressed: () {
                        openEditDialog(
                          name: data['name'] ?? '',
                          email: data['email'] ?? '',
                          phone: data['phonenumber'] ?? '',
                        );
                      },
                      child: const Text(
                        "Edit",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),

                const Divider(thickness: 1.5),

                // _reportItems(
                // "Profile", '/profile', Icons.person, Icons.arrow_forward_ios),
                // const Divider(),
                _reportItems(
                  "Change Password",
                  '/password',
                  Icons.lock,
                  Icons.arrow_forward_ios,
                ),

                const Divider(),

                _reportItems(
                  "Privacy",
                  '/privacy',
                  Icons.privacy_tip,
                  Icons.arrow_forward_ios,
                ),

                const Divider(),

                _reportItems(
                  "Terms & Conditions",
                  '/terms',
                  Icons.file_copy,
                  Icons.arrow_forward_ios,
                ),

                const Divider(),

                // ================= LOGOUT =================
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Card(
                    elevation: 2,
                    shape: const BeveledRectangleBorder(),
                    child: ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: const Text(
                        "Log out",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      onTap: () async {
                        await _auth.signOut();
                        Get.offAll(() => LoginPage());
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ================= LIST ITEMS =================
  Widget _reportItems(String name, route, IconData icon, icon2) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      trailing: Icon(icon2),
      onTap: () {
        if (route == '/profile') {
        } else if (route == '/report') {
          Get.to(Reports());
        } else if (route == '/privacy') {
          Get.to(PrivacyPolicyPage());
        } else if (route == '/terms') {
          Get.to(TermsAndConditionsPage());
        }
      },
    );
  }
}
