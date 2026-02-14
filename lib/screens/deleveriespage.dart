import 'package:flutter/material.dart';
import 'package:office_project/widgets/deleverycontainer.dart';
import 'package:office_project/widgets/listcontainer.dart';

class Deleveriespage extends StatelessWidget {
  const Deleveriespage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(onPressed: (){}, 
        icon: Icon(Icons.arrow_back,color: Colors.white,)
        ),
        centerTitle: true,
        title: Text(
            "Deleveries",style: TextStyle(color: Colors.white),)
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Deleverycontainer(),
            Deleverycontainer(),
            Deleverycontainer(),
            Deleverycontainer(),
          ],
        ),
      ),
    );
  }
}
