import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms & Conditions"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [

            // -------- INTRO --------
            Text(
              "Welcome to Our Store",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),

            Text(
              "By accessing or using our app, you agree to be bound by the following Terms and Conditions. Please read them carefully.",
            ),

            SizedBox(height: 20),

            // -------- ACCOUNT --------
            Text(
              "1. User Account",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "You are responsible for maintaining the confidentiality of your account information and password. You agree to accept responsibility for all activities that occur under your account.",
            ),

            SizedBox(height: 20),

            // -------- PRODUCTS --------
            Text(
              "2. Products & Pricing",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "All product prices are subject to change without notice. We reserve the right to modify or discontinue any product at any time.",
            ),

            SizedBox(height: 20),

            // -------- ORDERS --------
            Text(
              "3. Orders & Payments",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "We reserve the right to cancel or refuse any order at our discretion. Payments must be completed before order processing.",
            ),

            SizedBox(height: 20),

            // -------- SHIPPING --------
            Text(
              "4. Shipping & Delivery",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Delivery times are estimates and may vary depending on location and external factors.",
            ),

            SizedBox(height: 20),

            // -------- RETURNS --------
            Text(
              "5. Returns & Refunds",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Products may be returned within the allowed return period. Refunds will be processed after product inspection.",
            ),

            SizedBox(height: 20),

            // -------- PRIVACY --------
            Text(
              "6. Privacy Policy",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Your personal data is handled securely and will not be shared with third parties without consent.",
            ),

            SizedBox(height: 20),

            // -------- LIABILITY --------
            Text(
              "7. Limitation of Liability",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "We are not responsible for any indirect or incidental damages arising from the use of our services.",
            ),

            SizedBox(height: 30),

            Center(
              child: Text(
                "Last Updated: 2026",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
