import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [

            // -------- INTRO --------
            Text(
              "Privacy Policy",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your information when you use our grocery application.",
            ),

            SizedBox(height: 20),

            // -------- DATA COLLECTION --------
            Text(
              "1. Information We Collect",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "• Personal information such as name, email, and phone number.\n"
              "• Delivery address for order processing.\n"
              "• Payment information for transactions.\n"
              "• App usage data to improve our services.",
            ),

            SizedBox(height: 20),

            // -------- DATA USAGE --------
            Text(
              "2. How We Use Your Information",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "• To process and deliver your orders.\n"
              "• To improve user experience.\n"
              "• To send order updates and notifications.\n"
              "• To provide customer support.",
            ),

            SizedBox(height: 20),

            // -------- DATA SECURITY --------
            Text(
              "3. Data Security",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "We take appropriate security measures to protect your personal data from unauthorized access or disclosure.",
            ),

            SizedBox(height: 20),

            // -------- SHARING --------
            Text(
              "4. Information Sharing",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "We do not sell or rent your personal information. We may share data with delivery partners and payment services only for order processing.",
            ),

            SizedBox(height: 20),

            // -------- COOKIES --------
            Text(
              "5. Cookies & Tracking",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "Our app may use cookies or analytics tools to improve performance and user experience.",
            ),

            SizedBox(height: 20),

            // -------- USER RIGHTS --------
            Text(
              "6. Your Rights",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "You can request access, correction, or deletion of your personal data by contacting us.",
            ),

            SizedBox(height: 20),

            // -------- CONTACT --------
            Text(
              "7. Contact Us",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              "If you have any questions regarding this Privacy Policy, please contact our support team.",
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
