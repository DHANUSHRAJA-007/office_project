import 'package:flutter/material.dart';
import 'package:office_project/widgets/vieworder_card.dart';

class Allorders extends StatelessWidget {
  const Allorders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          VieworderCard(),
          VieworderCard(),
          VieworderCard(),
          VieworderCard(),
          VieworderCard(),
          VieworderCard(),
          VieworderCard(),
          VieworderCard(),
        ],
      ),
    );
  }
}
