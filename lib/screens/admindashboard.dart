import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Panel")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(title: Text("📦 Manage Products")),
          ListTile(title: Text("🛒 Orders")),
          ListTile(title: Text("👤 Users")),
          ListTile(title: Text("📊 Analytics")),
        ],
      ),
    );
  }
}
