// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:office_project/theme_controller.dart';

// // class SettingsPage extends StatefulWidget {
// //   const SettingsPage({super.key});

// //   @override
// //   State<SettingsPage> createState() => _SettingsPageState();
// // }

// // class _SettingsPageState extends State<SettingsPage> {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// //   // ================= UPDATE USER =================
// //   Future<void> updateUser(
// //     String name,
// //     String email,
// //     String phoneNumber,
// //   ) async {
// //     final user = _auth.currentUser;
// //     if (user == null) return;

// //     await _firestore.collection('users').doc(user.uid).update({
// //       'name': name,
// //       'email': email,
// //       'phonenumber': phoneNumber,
// //     });
// //   }

// //   // ================= EDIT DIALOG =================
// //   void openEditDialog({
// //     required String name,
// //     required String email,
// //     required String phone,
// //   }) {
// //     final nameController = TextEditingController(text: name);
// //     final emailController = TextEditingController(text: email);
// //     final phoneController = TextEditingController(text: phone);

// //     showDialog(
// //       context: context,
// //       builder: (context) {
// //         return AlertDialog(
// //           title: const Text("Edit Profile"),
// //           content: SingleChildScrollView(
// //             child: Column(
// //               children: [
// //                 TextField(
// //                   controller: nameController,
// //                   decoration: const InputDecoration(labelText: "Name"),
// //                 ),
// //                 const SizedBox(height: 8),
// //                 TextField(
// //                   controller: emailController,
// //                   decoration: const InputDecoration(labelText: "Email"),
// //                 ),
// //                 const SizedBox(height: 8),
// //                 TextField(
// //                   controller: phoneController,
// //                   decoration: const InputDecoration(labelText: "Phone Number"),
// //                   keyboardType: TextInputType.phone,
// //                 ),
// //               ],
// //             ),
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () => Navigator.pop(context),
// //               child: const Text("Cancel"),
// //             ),
// //             ElevatedButton(
// //               onPressed: () async {
// //                 await updateUser(
// //                   nameController.text.trim(),
// //                   emailController.text.trim(),
// //                   phoneController.text.trim(),
// //                 );
// //                 Navigator.pop(context);
// //               },
// //               child: const Text("Save"),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   // ================= UI =================
// //   @override
// //   Widget build(BuildContext context) {
// //     final user = _auth.currentUser;

// //     if (user == null) {
// //       return const Center(child: Text("User not logged in"));
// //     }

// //     return StreamBuilder<DocumentSnapshot>(
// //       stream:
// //           _firestore.collection('users').doc(user.uid).snapshots(),
// //       builder: (context, snapshot) {
// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           return const Center(child: CircularProgressIndicator());
// //         }

// //         if (!snapshot.hasData || !snapshot.data!.exists) {
// //           return const Center(child: Text("User data not found"));
// //         }

// //         final data = snapshot.data!.data() as Map<String, dynamic>;

// //         return Padding(
// //           padding: const EdgeInsets.all(24),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               // ===== HEADER =====
// //               Row(
// //                 children: [
// //                   const Text(
// //                     "Profile",
// //                     style: TextStyle(
// //                       fontSize: 20,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                   const Spacer(),
// //                   IconButton(
// //                     icon: const Icon(Icons.edit),
// //                     onPressed: () {
// //                       openEditDialog(
// //                         name: data['name'] ?? '',
// //                         email: data['email'] ?? '',
// //                         phone: data['phonenumber'] ?? '',
// //                       );
// //                     },
// //                   ),
// //                 ],
// //               ),

// //               const SizedBox(height: 16),

// //               // ===== NAME =====
// //               Text(
// //                 data['name'] ?? 'N/A',
// //                 style: Theme.of(context).textTheme.headlineMedium,
// //               ),

// //               const SizedBox(height: 6),

// //               // ===== EMAIL =====
// //               Text(
// //                 data['email'] ?? 'N/A',
// //                 style: const TextStyle(color: Colors.grey),
// //               ),

// //               const Divider(height: 32),

// //               // ===== PHONE =====
// //               Row(
// //                 children: [
// //                   const Icon(Icons.phone, size: 18),
// //                   const SizedBox(width: 8),
// //                   Text(data['phonenumber'] ?? 'N/A'),
// //                 ],
// //               ),

// //               const SizedBox(height: 12),

// //               // ===== ROLE =====
// //               Row(
// //                 children: [
// //                   const Icon(Icons.verified_user, size: 18),
// //                   const SizedBox(width: 8),
// //                   Text(
// //                     (data['role'] ?? 'N/A').toString().toUpperCase(),
// //                   ),
// //                 ],
// //               ),
// //               Spacer(),

