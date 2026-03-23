import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_project/screens/aboutuspage.dart';
import 'package:office_project/screens/dashboard.dart';
import 'package:office_project/screens/orders.dart';
import 'package:office_project/screens/profilepage.dart';
import 'package:office_project/screens/reports.dart';
import 'package:office_project/screens/admin_settings.dart';

class Drawerbox extends StatelessWidget {

  const Drawerbox({super.key,});

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
            // _tile(context, "Dashboard", Icons.dashboard, '/dashboard'),
            _tile(context, "My Account", Icons.people, '/my account'),
            // _tile(context, "Orders", Icons.shopping_bag, '/orders'),
            _tile(context, "Coupon", Icons.add_box_outlined, '/coupon'),
            _tile(context, "Reports", Icons.bar_chart, '/reports'),

            _tile(context, "About Us", Icons.info, '/about'),

            _tile(context, "chat", Icons.chat, '/chat'),
            _tile(context, "Promo", Icons.rocket, '/promo'),

            // _tile(context, "Settings", Icons.settings, '/settings'),
            _tile(context, "FAQ", Icons.textsms_outlined, '/faq'),
          ],
        ),
      ),
    );
  }

  Widget _tile(
    BuildContext context,
    String title,
    IconData icon,
    String route,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {
        Get.back(); // close drawer

        if (route == '/dashboard') {
          // Get.to(const Dashboard(onNavigateToOrders: () {  },));
        } else if (route == '/settings') {
          Get.to( Settings2());
        } else if (route == '/orders') {
          Get.to(Orders());
        } else if (route == '/my account') {
          Get.to(ProfilePage());
        } else if (route == '/reports') {
          Get.to(Reports());
        } else if (route == '/about') {
          Get.to(AboutUsPage());
        }
      },
    );
  }
}
