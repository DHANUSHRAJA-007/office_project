import 'package:flutter/material.dart';
import 'package:office_project/screens/adminnavbar.dart';
import 'package:office_project/screens/dashboard.dart';
import 'package:office_project/screens/order.dart';
import 'package:office_project/screens/product.dart';
import 'package:office_project/screens/settings.dart';

class Adminmain extends StatefulWidget {
  const Adminmain({super.key});

  @override
  State<Adminmain> createState() => _AdminmainState();
}

class _AdminmainState extends State<Adminmain> {
  int currentIndex = 0;
  final List<Widget> pages = [Dashboard(), Product(), Order(), Settings()];
  @override
  Widget build(BuildContext context) {
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
