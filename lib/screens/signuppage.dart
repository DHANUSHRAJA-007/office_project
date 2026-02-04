import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_project/auth.dart';
import 'loginpage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService authService = AuthService();

  bool loading = false;

  Future<void> signUp() async {
    setState(() => loading = true);

    try {
      await authService.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        role: 'user', // 👈 default user
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
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 24),
            loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: signUp,
                    child: const Text('Create Account'),
                  ),
          ],
        ),
      ),
    );
  }
}
