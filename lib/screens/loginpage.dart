import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_project/auth.dart';
import 'admindashboard.dart';
import 'userhomepage.dart';
import 'signuppage.dart';

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

  Future<void> login() async {
    setState(() => loading = true);

    try {
      final role = await authService.signIn(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      print('ROLE = $role');

      if (role == 'admin') {
        Get.offAll(() => const AdminDashboard());
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
      appBar: AppBar(title: const Text('Login')),
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
                    onPressed: login,
                    child: const Text('Login'),
                  ),
            TextButton(
              onPressed: () {
                Get.offAll(() => const SignupPage());
              },
              child: const Text('Create account'),
            ),
          ],
        ),
      ),
    );
  }
}
