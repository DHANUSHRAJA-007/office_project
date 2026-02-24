import 'package:flutter/material.dart';

class ViewProductpage extends StatelessWidget {
  const ViewProductpage({super.key});

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
          "View Product",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 60),
            child: SizedBox(
              width: 450,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 180),
                          Center(
                            child: Image(
                              image: AssetImage("assets/v1.jpg"),
                              height: 100,
                              width: 100,
                            ),
                          ),
                          SizedBox(width: 100),
                          Container(
                            height: 15,
                            width: 15,
                            color: Colors.grey,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                          // IconButton(onPressed: (){}, icon:Icon(Icons.close))
                        ],
                      ),
                      SizedBox(height: 30),
                      _details("Product Id", "001"),
                      _details("Product Name", "Orange"),
                      _details("Product Categories", "Fruits"),
                      _details("Offers", "3%"),
                      _details("Exist Only", "10 Kg"),
                      _details("Stock", "In-stock"),
                      _details("price", "₹ 250/1kg"),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _button("Delete", Colors.red),
                          _button("Edit", Colors.green),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _details(String detail1, detail2) {
    return SizedBox(
      width: 240,
      height: 20,
      // color: Colors.yellow,
      child: Row(
        children: [
          SizedBox(
            width: 130,
            // color: Colors.red,
            child: Text(detail1),
          ),
          Container(
            alignment: Alignment.center,
            width: 15,
            // color: Colors.white,
            child: Text(":  "),
          ),
          Text(detail2),
        ],
      ),
    );
  }

  Widget _button(String name, Color color) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: BeveledRectangleBorder(),
      ),
      child: Text(name, style: TextStyle(color: Colors.white)),
    );
  }
}
