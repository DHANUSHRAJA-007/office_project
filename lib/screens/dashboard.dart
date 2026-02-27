import 'package:flutter/material.dart';
import 'package:office_project/widgets/drawerbox.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:Drawerbox(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xff4CAF50),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: Icon(Icons.sort, color: Colors.white, size: 30),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                  Text(
                    "Quickmart",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 50),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_outlined,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _dashCards(
                  Color(0xFFFBD099),
                  "New Orders",
                  "70",
                  Icons.description_outlined,
                ),
                _dashCards(
                  Color(0xFFA0D29E),

                  "Total Sales",
                  "150",
                  Icons.currency_rupee,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _dashCards(
                  Color(0xFFFCD1D2),
                  "Product Stock",
                  "300",
                  Icons.inventory_2_outlined,
                ),
                _dashCards(
                  Color(0xFFBCBFFB),
                  "Low Stock Alerts",
                  "10",
                  Icons.move_to_inbox_outlined,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Recent Orders",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(width: 130),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "View All",
                    style: TextStyle(color: Colors.green, fontSize: 15),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                _recents("sara", "#12345", "delivered"),
                Divider(),
                _recents("sara", "#12345", "delivered"),
                Divider(),
                _recents("sara", "#12345", "delivered"),
                Divider(),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Product Categories",
                  style: TextStyle(
                    
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(width: 130),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "View All",
                    style: TextStyle(color: Colors.green, fontSize: 15),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _categoryBox("vegetables", "assets/v1.jpg"),
                _categoryBox("vegetables", "assets/v1.jpg"),
                _categoryBox("vegetables", "assets/v1.jpg"),
                _categoryBox("vegetables", "assets/v1.jpg"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _categoryBox("vegetables", "assets/v1.jpg"),
                _categoryBox("vegetables", "assets/v1.jpg"),
                _categoryBox("vegetables", "assets/v1.jpg"),
                _categoryBox("vegetables", "assets/v1.jpg"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _dashCards(Color color1, String title, title2, IconData icon) {
    return Container(
      height: 110,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: color1,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.white, fontSize: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title2,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 50),
                Icon(icon, color: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _recents(String name, id, status) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: 470,
        // color: Colors.yellow,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            CircleAvatar(radius: 25),
            SizedBox(
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "Order id : $id",
                    style: TextStyle( fontSize: 18),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 20,
              width: 70,
              color: Color(0xff4CAF50),
              child: Text(status, style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryBox(String name, image) {
    return Column(
      children: [
        Container(
          height: 80,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(),
            image: DecorationImage(image: AssetImage(image), scale: 5),
          ),
        ),
        Text(name),
      ],
    );
  }
}
