import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ---------- SHOP NAME ----------
            const Center(
              child: Text(
                "Fresh Mart Grocery",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ---------- ABOUT ----------
            const Text(
              "Who We Are",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              "Fresh Mart Grocery is your trusted online grocery partner. "
              "We provide fresh vegetables, fruits, daily essentials, and household products "
              "directly to your doorstep with quality assurance and affordable pricing.",
            ),

            const SizedBox(height: 20),

            // ---------- MISSION ----------
            const Text(
              "Our Mission",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              "Our mission is to make grocery shopping easy, fast, and reliable. "
              "We focus on delivering fresh and high-quality products while saving "
              "our customers valuable time.",
            ),

            const SizedBox(height: 20),

            // ---------- WHY CHOOSE US ----------
            const Text(
              "Why Choose Us",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text("Fresh and Quality Products"),
            ),

            const ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text("Fast Home Delivery"),
            ),

            const ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text("Affordable Pricing"),
            ),

            const ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text("Easy Online Ordering"),
            ),

            const SizedBox(height: 20),

            // ---------- CONTACT ----------
            const Text(
              "Contact Us",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const ListTile(
              leading: Icon(Icons.location_on),
              title: Text("123 Market Street, Your City"),
            ),

            const ListTile(
              leading: Icon(Icons.phone),
              title: Text("+91 9876543210"),
            ),

            const ListTile(
              leading: Icon(Icons.email),
              title: Text("support@freshmart.com"),
            ),

            const SizedBox(height: 30),

            const Center(
              child: Text(
                "Thank you for choosing Fresh Mart!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
