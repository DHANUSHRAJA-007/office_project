// // import 'package:flutter/gestures.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:office_project/auth.dart';
// // import 'package:office_project/screens/termsandcond.dart';
// // import 'loginpage.dart';

// // class SignupPage extends StatefulWidget {
// //   const SignupPage({super.key});

// //   @override
// //   State<SignupPage> createState() => _SignupPageState();
// // }

// // class _SignupPageState extends State<SignupPage> {
// //   final emailController = TextEditingController();
// //   final nameController = TextEditingController();
// //   final phonenumberController = TextEditingController();
// //   final passwordController = TextEditingController();
// //   final AuthService authService = AuthService();

// //   bool loading = false;
// //   bool isAccepted = false;
// //   void signUpUser() {
// //     // Your signup logic here
// //     print("Signup Successful");
// //   }

// //   Future<void> signUp() async {
// //     setState(() => loading = true);

// //     try {
// //       await authService.signUp(
// //         email: emailController.text.trim(),
// //         password: passwordController.text.trim(),

// //         role: 'user', // 👈 default user
// //         name: nameController.text.trim(),
// //         phonenumber: phonenumberController.text.trim(),
// //       );

// //       Get.snackbar('Success', 'Account created');
// //       Get.offAll(() => const LoginPage());
// //     } catch (e) {
// //       Get.snackbar('Error', e.toString());
// //     } finally {
// //       setState(() => loading = false);
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Sign Up')),
// //       body: Padding(
// //         padding: const EdgeInsets.all(24),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             TextField(
// //               controller: nameController,
// //               decoration: const InputDecoration(labelText: 'name'),
// //             ),
// //             TextField(
// //               controller: phonenumberController,
// //               decoration: const InputDecoration(labelText: 'phone number'),
// //             ),
// //             TextField(
// //               controller: emailController,
// //               decoration: const InputDecoration(labelText: 'Email'),
// //             ),
// //             const SizedBox(height: 16),
// //             TextField(
// //               controller: passwordController,
// //               obscureText: true,
// //               decoration: const InputDecoration(labelText: 'Password'),
// //             ),
// //             const SizedBox(height: 10),
// //             SizedBox(
// //               height: 50,

// //               child: CheckboxListTile(
// //                 value: isAccepted,
// //                 onChanged: (value) {
// //                   setState(() {
// //                     isAccepted = value!;
// //                   });
// //                 },
// //                 title: RichText(
// //                   text: TextSpan(
// //                     text: "I agree to",
// //                     style: TextStyle(color: Colors.black),
// //                     children: [
// //                       TextSpan(
// //                         text: "Terms & Conditions",
// //                         style: TextStyle(
// //                           color: Colors.blue,
// //                           decoration: TextDecoration.underline,
// //                         ),

// //                         recognizer: TapGestureRecognizer()
// //                           ..onTap = () {
// //                             Navigator.push(
// //                               context,
// //                               MaterialPageRoute(
// //                                 builder: (_) => const TermsAndConditionsPage(),
// //                               ),
// //                             );
// //                           },
// //                       ),
// //                     ],
// //                   ),
// //                 ),

// //                 controlAffinity: ListTileControlAffinity.leading,
// //               ),
// //             ),
// //             const SizedBox(height: 24),
// //             loading
// //                 ? const CircularProgressIndicator()
// //                 : ElevatedButton(
// //                     onPressed: isAccepted
// //                         ? () {
// //                             signUp();
// //                           }
// //                         : null,
// //                     child: const Text('Create Account'),
// //                   ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:office_project/auth.dart';
// import 'package:office_project/screens/termsandcond.dart';
// import 'loginpage.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class SignupPage extends StatefulWidget {
//   const SignupPage({super.key});

//   @override
//   State<SignupPage> createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {

//   final emailController = TextEditingController();
//   final nameController = TextEditingController();
//   final phonenumberController = TextEditingController();
//   final passwordController = TextEditingController();

//   final AuthService authService = AuthService();

//   bool loading = false;
//   bool isAccepted = false;

// Future<UserCredential?> signInWithGoogle() async {

//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//   if (googleUser == null) {
//     return null;
//   }

//   final GoogleSignInAuthentication googleAuth =
//       await googleUser.authentication;

//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth.accessToken,
//     idToken: googleAuth.idToken,
//   );

//   return await FirebaseAuth.instance.signInWithCredential(credential);
// }

//   Future<void> signUp() async {
//     setState(() => loading = true);

