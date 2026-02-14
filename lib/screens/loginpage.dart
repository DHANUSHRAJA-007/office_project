import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_project/auth.dart';
import 'package:office_project/screens/adminmain.dart';

import 'userhomepage.dart';
import 'signuppage.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final AuthService authService = AuthService();

//   bool loading = false;
//   bool textVisible = true;

//   Future<void> login() async {
//     setState(() => loading = true);

//     try {
//       final role = await authService.signIn(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );

//       print('ROLE = $role');

//       if (role == 'admin') {
//         Get.offAll(() => const Adminmain());
//       } else {
//         Get.offAll(() => const HomePage(role: 'user'));
//       }
//     } catch (e) {
//       Get.snackbar('Login Failed', e.toString());
//     } finally {
//       setState(() => loading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: passwordController,
//               obscureText: textVisible,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 suffixIcon: IconButton(
//                   onPressed: () {
//                     setState(() {
//                       textVisible = !textVisible;
//                     });
//                   },
//                   icon: Icon(
//                     textVisible ? Icons.visibility_off : Icons.visibility,
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 24),
//             loading
//                 ? const CircularProgressIndicator()
//                 : ElevatedButton(onPressed: login, child: const Text('Login')),
//             TextButton(
//               onPressed: () {
//                 Get.offAll(() => const SignupPage());
//               },
//               child: const Text('Create account'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService authService = AuthService();

  bool loading = false;
  bool textVisible = true;

  Future<void> login() async {
    setState(() => loading = true);

    try {
      final role = await authService.signIn(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      print('ROLE = $role');

      if (role == 'admin') {
        Get.offAll(() => const Adminmain());
      } else {
        Get.offAll(() => const HomePage(role: 'user'));
      }
    } catch (e) {
      Get.snackbar('Login Failed', e.toString());
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Column(
          children: [
            // ---------- Top Green Section ----------
            Stack(
              children: [
                Container(
                  height: 320,
                  decoration: const BoxDecoration(
                    color: Color(0xff4CAF50),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(120),
                      bottomRight: Radius.circular(120),
                    ),
                  ),
                ),

                SizedBox(
                  height: 320,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.eco, color: Colors.white, size: 60),

                      SizedBox(height: 10),

                      Text(
                        "Quickmart",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: 30),

                      Text(
                        "Welcome back",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: 10),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          "Manage your products, orders,\nand store – all in one place.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // ---------- Login Section ----------
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    const SizedBox(height: 25),

                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Email Field
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Enter your Email",
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Password Field
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
                            textVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                        hintText: "Enter Password",
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Forgot Password
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Forget password ?",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff4CAF50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          login();

                          // TextButton(
                          //   onPressed: () {
                          //     Get.offAll(() => const SignupPage());
                          //   },
                          //   child: const Text('Create account'),
                          // );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Sign Up Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don’t have an account ? "),
                        TextButton(
                          onPressed: () {
                            Get.to(const SignupPage());
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Color(0xff4CAF50),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
