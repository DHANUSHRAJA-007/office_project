import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';

class DeliverymanDetails extends StatelessWidget {
  const DeliverymanDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          "Delivery Man Details",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    BootstrapIcons.pencil_square,
                    color: Colors.green,
                    size: 22,
                  ),
                ),
              ],
            ),
            CircleAvatar(radius: 50),
            SizedBox(height: 7),
            Text(
              'Name',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 7),
            Text(
              'Register ID : 20505lbf215',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: 20),
            Card(
              // shape: BeveledRectangleBorder(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10,
                ),
                child: Column(
                  spacing: 5,
                  children: [
                    SizedBox(
                      height: 30,
                      width: 450,
                      // color: const Color.fromARGB(255, 185, 231, 208),
                      child: Text(
                        "Delivery Man INformation",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _infoCard(Icons.call, "+12235 552258 225 "),
                    _infoCard(Icons.mail, "example.gmail.com"),
                    _infoCard(Icons.location_on, "22, erode - 251452"),
                    Divider(),
                    Row(
                      children: [
                        Icon(Icons.verified_rounded, color: Colors.green),
                        SizedBox(width: 10),
                        Text(
                          "Previous Delivery Count",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(width: 150),
                        Text("1250 Orders", style: TextStyle(fontSize: 15)),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.verified_rounded, color: Colors.green),
                        SizedBox(width: 10),
                        Text(
                          "9 years of experience",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String data) {
    return Row(
      children: [
        Icon(icon, color: Colors.green),
        SizedBox(width: 10),
        Text(data, textAlign: TextAlign.center, style: TextStyle(fontSize: 15)),
      ],
    );
  }
}
