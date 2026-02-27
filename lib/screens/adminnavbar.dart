import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Adminnavbar extends StatefulWidget {
  final int currentIndex;
  final Function(int) ontap;

  const Adminnavbar({
    super.key,
    required this.currentIndex,
    required this.ontap,
  });
  @override
  State<Adminnavbar> createState() => _AdminnavbarState();
}

class _AdminnavbarState extends State<Adminnavbar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color(0xff4CAF50),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.currentIndex,
      onTap: widget.ontap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            widget.currentIndex == 0 ? Icons.home_filled : Icons.home_outlined,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            widget.currentIndex == 1
                ? Icons.description
                : Icons.description_outlined,
          ),
          label: "Products",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            widget.currentIndex == 2
                ? Icons.shopping_cart
                : Icons.shopping_cart_outlined,
          ),
          label: "Orders",
        ),

        BottomNavigationBarItem(
          icon: Icon(
            widget.currentIndex == 3 ? Icons.settings : Icons.settings_outlined,
          ),
          label: "Settings",
        ),
      ],
    );
  }
}
