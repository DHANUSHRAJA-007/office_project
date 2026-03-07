import 'package:flutter/material.dart';
import 'package:office_project/widgets/vieworder_card.dart';

class PendingOrders extends StatelessWidget {
  const PendingOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          VieworderCard(),
            VieworderCard(),
              VieworderCard(),
                VieworderCard(),
        ],
      )
    );
  }
}