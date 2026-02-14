import 'package:flutter/material.dart';

class Reports extends StatelessWidget {
  const Reports({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          "Reports",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Center(
            child: SizedBox(
              width: 450,
              child: Card(
                elevation: 2,
                child: Column(
                  children: [
                    _reportItems(
                      "Sales Report",
                      Icons.bar_chart_rounded,
                      Icons.arrow_forward_ios,
                    ),
                    Divider(),
                    _reportItems(
                      "Inventory Report",
                      Icons.bar_chart,
                      Icons.arrow_forward_ios,
                    ),
                    Divider(),
                    _reportItems(
                      "Customer Report",
                      Icons.people,
                      Icons.arrow_forward_ios,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _reportItems(String name, IconData icon, icon2) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      trailing: IconButton(onPressed: () {}, icon: Icon(icon2)),
    );
  }
}
