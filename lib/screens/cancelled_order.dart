import 'package:flutter/material.dart';
import 'package:office_project/widgets/vieworder_card.dart';

class CancelledOrder extends StatelessWidget {
  const CancelledOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          VieworderCard()
        ],
      )
    );
  }
}