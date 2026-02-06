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
  void signUpUser() {
    // Your signup logic here
    print("Signup Successful");
  }

  Future<void> signUp() async {
    setState(() => loading = true);

    try {
      await authService.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),

        role: 'user', // 👈 default user
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'name'),
            ),
            TextField(
              controller: phonenumberController,
              decoration: const InputDecoration(labelText: 'phone number'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,

              child: CheckboxListTile(
                value: isAccepted,
                onChanged: (value) {
                  setState(() {
                    isAccepted = value!;
                  });
                },
                title: RichText(
                  text: TextSpan(
                    text: "I agree to",
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "Terms & Conditions",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),

                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const TermsAndConditionsPage(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),

                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            const SizedBox(height: 24),
            loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: isAccepted
                        ? () {
                            signUp();
                          }
                        : null,
                    child: const Text('Create Account'),
                  ),
          ],
        ),
      ),
    );
  }
}
