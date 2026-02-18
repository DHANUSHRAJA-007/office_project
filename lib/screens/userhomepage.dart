import 'package:flutter/material.dart';
import 'package:office_project/screens/cartpage.dart';
import 'package:office_project/screens/home.dart';
import 'package:office_project/screens/settingspage.dart';

class HomePage extends StatefulWidget {
  final String role;
 
  

  const HomePage({super.key, required this.role,});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;



  final List<Widget> _pages = <Widget>[Home(), Cartpage(), SettingsPage()];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('e-commerce name'))),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(color: Colors.black),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.trolley), label: "cart"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "settings"),
        ],
      ),
    );
  }
}
