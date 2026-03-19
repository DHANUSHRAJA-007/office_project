// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:office_project/screens/fruitspage.dart';
// import 'package:office_project/screens/juicepage.dart';
// import 'package:office_project/screens/uploadproduct.dart';

// class Addproduct extends StatelessWidget {
//   const Addproduct({super.key});

//   @override
//   Future<Widget> build(BuildContext context) async {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xff4CAF50),
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {},
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//         ),
//         title: Text(
//           "Product",
//           style: TextStyle(
//             fontSize: 20,
//             // fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(height: 50),
//             InkWell(
//               onTap: () {
//                 Get.to(UploadProductPage());
//               },
//               child: Container(
//                 height: 50,
//                 width: 150,
//                 color: Color(0xff4CAF50),
//                 child: Row(
//                   children: [
//                     Icon(Icons.add, color: Colors.white),
//                     Text(
//                       "Add Product",
//                       style: TextStyle(fontSize: 20, color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             SizedBox(height: 30),
//             Column(
//               spacing: 10,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     Get.to(FruitsPage());
//                   },
//                   child: _productCards("assets/v1.jpg", "Fruits"),
//                 ),
//                 InkWell(
//                   onTap: (){ Get.to(JuicePage());},
//                   child: _productCards("assets/v1.jpg", "juice")),
//                 _productCards("assets/v1.jpg", "vegetables"),
//                 _productCards("assets/v1.jpg", "protein powder"),
//               ],
//             ),

//             SizedBox(height: 50),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _productCards(String image, name) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: SizedBox(
//         height: 50,
//         width: 470,
//         child: Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(5)),
//           ),
//           elevation: 3,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,

//             children: [
//               Image(image: AssetImage(image), height: 40, width: 40),
//               SizedBox(
//                 width: 300,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [Text(name, style: TextStyle(fontSize: 18))],
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {},
//                 icon: Icon(
//                   Icons.arrow_forward_ios,
//                   size: 20,
//                   color: const Color.fromARGB(255, 124, 122, 122),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_project/screens/fruitspage.dart';
import 'package:office_project/screens/juicepage.dart';
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
              onTap: () {
                Get.to(() => const UploadProductPage());
              },
              child: Container(
                height: 50,
                width: 150,
                color: const Color(0xff4CAF50),
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

            const SizedBox(height: 30),

            Column(
              children: [
                _productCards("assets/v1.jpg", "Fruits", "/Fruits"),

              

                _productCards("assets/v1.jpg", "Vegetables", '/vegetable'),

                _productCards(
                  "assets/v1.jpg",
                  "Malt",
                  '/malt',
                ),
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
        onTap: () {
          if (route == '/juice') {
            Get.to(Juicepage());
          } else if (route == '/Fruits') {
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
