import 'package:flutter/material.dart';
import 'package:office_project/screens/addproduct.dart';
import 'package:office_project/screens/adminnavbar.dart';
import 'package:office_project/screens/dashboard.dart';
import 'package:office_project/screens/admin_settings.dart';
import 'package:office_project/screens/view_orders.dart';

class Adminmain extends StatefulWidget {
  const Adminmain({super.key});

  @override
  State<Adminmain> createState() => _AdminmainState();
}

class _AdminmainState extends State<Adminmain> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      Dashboard(
        onNavigateToOrders: (status) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ViewOrders(selectedStatus: status,)),
          );
        },
      ),
      Addproduct(),
      ViewOrders(selectedStatus: 'pending'),
      Settings2(),
    ];
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: Adminnavbar(
        currentIndex: currentIndex,
        ontap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
