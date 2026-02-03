import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_project/screens/loginpage.dart';
import 'package:office_project/screens/verificationpage.dart';

class Cretepass extends StatefulWidget {
  const Cretepass({super.key});
  @override
  State<Cretepass> createState() => _CreatepassState();

  static Widget _inputField(String hint, {bool obscure = true}) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }

  // Social Button Widget
  static Widget _socialButton(IconData icon) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Icon(icon, size: 28),
    );
  }
}

class _CreatepassState extends State<Cretepass> {
  bool textVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              IconButton(
                onPressed: () {
                  Get.to(VerificationPage());
                },
                icon: const Icon(Icons.arrow_back),
              ),

              const SizedBox(height: 40),

              // Title
              const Text(
                "Create New Password?",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 40),

              const SizedBox(height: 20),

              // Email
              TextField(
                obscureText: textVisible,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        textVisible = !textVisible;
                      });
                    },
                    icon: textVisible
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                  ),

                  hintText: 'Password',
                  label: Text("Password"),
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              TextField(
                obscureText: textVisible,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        textVisible = !textVisible;
                      });
                    },
                    icon: textVisible
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                  ),

                  hintText: 'Confirm New Password',
                  label: Text("Confirm New Password"),
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              // Password
              const SizedBox(height: 40),

              // Sign Up Button
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2C1B18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      " Confirm",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Divider text
            ],
          ),
        ),
      ),
    );
  }
}