//     try {
//       await authService.signUp(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//         role: 'user',
//         name: nameController.text.trim(),
//         phonenumber: phonenumberController.text.trim(),
//       );

//       Get.snackbar('Success', 'Account created');
//       Get.offAll(() => const LoginPage());

//     } catch (e) {
//       Get.snackbar('Error', e.toString());
//     } finally {
//       setState(() => loading = false);
//     }
//   }

//   Widget buildTextField(String hint, TextEditingController controller,
//       {bool obscure = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: TextField(
//         controller: controller,
//         obscureText: obscure,
//         decoration: InputDecoration(
//           hintText: hint,
//           filled: true,
//           fillColor: Colors.grey.shade200,
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(40),
//             borderSide: BorderSide.none,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,

//       body: SingleChildScrollView(
//         child: Column(
//           children: [

//             /// ----------- TOP GREEN HEADER -----------
//             Container(
//               height: 320,
//               width: double.infinity,
//               padding: const EdgeInsets.only(top: 80, bottom: 60),
//               decoration: const BoxDecoration(
//                 color: Color(0xff4CAF50),
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(120),
//                   bottomRight: Radius.circular(120),
//                 ),
//               ),
//               child: Column(
//                 children: const [

//                   Icon(Icons.eco, color: Colors.white, size: 60),

//                   SizedBox(height: 10),

//                   Text(
//                     "Quickmart",
//                     style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),

//                   SizedBox(height: 10),

//                   Text(
//                     "Join us today and start\nmanaging your grocery store smarter.",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.white70),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 30),

//             /// ----------- SIGNUP FORM -----------
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Column(
//                 children: [

//                   const Text(
//                     "Sign Up",
//                     style:
//                         TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ),

//                   const SizedBox(height: 20),

//                   buildTextField("Enter your full name", nameController),

//                   buildTextField(
//                       "Enter your phone number", phonenumberController),

//                   buildTextField("Enter your Email", emailController),

//                   buildTextField("Enter Password", passwordController,
//                       obscure: true),

//                   /// -------- TERMS & CONDITIONS ----------
//                   CheckboxListTile(
//                     value: isAccepted,
//                     onChanged: (value) {
//                       setState(() => isAccepted = value!);
//                     },
//                     title: RichText(
//                       text: TextSpan(
//                         text: "I agree to ",
//                         style: const TextStyle(color: Colors.black),
//                         children: [
//                           TextSpan(
//                             text: "Terms & Conditions",
//                             style: const TextStyle(
//                               color: Color(0xff4CAF50),
//                               decoration: TextDecoration.underline,
//                             ),
//                             recognizer: TapGestureRecognizer()
//                               ..onTap = () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (_) =>
//                                         const TermsAndConditionsPage(),
//                                   ),
//                                 );
//                               },
//                           ),
//                         ],
//                       ),
//                     ),
//                     controlAffinity: ListTileControlAffinity.leading,
//                   ),

//                   const SizedBox(height: 20),

//                   /// -------- REGISTER BUTTON ----------
//                   SizedBox(
//                     width: double.infinity,
//                     height: 55,
//                     child: loading
//                         ? const Center(child: CircularProgressIndicator())
//                         : ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xff4CAF50),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             onPressed: isAccepted ? signUp : null,
//                             child: const Text(
//                               "Register",
//                               style:
//                                   TextStyle(fontSize: 18, color: Colors.white),
//                             ),
//                           ),
//                   ),

//                   const SizedBox(height: 20),

//                   /// -------- SIGN IN ----------
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text("Already have an account ? "),
//                       GestureDetector(
//                         onTap: () {
//                           Get.to(() => const LoginPage());
//                         },
//                         child: const Text(
//                           "Sign In",
//                           style: TextStyle(
//                             color: Color(0xff4CAF50),
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),

//                   const SizedBox(height: 30),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:office_project/auth.dart';
// import 'package:office_project/screens/termsandcond.dart';
// import 'loginpage.dart';

// class SignupPage extends StatefulWidget {
//   const SignupPage({super.key});

//   @override
//   State<SignupPage> createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   final emailController = TextEditingController();
//   final nameController = TextEditingController();
//   final phonenumberController = TextEditingController();
//   final passwordController = TextEditingController();

//   final AuthService authService = AuthService();

//   bool loading = false;
//   bool googleLoading = false;
//   bool isAccepted = false;

//   // ================= GOOGLE SIGN IN =================
//   Future<void> signInWithGoogle() async {
//     try {
//       setState(() => googleLoading = true);

