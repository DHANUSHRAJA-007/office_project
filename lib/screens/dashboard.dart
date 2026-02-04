import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _dashCards(
                const Color.fromARGB(255, 255, 206, 59),
                Color(0xFFF5B700),
                "Total Users",
                Icons.currency_rupee,
              ),
              _dashCards(
                Colors.cyan,
                Color(0xFF00B4D8),
                "Total orders",
                Icons.receipt_long,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _dashCards(
                Colors.blue,
                Color(0xFF3A86FF),
                "Total Users",
                Icons.people,
              ),
              _dashCards(
                const Color.fromARGB(255, 122, 32, 138),
                Color.fromARGB(255, 155, 56, 236),
                "Total Products",
                Icons.store,
              ),
            ],
          ),
          SizedBox(height: 50),
          Container(
            // height: 80,
            color: Colors.green,
            child: Text("Recent Orders"),
          ),
        ],
      ),
    );
  }

  Widget _dashCards(Color color1, color2, String title, IconData icon) {
    return SizedBox(
      height: 150,
      width: 200,
      child: Card(
        color: color1,
        //  const Color.fromARGB(255, 255, 206, 59),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: color2,
                // Color(0xFFF5B700),
                shape: BoxShape.circle,
              ),
              child: Center(child: Icon(icon)),
            ),
            Column(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title),
                Text(
                  "5,000",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                // Container(
                //   alignment: Alignment.center,
                //   height: 20,
                //   width: 60,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(20)),
                //     color: Color(0xFFF5B700),
                //   ),
                //   child: Text("+62%"),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
