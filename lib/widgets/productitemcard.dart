import 'package:flutter/material.dart';
class Productitemcard extends StatelessWidget {
  const Productitemcard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(radius: 22),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Product Name"),
              Text("Grocery Hub"),
              Text("Price: \$50.00/2kg"),
            ],
          ),
        )
      ],
    );
  }
  }
