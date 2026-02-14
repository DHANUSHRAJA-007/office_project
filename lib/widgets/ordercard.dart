import 'package:flutter/material.dart';
class ordercard extends StatelessWidget {
  const ordercard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Order ID: 123456",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(radius: 25),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Emily Davis"),
                      Text("+1 234 567 890"),
                      Text("452 Maple Street, Springfield"),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}