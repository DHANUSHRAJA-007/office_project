import 'package:flutter/material.dart';
class Buyerinstructioncard extends StatelessWidget {
  const Buyerinstructioncard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 6),
              color: Colors.grey[300],
              child: const Text(
                "Special Instructions",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            const Text("Please deliver between 5-6 PM."),
            const Text(
                "Leave the package at the front door if no one is home."),
            const Divider(),
            const SizedBox(height: 6),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Amount",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("\$100.00",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      
    );
  }
}