//       final GoogleSignIn googleSignIn = GoogleSignIn();

//       final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

//       if (googleUser == null) return;

//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       final credential = GoogleAuthProvider.credential(
//         idToken: googleAuth.idToken,
//         accessToken: googleAuth.accessToken,
//       );

//       await FirebaseAuth.instance.signInWithCredential(credential);

//       Get.snackbar("Success", "Google Sign-In Successful");
//     } catch (e) {
//       Get.snackbar("Error", e.toString());
//     } finally {
//       setState(() => googleLoading = false);
//     }
//   }

//   // ================= EMAIL SIGN UP =================
//   Future<void> signUp() async {
//     if (!isAccepted) {
//       Get.snackbar("Error", "Please accept Terms & Conditions");
//       return;
//     }

//     setState(() => loading = true);

//     try {
//       await authService.signUp(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//         role: 'user',
//         name: nameController.text.trim(),
//         phonenumber: phonenumberController.text.trim(),
//       );

//       Get.snackbar('Success', 'Account created');
//       Get.offAll(() => const LoginPage());
//     } catch (e) {
//       Get.snackbar('Error', e.toString());
//     } finally {
//       setState(() => loading = false);
//     }
//   }

//   // ================= TEXT FIELD =================
//   Widget buildTextField(
//     String hint,
//     TextEditingController controller, {
//     bool obscure = false,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: TextField(
//         controller: controller,
//         obscureText: obscure,
//         decoration: InputDecoration(
//           hintText: hint,
//           filled: true,
//           fillColor: Colors.grey.shade200,
//           contentPadding: const EdgeInsets.symmetric(
//             vertical: 18,
//             horizontal: 20,
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(40),
//             borderSide: BorderSide.none,
//           ),
//         ),
//       ),
//     );
//   }

//   // ================= UI =================
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // HEADER
//             Container(
//               height: 320,
//               width: double.infinity,
//               padding: const EdgeInsets.only(top: 80, bottom: 60),
//               decoration: const BoxDecoration(
//                 color: Color(0xff4CAF50),
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(120),
//                   bottomRight: Radius.circular(120),
//                 ),
//               ),
//               child: Column(
//                 children: const [
//                   Icon(Icons.eco, color: Colors.white, size: 60),
//                   SizedBox(height: 10),
//                   Text(
//                     "Quickmart",
//                     style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     "Join us today and start\nmanaging your grocery store smarter.",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(color: Colors.white70),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 30),

//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Column(
//                 children: [
//                   const Text(
//                     "Sign Up",
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 20),

//                   buildTextField("Enter your full name", nameController),
//                   buildTextField(
//                     "Enter your phone number",
//                     phonenumberController,
//                   ),
//                   buildTextField("Enter your Email", emailController),
//                   buildTextField(
//                     "Enter Password",
//                     passwordController,
//                     obscure: true,
//                   ),

//                   // TERMS
//                   CheckboxListTile(
//                     value: isAccepted,
//                     onChanged: (value) {
//                       setState(() => isAccepted = value!);
//                     },
//                     title: RichText(
//                       text: TextSpan(
//                         text: "I agree to ",
//                         style: const TextStyle(color: Colors.black),
//                         children: [
//                           TextSpan(
//                             text: "Terms & Conditions",
//                             style: const TextStyle(
//                               color: Color(0xff4CAF50),
//                               decoration: TextDecoration.underline,
//                             ),
//                             recognizer: TapGestureRecognizer()
//                               ..onTap = () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (_) =>
//                                         const TermsAndConditionsPage(),
//                                   ),
//                                 );
//                               },
//                           ),
//                         ],
//                       ),
//                     ),
//                     controlAffinity: ListTileControlAffinity.leading,
//                   ),

//                   const SizedBox(height: 20),

//                   // REGISTER BUTTON
//                   SizedBox(
//                     width: double.infinity,
//                     height: 55,
//                     child: loading
//                         ? const Center(child: CircularProgressIndicator())
//                         : ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xff4CAF50),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             onPressed: signUp,
//                             child: const Text(
//                               "Register",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                   ),

//                   const SizedBox(height: 15),

//                   // GOOGLE BUTTON
//                   SizedBox(
//                     width: double.infinity,
//                     height: 55,
//                     child: googleLoading
//                         ? const Center(child: CircularProgressIndicator())
//                         : OutlinedButton(
//                             onPressed: signInWithGoogle,
//                             style: OutlinedButton.styleFrom(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             child: const Text(
//                               "Sign in with Google",
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           ),
//                   ),

