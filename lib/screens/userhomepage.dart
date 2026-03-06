import 'package:flutter/material.dart';
import 'package:office_project/screens/cartpage.dart';
import 'package:office_project/screens/admin_settings.dart';
import 'package:office_project/screens/searchpage.dart';
import 'package:office_project/screens/user_homescreen.dart';

class HomePage extends StatefulWidget {
  final String role;

  const HomePage({super.key, required this.role});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;

  final List<Widget> _pages = [
    UserHomescreen(),
    Searchpage(),
    Cartpage(),
    Settings2(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff4CAF50),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,

        currentIndex: _currentIndex,

        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        items: [
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 0
                  ? Icons.home_filled
                  : Icons.home_outlined,
            ),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 1
                  ? Icons.search
                  : Icons.search_outlined,
            ),
            label: "Search",
          ),

          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 2
                  ? Icons.shopping_cart
                  : Icons.shopping_cart_outlined,
            ),
            label: "Cart",
          ),

          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 3
                  ? Icons.person
                  : Icons.person_outline,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}