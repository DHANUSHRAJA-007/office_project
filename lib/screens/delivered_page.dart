import 'package:flutter/material.dart';
import 'package:office_project/widgets/vieworder_card.dart';

class DeliveredPage extends StatelessWidget {
  const DeliveredPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView(
        children: [
          VieworderCard(),
            VieworderCard(),
            
        ],
      )
    );
  }
}