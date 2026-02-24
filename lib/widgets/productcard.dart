import 'package:flutter/material.dart';
import 'package:office_project/widgets/productitemcard.dart';
class Productcard extends StatelessWidget {
  const Productcard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child:  Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 6),
              color: Colors.grey[300],
              child: const Text(
                "Product for delivery",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Productitemcard(),
            const Divider(),
            Productitemcard()
          ],
        ),
      
    );
  }
}