//                   const SizedBox(height: 20),

//                   // SIGN IN LINK
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text("Already have an account ? "),
//                       GestureDetector(
//                         onTap: () {
//                           Get.to(() => const LoginPage());
//                         },
//                         child: const Text(
//                           "Sign In",
//                           style: TextStyle(
//                             color: Color(0xff4CAF50),
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 30),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:office_project/auth.dart';
import 'package:office_project/screens/termsandcond.dart';
import 'package:office_project/screens/userhomepage.dart';
import 'loginpage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phonenumberController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthService authService = AuthService();

  bool loading = false;
  bool isAccepted = false;

  bool textVisible = true;

  // ================= GOOGLE EMAIL PICKER =================
  Future<void> pickGoogleEmail() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) return;

      // Fill selected email
      emailController.text = googleUser.email;

      // Sign out immediately (we only need email)
      await googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // ================= EMAIL SIGN UP =================
  Future<void> signUp() async {
    if (!isAccepted) {
      Get.snackbar("Error", "Please accept Terms & Conditions");
      return;
    }

    setState(() => loading = true);

    try {
      await authService.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        role: 'user',
        name: nameController.text.trim(),
        phonenumber: phonenumberController.text.trim(),
      );

      Get.snackbar('Success', 'Account created');
      Get.offAll(() => const HomePage(role: 'user'));
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      setState(() => loading = false);
    }
  }

  // ================= TEXT FIELD =================
  Widget buildTextField(
    String hint,
    TextEditingController controller, {
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey.shade200,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // ================= EMAIL FIELD WITH GOOGLE PICKER =================
  Widget buildEmailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: emailController,
        readOnly: true, // Prevent manual typing
        onTap: pickGoogleEmail,
        decoration: InputDecoration(
          hintText: "Choose Email (Google)",
          filled: true,
          fillColor: Colors.grey.shade200,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide.none,
          ),
          suffixIcon: const Icon(Icons.email),
        ),
      ),
    );
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFA7C9AD),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.001),
              child: Image(
                // height: height * 0.4,
                // width: width * 0.5,
                image: AssetImage("assets/aashai.png"),
              ),
            ),

            const Text(
              "Welcome",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),

            SizedBox(height: height * 0.01),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: const Text(
                "Manage your products, orders,\nand store – all in one place.",
                textAlign: TextAlign.center,
              ),
            ),
            // HEADER
            // Container(
            //   height: 320,
            //   width: double.infinity,
            //   padding: const EdgeInsets.only(top: 80, bottom: 60),
            //   decoration: const BoxDecoration(
            //     color: Color(0xff4CAF50),
            //     borderRadius: BorderRadius.only(
            //       bottomLeft: Radius.circular(120),
            //       bottomRight: Radius.circular(120),
            //     ),
            //   ),
            //   child: Column(
            //     children: const [
            //       Icon(Icons.eco, color: Colors.white, size: 60),
            //       SizedBox(height: 10),
            //       Text(
            //         "Quickmart",
            //         style: TextStyle(
            //           fontSize: 32,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.white,
            //         ),
            //       ),
            //       SizedBox(height: 10),
            //       Text(
            //         "Join us today and start\nmanaging your grocery store smarter.",
            //         textAlign: TextAlign.center,
            //         style: TextStyle(color: Colors.white70),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  buildTextField("Enter your full name", nameController),
                  buildTextField(
                    "Enter your phone number",
                    phonenumberController,
                  ),

                  // Updated Email Field
                  buildEmailField(),

                  TextField(
                    controller: passwordController,
                    obscureText: textVisible,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            textVisible = !textVisible;
                          });
                        },
                        icon: Icon(
                          textVisible ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                      hintText: "Enter Password",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: width * 0.05,
                        vertical: height * 0.02,
                      ),
                    ),
                  ),

                  // TERMS
                  CheckboxListTile(
                    value: isAccepted,
                    onChanged: (value) {
                      setState(() => isAccepted = value!);
                    },
                    title: RichText(
                      text: TextSpan(
                        text: "I agree to ",
                        style: const TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: "Terms & Conditions",
                            style: const TextStyle(
                              color: Colors.green,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const TermsAndConditionsPage(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),

                  const SizedBox(height: 20),

                  // REGISTER BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: loading
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff4CAF50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: signUp,
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),

                  const SizedBox(height: 20),

                  // SIGN IN LINK
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account ? ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const LoginPage());
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            color: Color(0xff4CAF50),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