// //                  Column(
// //   children: [
// //     const Text(
// //       "Theme",
// //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //     ),

// //     const SizedBox(height: 12),

// //     Row(
// //       mainAxisAlignment: MainAxisAlignment.center,
// //       children: [
// //         const Icon(Icons.light_mode),
// //         Switch(
// //           value: themeNotifier.value == ThemeMode.dark,
// //           onChanged: (value) {
// //             themeNotifier.value =
// //                 value ? ThemeMode.dark : ThemeMode.light;
// //           },
// //         ),
// //         const Icon(Icons.dark_mode),
// //       ],
// //     ),
// //   ],
// // ),

// //                Spacer(),

// //               // ===== LOGOUT =====
// //               ElevatedButton.icon(
// //                 onPressed: () async {
// //                   await _auth.signOut();
// //                 },
// //                 icon: const Icon(Icons.logout),
// //                 label: const Text("Logout"),
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Colors.red,
// //                   foregroundColor: Colors.white,
// //                   minimumSize: const Size(double.infinity, 48),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   // ================= UPDATE USER =================
//   Future<void> updateUser(
//     String name,
//     String email,
//     String phoneNumber,
//   ) async {
//     final user = _auth.currentUser;
//     if (user == null) return;

//     await _firestore.collection('users').doc(user.uid).update({
//       'name': name,
//       'email': email,
//       'phonenumber': phoneNumber,
//     });
//   }

