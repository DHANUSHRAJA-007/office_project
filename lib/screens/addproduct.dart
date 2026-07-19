import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_project/screens/fruitspage.dart';
import 'package:office_project/screens/maltpage.dart';
import 'package:office_project/screens/uploadproduct.dart';
import 'package:office_project/screens/vegetablepage.dart';

class Addproduct extends StatelessWidget {
  const Addproduct({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ FIXED
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4CAF50),
        automaticallyImplyLeading: false,
        centerTitle: true,
        // leading: IconButton(
        //   onPressed: () {
        //     Get.back(); // optional back
        //   },
        //   icon: const Icon(Icons.arrow_back, color: Colors.white),
        // ),
        title: const Text(
          "Product",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),

            InkWell(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              onTap: () {
                Get.to(() => const UploadProductPage());
              },
              child: Card(
                elevation: 1,
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    color: const Color(0xff4CAF50),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      SizedBox(width: 5),
                      Text(
                        "Add Product",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Column(
              children: [
                _productCards("assets/v1.jpg", "Fruits", "/Fruits"),

                _productCards("assets/v1.jpg", "Vegetables", '/vegetable'),

                _productCards("assets/v1.jpg", "Malt", '/malt'),
              ],
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _productCards(String image, String name, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        onTap: () {
            if (route == '/Fruits') {
            Get.to(FruitsPage());
          } else if (route == "/vegetable") {
            Get.to(Vegetablepage());
          } else if (route == '/malt') {
            Get.to(Maltpage());
          }
        },
        child: SizedBox(
          height: 60,
          child: Card(
            elevation: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(image, height: 40, width: 40),
                SizedBox(
                  width: 200,
                  child: Text(name, style: const TextStyle(fontSize: 18)),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
