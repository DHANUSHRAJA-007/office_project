import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_project/screens/uploadproduct.dart';

class Addproduct extends StatelessWidget {
  const Addproduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4CAF50),
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          "Product",
          style: TextStyle(
            fontSize: 20,
            // fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            InkWell(
              onTap: () {
                Get.to(UploadProductPage());
              },
              child: Container(
                height: 50,
                width: 150,
                color: Color(0xff4CAF50),
                child: Row(
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    Text(
                      "Add Product",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30),
            Column(
              spacing: 10,
              children: [
                _productCards("assets/v1.jpg", "Fruits"),
                _productCards("assets/v1.jpg", "Fruits"),
                _productCards("assets/v1.jpg", "Fruits"),
                _productCards("assets/v1.jpg", "Fruits"),
                _productCards("assets/v1.jpg", "Fruits"),
                _productCards("assets/v1.jpg", "Fruits"),
                _productCards("assets/v1.jpg", "Fruits"),
              ],
            ),

            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _productCards(String image, name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 50,
        width: 470,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          elevation: 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              Image(image: AssetImage(image), height: 40, width: 40),
              SizedBox(
                width: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(name, style: TextStyle(fontSize: 18))],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: const Color.fromARGB(255, 124, 122, 122),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
