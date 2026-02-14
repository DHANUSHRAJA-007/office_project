import 'package:flutter/material.dart';
class Buyercard extends StatelessWidget {
  const Buyercard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 6),
              color: Colors.grey[300],
              child: const Text(
                "Buyer Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(radius: 25),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Emily Davis\n452 Maple Street, Springfield\nBangalore",
                  ),
                )
              ],
            )
          ],
        ),
      
    );
  }
}