

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ================= UPDATE USER =================
  Future<void> updateUser(
    String name,
    String email,
    String phoneNumber,
  ) async {
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

  // ================= UI =================
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
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text("User data not found"));
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;

        return Scaffold(
appBar: AppBar(automaticallyImplyLeading: true,),
          body:  SingleChildScrollView(
            
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
          
                  /// ===== PROFILE CARD =====
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
          
                        /// Header
                        Row(
                          children: [
                            const Text(
                              "Profile",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                openEditDialog(
                                  name: data['name'] ?? '',
                                  email: data['email'] ?? '',
                                  phone: data['phonenumber'] ?? '',
                                );
                              },
                            ),
                          ],
                        ),
          
                        const SizedBox(height: 12),
          
                        /// Name
                        Text(
                          data['name'] ?? 'N/A',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
          
                        const SizedBox(height: 4),
          
                        /// Email
                        Text(
                          data['email'] ?? 'N/A',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
          
                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 16),
          
                        /// Phone
                        Row(
                          children: [
                            const Icon(Icons.phone, size: 18),
                            const SizedBox(width: 10),
                            Text(
                              data['phonenumber'] ?? 'N/A',
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
          
                        const SizedBox(height: 12),
          
                        /// Role
                        Row(
                          children: [
                            const Icon(Icons.verified_user, size: 18),
                            const SizedBox(width: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                (data['role'] ?? 'N/A')
                                    .toString()
                                    .toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          
                  const SizedBox(height: 30),
          
                  /// ===== THEME SECTION =====
                  // Container(
                  //   padding: const EdgeInsets.all(20),
                  //   decoration: BoxDecoration(
                  //     color: Theme.of(context).cardColor,
                  //     borderRadius: BorderRadius.circular(16),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       const Icon(Icons.palette),
                  //       const SizedBox(width: 12),
                  //       const Expanded(
                  //         child: Text(
                  //           "Dark Mode",
                  //           style: TextStyle(
                  //             fontSize: 16,
                  //             fontWeight: FontWeight.w500,
                  //           ),
                  //         ),
                  //       ),
                  //       Switch(
                  //         value: themeNotifier.value == ThemeMode.dark,
                  //         onChanged: (value) {
                  //           themeNotifier.value =
                  //               value ? ThemeMode.dark : ThemeMode.light;
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  // ),
          
                  const SizedBox(height: 40),
          
                  /// ===== LOGOUT BUTTON =====
                  // SizedBox(
                  //   width: double.infinity,
                  //   height: 50,
                  //   child: ElevatedButton.icon(
                  //     onPressed: () async {
                  //       await _auth.signOut();
                  //     },
                  //     icon: const Icon(Icons.logout),
                  //     label: const Text(
                  //       "Logout",
                  //       style: TextStyle(fontSize: 16),
                  //     ),
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors.redAccent,
                  //       foregroundColor: Colors.white,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(12),
                  //       ),
                  //       elevation: 3,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}