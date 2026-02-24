import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';

class Sellerdetails extends StatelessWidget {
  const Sellerdetails({super.key});

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
          "Seller Details",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Image(
                  image: AssetImage("assets/logo2.jpg"),
                  height: 120,
                  width: 120,
                ),
                SizedBox(width: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 130,
                      children: [
                        Text(
                          "Store Founder Profile",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
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
                    detailbox("Name", "Rahul"),
                    detailbox("Founded on", "1 jun 2015"),
                    detailbox("Mobile Number", "+91 32584 52552"),
                    detailbox("Email", "Rahul123@gmail.com"),
                  ],
                ),
              ],
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.left,
                "Account Settings",
                style: TextStyle(
                  color: const Color.fromARGB(156, 66, 66, 66),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Grocery Hub",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                    ),
                    _infoCard(Icons.call, "+12235 552258 225 "),
                    _infoCard(Icons.mail, "example.gmail.com"),
                    _infoCard(Icons.location_on, "22, erode - 251452"),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Icon(Icons.favorite_outline, size: 12),
                        SizedBox(width: 10),
                        Text(
                          "1k People Likes | 2400 Reviews",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          "6.00 AM - 9.00 PM (Monday - Sunday)",
                          style: TextStyle(fontSize: 12, color: Colors.green),
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

  Widget detailbox(String name, detail) {
    return Wrap(
      spacing: 5,
      children: [
        SizedBox(
          width: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(name), Text(":")],
          ),
        ),
        Text(detail),
      ],
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
