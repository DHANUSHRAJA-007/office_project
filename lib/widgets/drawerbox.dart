import 'package:flutter/material.dart';

class Drawerbox extends StatelessWidget {
  const Drawerbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xff4CAF50),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView(
          children: [
              SizedBox(height: 20),
            Row(
              spacing: 8,
              children: [
                Icon(Icons.sort, color: Colors.white, size: 25),
                Text(
                  "Quickmart",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            _tile("My Account ", Icons.person),
            _tile("Coupon", Icons.confirmation_number),
            _tile("Chats", Icons.message),
            _tile("Promo", Icons.local_offer),
            _tile("Report", Icons.insert_chart_outlined),
            _tile("Settings", Icons.settings),
            _tile("FAQ", Icons.quiz),
          ],
        ),
      ),
    );
  }

  Widget _tile(String name, IconData icon) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Row(
            spacing: 8,
            children: [
              Icon(icon, color: Colors.white, size: 25),
              Text(
                name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Divider(color: Colors.white),
      ],
    );
  }
}
