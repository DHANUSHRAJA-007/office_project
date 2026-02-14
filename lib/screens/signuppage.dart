// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
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
//   bool isAccepted = false;
//   void signUpUser() {
//     // Your signup logic here
//     print("Signup Successful");
//   }

//   Future<void> signUp() async {
//     setState(() => loading = true);

//     try {
//       await authService.signUp(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),

//         role: 'user', // 👈 default user
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

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Sign Up')),
//       body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(labelText: 'name'),
//             ),
//             TextField(
//               controller: phonenumberController,
//               decoration: const InputDecoration(labelText: 'phone number'),
//             ),
//             TextField(
//               controller: emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: passwordController,
//               obscureText: true,
//               decoration: const InputDecoration(labelText: 'Password'),
//             ),
//             const SizedBox(height: 10),
//             SizedBox(
//               height: 50,

//               child: CheckboxListTile(
//                 value: isAccepted,
//                 onChanged: (value) {
//                   setState(() {
//                     isAccepted = value!;
//                   });
//                 },
//                 title: RichText(
//                   text: TextSpan(
//                     text: "I agree to",
//                     style: TextStyle(color: Colors.black),
//                     children: [
//                       TextSpan(
//                         text: "Terms & Conditions",
//                         style: TextStyle(
//                           color: Colors.blue,
//                           decoration: TextDecoration.underline,
//                         ),

//                         recognizer: TapGestureRecognizer()
//                           ..onTap = () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => const TermsAndConditionsPage(),
//                               ),
//                             );
//                           },
//                       ),
//                     ],
//                   ),
//                 ),

//                 controlAffinity: ListTileControlAffinity.leading,
//               ),
//             ),
//             const SizedBox(height: 24),
//             loading
//                 ? const CircularProgressIndicator()
//                 : ElevatedButton(
//                     onPressed: isAccepted
//                         ? () {
//                             signUp();
//                           }
//                         : null,
//                     child: const Text('Create Account'),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_project/auth.dart';
import 'package:office_project/screens/termsandcond.dart';
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

  Future<void> signUp() async {
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
      Get.offAll(() => const LoginPage());

    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      setState(() => loading = false);
    }
  }

  Widget buildTextField(String hint, TextEditingController controller,
      {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey.shade200,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Column(
          children: [

            /// ----------- TOP GREEN HEADER -----------
            Container(
              height: 320,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 80, bottom: 60),
              decoration: const BoxDecoration(
                color: Color(0xff4CAF50),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(120),
                  bottomRight: Radius.circular(120),
                ),
              ),
              child: Column(
                children: const [

                  Icon(Icons.eco, color: Colors.white, size: 60),

                  SizedBox(height: 10),

                  Text(
                    "Quickmart",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Join us today and start\nmanaging your grocery store smarter.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// ----------- SIGNUP FORM -----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [

                  const Text(
                    "Sign Up",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  buildTextField("Enter your full name", nameController),

                  buildTextField(
                      "Enter your phone number", phonenumberController),

                  buildTextField("Enter your Email", emailController),

                  buildTextField("Enter Password", passwordController,
                      obscure: true),

                  /// -------- TERMS & CONDITIONS ----------
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
                              color: Color(0xff4CAF50),
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

                  /// -------- REGISTER BUTTON ----------
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
                            onPressed: isAccepted ? signUp : null,
                            child: const Text(
                              "Register",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                  ),

                  const SizedBox(height: 20),

                  /// -------- SIGN IN ----------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account ? "),
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
                      )
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
