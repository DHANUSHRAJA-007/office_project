import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final List<String> days = ["Today", "yesterday", "Tomorrow"];
  final ExpansionTileController _controller = ExpansionTileController();
  String? selectedDay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        title: const Text(
          "Orders",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "320",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
              Text(selectedDay??"", style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 30),
          Container(
            width: 450,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey, // Border color
                width: 1.5, // Border thickness
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ExpansionTile(
                controller: _controller,
                title: Text(selectedDay ?? "Select day"),
                children: days.map((item) {
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      setState(() {
                        selectedDay = item;
                      });
                      _controller.collapse();
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 250,
            width: 450,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Order Status",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _statusBox(
                        Icons.schedule,
                        "Pending",
                        "45",
                        Colors.lightGreen,
                        const Color.fromARGB(255, 26, 56, 27),
                      ),

                      _statusBox(
                        Icons.check_circle,
                        "Processed",
                        "45",
                        const Color.fromARGB(255, 203, 173, 255),
                        const Color.fromARGB(255, 26, 56, 27),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _statusBox(
                        Icons.local_shipping,
                        "Shipped",
                        "45",
                        Colors.greenAccent,
                        const Color.fromARGB(255, 26, 56, 27),
                      ),
                      _statusBox(
                        Icons.close,
                        "Cancelled",
                        "13",
                        const Color.fromARGB(255, 255, 134, 134),
                        const Color.fromARGB(255, 141, 40, 33),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusBox(IconData icon, String text, text1, Color color, color2) {
    return Container(
      height: 80,
      width: 180,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon),
              Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Text(
            text1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: color2,
            ),
          ),
        ],
      ),
    );
  }
}
