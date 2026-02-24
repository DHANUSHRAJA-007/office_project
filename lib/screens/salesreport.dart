import 'package:flutter/material.dart';

class Salesreport extends StatefulWidget {
  const Salesreport({super.key});

  @override
  State<Salesreport> createState() => _SalesreportState();
}

class _SalesreportState extends State<Salesreport> {
  List<String> categories = ["Today", "Yesterday", "Tomorrow"];

  String selectedCategory = "Today"; // default selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Sales Report",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          /// 💰 Amount Section
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("₹",
                  style: TextStyle(
                      fontSize: 35, fontWeight: FontWeight.bold)),
              const SizedBox(width: 5),
              const Text("12,4414",
                  style: TextStyle(
                      fontSize: 35, fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Text(
                selectedCategory,
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),

          const SizedBox(height: 20),

          /// 📂 Expansion Tile
          Container(
            width: 350,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ExpansionTile(
              title: Text(selectedCategory), // 👈 shows selected item
              children: categories.map((item) {
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    setState(() {
                      selectedCategory = item; // just update value
                    });
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}