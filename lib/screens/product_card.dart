import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 25,
                        width: 75,
                        decoration: BoxDecoration(   color: Colors.orange,borderRadius: BorderRadius.all(Radius.circular(5))),
                     
                        child: Center(
                          child: Text(
                            "Offer 3%",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
                    ],
                  ),
                ),
                Image(image: AssetImage('assets/fruits.png'), height: 120),
                Divider(
                  thickness: 1.5,
                  color: const Color.fromARGB(255, 72, 72, 73),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        //name
                        "Pomegranate",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        spacing: 4,
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 15),
                          Text(
                            "4.9",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(

                            // price
                            "₹ 250/",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "kg",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 85, 85, 85),
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          
                        },
                        child: Container(
                          width: 55,
                        decoration: BoxDecoration(color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(4))
                        ),
                          child: Center(
                            child: Text(
                              "Add",
                              style: TextStyle(
                                color: Colors.white,
                               
                              ),
                            ),
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
      ),
    );
  }
}
