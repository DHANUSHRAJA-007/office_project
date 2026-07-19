import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_project/auth.dart';
import 'package:office_project/screens/adminmain.dart';
import 'userhomepage.dart';
import 'signuppage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

int currentIndex = 0;

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
        Get.offAll(() => HomePage(role: role), arguments: 0);
      }
    } catch (e) {
      Get.snackbar('Login Failed', e.toString());
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFA7C9AD),
      body: SafeArea(
        child: SingleChildScrollView(
          // 🔥 IMPORTANT (no overflow)
          child: Column(
            children: [
              Image(
                height: height * 0.4,
                // width: width * 0.5,
                image: AssetImage("assets/aashai.png"),
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

              /// ---------- LOGIN SECTION ----------
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                child: Column(
                  children: [
                    SizedBox(height: height * 0.03),

                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: height * 0.03),

                    /// EMAIL
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
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: width * 0.05,
                          vertical: height * 0.02,
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.02),

                    /// PASSWORD
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
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: width * 0.05,
                          vertical: height * 0.02,
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.03),

                    /// LOGIN BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.07,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff4CAF50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: login,
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.02),

                    /// SIGNUP
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don’t have an account ? ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
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

                    SizedBox(height: height * 0.03),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
