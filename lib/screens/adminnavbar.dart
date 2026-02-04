import 'package:flutter/material.dart';

class Adminnavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int)ontap;
  const Adminnavbar({super.key, required this.currentIndex, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
    
      selectedItemColor: Colors.black,
      selectedLabelStyle: TextStyle(color: Colors.black),
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: ontap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: "Dashboard",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag),
          label: "Products",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long),
          label: "Orders",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
    );
  }
}