//   // ================= EDIT DIALOG =================
//   void openEditDialog({
//     required String name,
//     required String email,
//     required String phone,
//   }) {
//     final nameController = TextEditingController(text: name);
//     final emailController = TextEditingController(text: email);
//     final phoneController = TextEditingController(text: phone);

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           title: const Text(
//             "Edit Profile",
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           content: Material(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   TextField(
//                     controller: nameController,
//                     decoration: const InputDecoration(
//                       labelText: "Name",
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   TextField(
//                     controller: emailController,
//                     decoration: const InputDecoration(
//                       labelText: "Email",
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   TextField(
//                     controller: phoneController,
//                     decoration: const InputDecoration(
//                       labelText: "Phone Number",
//                       border: OutlineInputBorder(),
//                     ),
//                     keyboardType: TextInputType.phone,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 await updateUser(
//                   nameController.text.trim(),
//                   emailController.text.trim(),
//                   phoneController.text.trim(),
//                 );
//                 Navigator.pop(context);
//               },
//               child: const Text("Save"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // ================= UI =================
//   @override
//   Widget build(BuildContext context) {
//     final user = _auth.currentUser;

//     if (user == null) {
//       return const Center(child: Text("User not logged in"));
//     }

//     return StreamBuilder<DocumentSnapshot>(
//       stream: _firestore.collection('users').doc(user.uid).snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (!snapshot.hasData || !snapshot.data!.exists) {
//           return const Center(child: Text("User data not found"));
//         }

//         final data = snapshot.data!.data() as Map<String, dynamic>;

//         return Scaffold(
// appBar: AppBar(automaticallyImplyLeading: true,),
//           body:  SingleChildScrollView(

//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [

//                   /// ===== PROFILE CARD =====
//                   Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).cardColor,
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.05),
//                           blurRadius: 10,
//                           offset: const Offset(0, 4),
//                         )
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [

//                         /// Header
//                         Row(
//                           children: [
//                             const Text(
//                               "Profile",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const Spacer(),
//                             IconButton(
//                               icon: const Icon(Icons.edit),
//                               onPressed: () {
//                                 openEditDialog(
//                                   name: data['name'] ?? '',
//                                   email: data['email'] ?? '',
//                                   phone: data['phonenumber'] ?? '',
//                                 );
//                               },
//                             ),
//                           ],
//                         ),

//                         const SizedBox(height: 12),

//                         /// Name
//                         Text(
//                           data['name'] ?? 'N/A',
//                           style: Theme.of(context).textTheme.headlineSmall,
//                         ),

//                         const SizedBox(height: 4),

//                         /// Email
//                         Text(
//                           data['email'] ?? 'N/A',
//                           style: TextStyle(
//                             color: Colors.grey.shade600,
//                           ),
//                         ),

//                         const SizedBox(height: 20),
//                         const Divider(),
//                         const SizedBox(height: 16),

//                         /// Phone
//                         Row(
//                           children: [
//                             const Icon(Icons.phone, size: 18),
//                             const SizedBox(width: 10),
//                             Text(
//                               data['phonenumber'] ?? 'N/A',
//                               style: const TextStyle(fontSize: 15),
//                             ),
//                           ],
//                         ),

//                         const SizedBox(height: 12),

//                         /// Role
//                         Row(
//                           children: [
//                             const Icon(Icons.verified_user, size: 18),
//                             const SizedBox(width: 10),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 10, vertical: 4),
//                               decoration: BoxDecoration(
//                                 color: Colors.blue.withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: Text(
//                                 (data['role'] ?? 'N/A')
//                                     .toString()
//                                     .toUpperCase(),
//                                 style: const TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.blue,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 30),

//                   /// ===== THEME SECTION =====
//                   // Container(
//                   //   padding: const EdgeInsets.all(20),
//                   //   decoration: BoxDecoration(
//                   //     color: Theme.of(context).cardColor,
//                   //     borderRadius: BorderRadius.circular(16),
//                   //   ),
//                   //   child: Row(
//                   //     children: [
//                   //       const Icon(Icons.palette),
//                   //       const SizedBox(width: 12),
//                   //       const Expanded(
//                   //         child: Text(
//                   //           "Dark Mode",
//                   //           style: TextStyle(
//                   //             fontSize: 16,
//                   //             fontWeight: FontWeight.w500,
//                   //           ),
//                   //         ),
//                   //       ),
//                   //       Switch(
//                   //         value: themeNotifier.value == ThemeMode.dark,
//                   //         onChanged: (value) {
//                   //           themeNotifier.value =
//                   //               value ? ThemeMode.dark : ThemeMode.light;
//                   //         },
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ),

//                   const SizedBox(height: 40),

//                   /// ===== LOGOUT BUTTON =====
//                   // SizedBox(
//                   //   width: double.infinity,
//                   //   height: 50,
//                   //   child: ElevatedButton.icon(
//                   //     onPressed: () async {
//                   //       await _auth.signOut();
//                   //     },
//                   //     icon: const Icon(Icons.logout),
//                   //     label: const Text(
//                   //       "Logout",
//                   //       style: TextStyle(fontSize: 16),
//                   //     ),
//                   //     style: ElevatedButton.styleFrom(
//                   //       backgroundColor: Colors.redAccent,
//                   //       foregroundColor: Colors.white,
//                   //       shape: RoundedRectangleBorder(
//                   //         borderRadius: BorderRadius.circular(12),
//                   //       ),
//                   //       elevation: 3,
//                   //     ),
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:office_project/screens/loginpage.dart';
import 'package:office_project/screens/privacypolicy.dart';
import 'package:office_project/screens/profilepage.dart';
import 'package:office_project/screens/reports.dart';
import 'package:office_project/screens/termsandcond.dart';
import 'package:office_project/theme_controller.dart';

class Settingspage extends StatelessWidget {
  Settingspage({super.key});
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          // leading: IconButton(
          //   onPressed: () {
          //     Get.back();
          //   },
          //   icon: const Icon(Icons.arrow_back, color: Colors.white),
          // ),
          title: const Text(
            "Settings",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Account Settings",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 480,
                  child: Card(
                    elevation: 2,
                    child: Column(
                      children: [
                        _reportItems(
                          "Profile",
                          '/profile',
                          Icons.person,
                          Icons.arrow_forward_ios,
                        ),

                        Divider(),
                        _reportItems(
                          "Change Password",
                          '/password',
                          Icons.lock,
                          Icons.arrow_forward_ios,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "App Settings",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 480,
                  child: Card(
                    elevation: 2,
                    child: Column(
                      children: [
                        Divider(),
                        _reportItems(
                          "Privacy",
                          '/privacy',
                          Icons.privacy_tip,
                          Icons.arrow_forward_ios,
                        ),
                        Divider(),
                        _reportItems(
                          "Terms & Conditions",
                          '/terms',
                          Icons.file_copy,
                          Icons.arrow_forward_ios,
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.dark_mode),
                          title: Text(
                            "Dark Mode",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: Switch(
                            focusColor: Theme.of(context).cardColor,
                            value: themeNotifier.value == ThemeMode.dark,
                            onChanged: (value) {
                              themeNotifier.value = value
                                  ? ThemeMode.dark
                                  : ThemeMode.light;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Card(
                  elevation: 2,
                  shape: BeveledRectangleBorder(),
                  child: ListTile(
                    leading: Icon(Icons.logout, color: Colors.red),
                    title: InkWell(
                      child: Text(
                        "Log out",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
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
      ),
    );
  }

  Widget _reportItems(String name, route, IconData icon, icon2) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
      trailing: Icon(icon2),
      onTap: () {
        if (route == '/profile') {
          Get.to(ProfilePage());
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
