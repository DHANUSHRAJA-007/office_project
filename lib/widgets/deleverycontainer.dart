import 'package:flutter/material.dart';

class Deleverycontainer extends StatelessWidget {
  const Deleverycontainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 5,
            children: [
              SizedBox(width: 60, child: CircleAvatar()),
              SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "name",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("2 delivery today"),
                    ],
                  ),
                ),
              ),

              SizedBox(
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        padding: const EdgeInsets.all(4),
                        child: const Text(
                          "Assign",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
