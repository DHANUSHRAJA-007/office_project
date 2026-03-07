// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:office_project/screens/view_productpage.dart';

// class Productdetailspage extends StatefulWidget {
//   const Productdetailspage({super.key});

//   @override
//   State<Productdetailspage> createState() => _ProductdetailspageState();
// }

// class _ProductdetailspageState extends State<Productdetailspage> {
//   bool isliked = false;

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
//               Text(
//                 "Product Details",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     isliked = !isliked;
//                   });
//                 },
//                 icon: Icon(
//                   Icons.favorite,
//                   color: isliked ? Colors.white : Colors.red,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             width: double.infinity,
//             child: Icon(Icons.image),
//             height: size.height * 0.4,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Productname",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Text("category"),
//                     Text("ratings"),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Text(
//                         "Price",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 10),
//           SizedBox(height: 100, child: Text("Product description")),
//           Divider(),
//           Text("More ", style: TextStyle(fontWeight: FontWeight.bold)),
//           SizedBox(height: 10),
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('products')
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return Text("no products available");
//                 }
//                 return GridView.builder(
//             padding: const EdgeInsets.all(12),
//             itemCount: snapshot.data!.docs.length,
//             gridDelegate:
//                 const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 12,
//               mainAxisSpacing: 12,
//               childAspectRatio: 0.75,
//             ),
//             itemBuilder: (context, index) {
//               var product = snapshot.data!.docs[index];
//               var data =
//                   product.data() as Map<String, dynamic>;

//               return InkWell(
//                 onTap: () {
//                   Get.to(
//                     ViewProductpage(
//                       productId: product.id,
//                       productData: product,
//                     ),
//                   );
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.shade300,
//                         blurRadius: 5,
//                         spreadRadius: 2,
//                       ),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Column(
//                       crossAxisAlignment:
//                           CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           data['productName'] ?? '',
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                         const SizedBox(height: 6),
//                         Text(
//                           data['description'] ?? '',
                          
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                               color: Colors.grey),
//                         ),
//                         const Spacer(),
//                         Text(
//                           "₹ ${data['price']}",
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.green,
//                           ),
//                         ),
//                         const SizedBox(height: 5),
//                         Text(
//                           "Stock: ${data['stock']} ${data['unit']}",
//                           style:
//                               const TextStyle(fontSize: 12),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_project/screens/view_productpage.dart';

class Productdetailspage extends StatefulWidget {
  const Productdetailspage({super.key});

  @override
  State<Productdetailspage> createState() => _ProductdetailspageState();
}

class _ProductdetailspageState extends State<Productdetailspage> {
  bool isliked = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Top bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),

                const Text(
                  "Product Details",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

                IconButton(
                  onPressed: () {
                    setState(() {
                      isliked = !isliked;
                    });
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: isliked ? Colors.red : Colors.grey,
                  ),
                ),
              ],
            ),

            /// Product Image
            SizedBox(
              width: double.infinity,
              height: size.height * 0.35,
              child: const Icon(
                Icons.image,
                size: 120,
              ),
            ),

            /// Product info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Productname",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("category"),
                      Text("ratings"),
                    ],
                  ),

                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Price",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// Description
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                height: 80,
                child: Text("Product description"),
              ),
            ),

            const Divider(),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "More",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),

            const SizedBox(height: 10),

            /// Product list
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .snapshots(),

                builder: (context, snapshot) {

                  /// DEBUG PRINTS
                  print("Connection: ${snapshot.connectionState}");
                  print("Has Data: ${snapshot.hasData}");

                  if (snapshot.hasData) {
                    print("Docs length: ${snapshot.data!.docs.length}");
                  }

                  /// Loading
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  /// No data
                  if (!snapshot.hasData ||
                      snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        "No products available",
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }

                  /// Product Grid
                  return GridView.builder(
                    padding: const EdgeInsets.all(12),

                    itemCount: snapshot.data!.docs.length,

                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.75,
                    ),

                    itemBuilder: (context, index) {

                      var product = snapshot.data!.docs[index];

                      var data =
                          product.data() as Map<String, dynamic>;

                      print(data); // DEBUG DATA

                      return InkWell(
                        onTap: () {
                          Get.to(
                            ViewProductpage(
                              productId: product.id,
                              productData: product,
                            ),
                          );
                        },

                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 5,
                                spreadRadius: 2,
                              ),
                            ],
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(10),

                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,

                              children: [

                                Text(
                                  data['productName'] ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Text(
                                  data['description'] ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.grey),
                                ),

                                const Spacer(),

                                Text(
                                  "₹ ${data['price']}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  "Stock: ${data['stock']} ${data['unit']}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}