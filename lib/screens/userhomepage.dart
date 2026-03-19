// import 'package:flutter/material.dart';
// import 'package:office_project/screens/cartpage.dart';
// import 'package:office_project/screens/searchpage.dart';
// import 'package:office_project/screens/user_homescreen.dart';
// import 'package:office_project/screens/userprofile.dart';

// class HomePage extends StatefulWidget {
//   final String role;

//   const HomePage({super.key, required this.role});

//   static final GlobalKey<_HomePageState> homeKey = GlobalKey<_HomePageState>();

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;

//   void changeTab(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   final List<Widget> _pages = [
//     UserHomescreen(),
//     Searchpage(),
//     Cartpage(),
//     Userprofile(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: HomePage.homeKey,
//       body: IndexedStack(index: _currentIndex, children: _pages),

//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: const Color(0xff4CAF50),
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.white,
//         type: BottomNavigationBarType.fixed,

//         currentIndex: _currentIndex,

//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },

//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(
//               _currentIndex == 0 ? Icons.home_filled : Icons.home_outlined,
//             ),
//             label: "Home",
//           ),

//           BottomNavigationBarItem(
//             icon: Icon(
//               _currentIndex == 1 ? Icons.search : Icons.search_outlined,
//             ),
//             label: "Search",
//           ),

//           BottomNavigationBarItem(
//             icon: Icon(
//               _currentIndex == 2
//                   ? Icons.shopping_cart
//                   : Icons.shopping_cart_outlined,
//             ),
//             label: "Cart",
//           ),

//           BottomNavigationBarItem(
//             icon: Icon(
//               _currentIndex == 3 ? Icons.person : Icons.person_outline,
//             ),
//             label: "Profile",
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart'; // ✅ IMPORTANT
import 'package:office_project/screens/cartpage.dart';
import 'package:office_project/screens/searchpage.dart';
import 'package:office_project/screens/user_homescreen.dart';
import 'package:office_project/screens/userprofile.dart';

class HomePage extends StatefulWidget {
  final String role;

  const HomePage({super.key, required this.role});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;

  /// ✅ RECEIVE INDEX FROM NAVIGATION
  @override
  void initState() {
    super.initState();

    if (Get.arguments != null) {
      _currentIndex = Get.arguments;
    }
  }

  /// OPTIONAL (manual tab change if needed)
  void changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  /// PAGES
  final List<Widget> _pages = [
    const UserHomescreen(),
  
    const Cartpage(),
    const Userprofile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /// BODY
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),

      /// BOTTOM NAVIGATION
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

          // BottomNavigationBarItem(
          //   icon: Icon(
          //     _currentIndex == 1
          //         ? Icons.search
          //         : Icons.search_outlined,
          //   ),
          //   label: "Search",
          // ),

          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 1
                  ? Icons.shopping_cart
                  : Icons.shopping_cart_outlined,
            ),
            label: "Cart",
          ),

          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 2
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