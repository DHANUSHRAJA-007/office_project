// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:office_project/screens/userhomepage.dart';
// import 'package:provider/provider.dart';

// import 'cart_provider.dart';

// class Productdetailspage extends StatefulWidget {
//   final DocumentSnapshot product;

//   const Productdetailspage({super.key, required this.product});

//   @override
//   State<Productdetailspage> createState() => _ProductdetailspageState();
// }

// class _ProductdetailspageState extends State<Productdetailspage> {
//   bool isliked = false;

//   late Map<String, dynamic> data;

//   @override
//   void initState() {
//     super.initState();

//     /// ✅ SAFE CAST (NO CRASH)
//     data = widget.product.data() as Map<String, dynamic>;
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /// 🔙 TOP BAR
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconButton(
//                     onPressed: () => Get.back(),
//                     icon: const Icon(Icons.arrow_back),
//                   ),
//                   const Text(
//                     "Product Details",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                   ),
//                 ],
//               ),

//               /// 🖼 IMAGE
//               SizedBox(
//                 height: size.height * 0.35,
//                 width: double.infinity,
//                 child: Image.asset('assets/fruits.png', fit: BoxFit.contain),
//               ),

//               const SizedBox(height: 10),

//               /// 📦 PRODUCT INFO
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         data['productName'] ?? '',
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//                       Text(data['category'] ?? ''),
//                       const Text("4.9 ⭐"),
//                     ],
//                   ),

//                   Text(
//                     "₹${data['price'] ?? 0}",
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 10),

//               /// 📝 DESCRIPTION
//               Text(data['description'] ?? "No description available"),

//               const SizedBox(height: 10),
//               const Divider(),

//               /// 🔥 MORE PRODUCTS
//               const Text("More", style: TextStyle(fontWeight: FontWeight.bold)),

//               const SizedBox(height: 10),

//               SizedBox(
//                 height: 300,
//                 child: StreamBuilder<QuerySnapshot>(
//                   stream: FirebaseFirestore.instance
//                       .collection('products')
//                       .snapshots(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator());
//                     }

//                     if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                       return const Text("no products available");
//                     }

//                     return ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       padding: const EdgeInsets.all(12),
//                       itemCount: snapshot.data!.docs.length,
//                       itemBuilder: (context, index) {
//                         var product = snapshot.data!.docs[index];
//                         var data = product.data() as Map<String, dynamic>;

//                         return Container(
//                           width: 170,
//                           margin: const EdgeInsets.only(right: 12),

//                           child: Card(
//                             elevation: 7,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),

//                             child: Padding(
//                               padding: const EdgeInsets.all(8),

//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   /// OFFER + LIKE
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         padding: const EdgeInsets.symmetric(
//                                           horizontal: 8,
//                                           vertical: 3,
//                                         ),
//                                         decoration: BoxDecoration(
//                                           color: Colors.orange,
//                                           borderRadius: BorderRadius.circular(
//                                             5,
//                                           ),
//                                         ),
//                                         child: Text(
//                                           "Offer ${product['offer']}%",

//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                       ),

//                                       IconButton(
//                                         padding: EdgeInsets.zero,
//                                         constraints: const BoxConstraints(),
//                                         onPressed: () {
//                                           setState(() {
//                                             isliked = !isliked;
//                                           });
//                                         },
//                                         icon: Icon(
//                                           Icons.favorite,
//                                           size: 20,
//                                           color: isliked
//                                               ? Colors.red
//                                               : Colors.grey,
//                                         ),
//                                       ),
//                                     ],
//                                   ),

//                                   const SizedBox(height: 5),

//                                   /// IMAGE
//                                   Expanded(
//                                     child: Center(
//                                       child: Image.asset(
//                                         'assets/fruits.png',
//                                         fit: BoxFit.contain,
//                                       ),
//                                     ),
//                                   ),

//                                   const Divider(),

//                                   /// PRODUCT NAME
//                                   Text(
//                                     data['productName'] ?? '',
//                                     overflow: TextOverflow.ellipsis,
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),

//                                   const SizedBox(height: 5),

//                                   /// PRICE + ADD BUTTON
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         "₹${data['price']}/kg",
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),

//                                       InkWell(
//                                         onTap: () {
//                                           Map<String, dynamic> cartItem = {
//                                             'name': product["productName"],
//                                             'price': product["price"],
//                                             'offer':
//                                                 data["offer"]?.toString() ??
//                                                 "No offer",

//                                             'quantity': 1,
//                                           };

//                                           context
//                                               .read<CartProvider>()
//                                               .addToCart(cartItem);

//                                           ScaffoldMessenger.of(
//                                             context,
//                                           ).showSnackBar(
//                                             SnackBar(
//                                               duration: const Duration(
//                                                 seconds: 3,
//                                               ),
//                                               backgroundColor: Colors.black,
//                                               content: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   const Text(
//                                                     "Product Added to the Cart",
//                                                   ),
//                                                   TextButton(
//                                                     onPressed: () {
//                                                       // HomePage.homeKey.currentState
//                                                       //     ?.changeTab(2);

//                                                       Get.offAll(
//                                                         () => HomePage(
//                                                           role: "user",
//                                                         ),
//                                                         arguments: 1,
//                                                       );
//                                                     },
//                                                     child: const Text(
//                                                       "GO TO CART",
//                                                       style: TextStyle(
//                                                         color: Colors.yellow,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                         child: Container(
//                                           padding: const EdgeInsets.symmetric(
//                                             horizontal: 10,
//                                             vertical: 4,
//                                           ),
//                                           decoration: BoxDecoration(
//                                             color: Colors.green,
//                                             borderRadius: BorderRadius.circular(
//                                               6,
//                                             ),
//                                           ),
//                                           child: const Text(
//                                             "Add",
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//               Divider(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "₹${data['price'] ?? 0}",
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),

//                   ElevatedButton(
//                     onPressed: () {
//                       Map<String, dynamic> cartItem = {
//                         'name': data["productName"],
//                         'price': data["price"],
//                         'offer': data["offer"]?.toString()??"No offer",
//                         'quantity': 1,
//                       };

//                       context.read<CartProvider>().addToCart(cartItem);

//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           duration: const Duration(seconds: 3),
//                           backgroundColor: Colors.black,
//                           content: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text("Product Added to the Cart"),
//                               TextButton(
//                                 onPressed: () {
//                                   // HomePage.homeKey.currentState
//                                   //     ?.changeTab(2);

//                                   Get.offAll(
//                                     () => HomePage(role: "user"),
//                                     arguments: 1,
//                                   );
//                                 },
//                                 child: const Text(
//                                   "GO TO CART",
//                                   style: TextStyle(color: Colors.yellow),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                     child: Text("Add Cart"),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// // }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:office_project/screens/userhomepage.dart';
// import 'package:provider/provider.dart';

// import 'cart_provider.dart';

// class Productdetailspage extends StatefulWidget {
//   final DocumentSnapshot product;

//   const Productdetailspage({super.key, required this.product});

//   @override
//   State<Productdetailspage> createState() => _ProductdetailspageState();
// }

// class _ProductdetailspageState extends State<Productdetailspage> {
//   bool isliked = false;

//   late Map<String, dynamic> data;

//   @override
//   void initState() {
//     super.initState();
//     data = widget.product.data() as Map<String, dynamic>;
//   }

//   /// ✅ COMMON ADD TO CART FUNCTION (BEST PRACTICE)
//   void addToCart(Map<String, dynamic> productData) {
//     Map<String, dynamic> cartItem = {
//       'name': productData["productName"] ?? "",
//       'price': productData["price"] ?? 0,
//       'offer': productData["offer"]?.toString() ?? "No Offer",
//       'quantity': 1,
//     };
//     print("CART ITEM: $cartItem"); // 👈 ADD THIS ALSO

//     context.read<CartProvider>().addToCart(cartItem);

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         duration: const Duration(seconds: 3),
//         backgroundColor: Colors.black,
//         content: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text("Product Added to the Cart"),
//             TextButton(
//               onPressed: () {
//                 Get.offAll(() => HomePage(role: "user"), arguments: 2);
//               },
//               child: const Text(
//                 "GO TO CART",
//                 style: TextStyle(color: Colors.yellow),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         automaticallyImplyLeading: false,
//         centerTitle: true,
//         leading: IconButton(
//           color: Colors.white,
//           onPressed: () => Get.back(),
//           icon: const Icon(Icons.arrow_back),
//         ),
//         title: Text(
//           "Product Details",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /// 🔙 TOP BAR
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //   children: [
//               //     IconButton(
//               //       onPressed: () => Get.back(),
//               //       icon: const Icon(Icons.arrow_back),
//               //     ),
//               //     const Text(
//               //       "Product Details",
//               //       style:
//               //           TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//               //     ),
//               //   ],
//               // ),

//               /// IMAGE
//               SizedBox(
//                 height: size.height * 0.35,
//                 width: double.infinity,
//                 child: Image.asset('assets/fruits.png', fit: BoxFit.contain),
//               ),

//               const SizedBox(height: 10),

//               /// PRODUCT INFO
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         data['productName'] ?? '',
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//                       Text(data['category'] ?? ''),
//                       // const Text("4.9 ⭐"),
//                     ],
//                   ),
//                   Text(
//                     "Rs.${data['price'] ?? 0}",
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 10),

//               /// DESCRIPTION
//               Text(data['description'] ?? "No description available"),

//               const Divider(),

//               /// MORE PRODUCTS
//               const Text("More", style: TextStyle(fontWeight: FontWeight.bold)),

//               const SizedBox(height: 10),

//               SizedBox(
//                 height: 300,
//                 child: StreamBuilder<QuerySnapshot>(
//                   stream: FirebaseFirestore.instance
//                       .collection('products')
//                       .snapshots(),
//                   builder: (context, snapshot) {
//                     if (!snapshot.hasData) {
//                       return const Center(child: CircularProgressIndicator());
//                     }

//                     return ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: snapshot.data!.docs.length,
//                       itemBuilder: (context, index) {
//                         var doc = snapshot.data!.docs[index];
//                         var data = doc.data() as Map<String, dynamic>;

//                         return Container(
//                           width: 170,
//                           margin: const EdgeInsets.only(right: 12),
//                           child: Card(
//                             elevation: 7,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   /// OFFER
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         padding: const EdgeInsets.symmetric(
//                                           horizontal: 8,
//                                           vertical: 3,
//                                         ),
//                                         decoration: BoxDecoration(
//                                           color: Colors.orange,
//                                           borderRadius: BorderRadius.circular(
//                                             5,
//                                           ),
//                                         ),
//                                         child: Text(
//                                           data['offer'] != null
//                                               ? "Offer ${data['offer']}"
//                                               : "No Offer",
//                                           style: const TextStyle(fontSize: 12),
//                                         ),
//                                       ),

//                                       // IconButton(
//                                       //   icon: Icon(
//                                       //     Icons.favorite,
//                                       //     color: isliked
//                                       //         ? Colors.red
//                                       //         : Colors.grey,
//                                       //   ),
//                                       //   onPressed: () {
//                                       //     setState(() {
//                                       //       isliked = !isliked;
//                                       //     });
//                                       //   },
//                                       // ),
//                                     ],
//                                   ),

//                                   Expanded(
//                                     child: Center(
//                                       child: Image.asset('assets/fruits.png'),
//                                     ),
//                                   ),

//                                   Text(
//                                     data['productName'] ?? '',
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),

//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         "₹ ${data['price']}/-",
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),

//                                       /// ADD BUTTON
//                                       InkWell(
//                                         onTap: () => addToCart(data),
//                                         child: Container(
//                                           padding: const EdgeInsets.symmetric(
//                                             horizontal: 10,
//                                             vertical: 4,
//                                           ),
//                                           decoration: BoxDecoration(
//                                             color: Colors.green,
//                                             borderRadius: BorderRadius.circular(
//                                               6,
//                                             ),
//                                           ),
//                                           child: const Text(
//                                             "Add",
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),

//               const Divider(),

//               /// BOTTOM ADD BUTTON
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,

//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Total Price"),

//                       Text(
//                         "₹ ${data['price'] ?? 0}/-",
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//                     ],
//                   ),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                     ),
//                     onPressed: () => addToCart(data),
//                     child: const Text(
//                       "Add To Cart",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_project/screens/userhomepage.dart';
import 'package:provider/provider.dart';

import 'cart_provider.dart';

class Productdetailspage extends StatefulWidget {
  final DocumentSnapshot product;

  const Productdetailspage({super.key, required this.product});

  @override
  State<Productdetailspage> createState() =>
      _ProductdetailspageState();
}

class _ProductdetailspageState
    extends State<Productdetailspage> {
  bool isliked = false;

  late Map<String, dynamic> data;

  /// ✅ IMAGE FUNCTION ADDED
  String getProductImage(String name) {
    name = name.toLowerCase();

    if (name.contains("pappali")) {
      return "assets/pappali.jpg";
    } else if (name.contains("banana")) {
      return "assets/banana.png";
    } else if (name.contains("carrot")) {
      return "assets/carrot.png";
    } else if (name.contains("tomato")) {
      return "assets/tomato.png";
    } else if (name.contains("potato")) {
      return "assets/potato.png";
    } else if (name.contains("onion")) {
      return "assets/onion.png";
    } else if (name.contains("mango")) {
      return "assets/mango.png";
    } else {
      return "assets/default.png";
    }
  }

  @override
  void initState() {
    super.initState();
    data = widget.product.data() as Map<String, dynamic>;
  }

  /// ✅ ADD TO CART (UNCHANGED)
  void addToCart(Map<String, dynamic> productData) {
    Map<String, dynamic> cartItem = {
      'name': productData["productName"] ?? "",
      'price': productData["price"] ?? 0,
      'offer': productData["offer"]?.toString() ?? "No Offer",
      'quantity': 1,
    };

    context.read<CartProvider>().addToCart(cartItem);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.black,
        content: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            const Text("Product Added to the Cart"),
            TextButton(
              onPressed: () {
                Get.offAll(
                    () => HomePage(role: "user"),
                    arguments: 2);
              },
              child: const Text(
                "GO TO CART",
                style: TextStyle(color: Colors.yellow),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          color: Colors.white,
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          "Product Details",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              /// ✅ IMAGE (UPDATED)
              SizedBox(
                height: size.height * 0.35,
                width: double.infinity,
                child: Image.asset(
                  getProductImage(data['productName']),
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 10),

              /// PRODUCT INFO
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['productName'] ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(data['category'] ?? ''),
                    ],
                  ),
                  Text(
                    "Rs.${data['price'] ?? 0}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              /// DESCRIPTION
              Text(data['description'] ??
                  "No description available"),

              const Divider(),

              /// MORE PRODUCTS
              const Text(
                "More",
                style:
                    TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 300,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('products')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                          child:
                              CircularProgressIndicator());
                    }

                    return ListView.builder(
                      scrollDirection:
                          Axis.horizontal,
                      itemCount:
                          snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var doc =
                            snapshot.data!.docs[index];
                        var data = doc.data()
                            as Map<String, dynamic>;

                        return Container(
                          width: 170,
                          margin: const EdgeInsets.only(
                              right: 12),
                          child: Card(
                            elevation: 7,
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                      12),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                children: [
                                  /// OFFER
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                    children: [
                                      Container(
                                        padding:
                                            const EdgeInsets
                                                .symmetric(
                                          horizontal: 8,
                                          vertical: 3,
                                        ),
                                        decoration:
                                            BoxDecoration(
                                          color:
                                              Colors.orange,
                                          borderRadius:
                                              BorderRadius
                                                  .circular(
                                                      5),
                                        ),
                                        child: Text(
                                          data['offer'] !=
                                                  null
                                              ? "Offer ${data['offer']}"
                                              : "No Offer",
                                          style:
                                              const TextStyle(
                                                  fontSize:
                                                      12),
                                        ),
                                      ),
                                    ],
                                  ),

                                  /// ✅ IMAGE UPDATED HERE ALSO
                                  Expanded(
                                    child: Center(
                                      child: Image.asset(
                                        getProductImage(
                                            data['productName']),
                                      ),
                                    ),
                                  ),

                                  Text(
                                    data['productName'] ??
                                        '',
                                    style:
                                        const TextStyle(
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                    children: [
                                      Text(
                                        "₹ ${data['price']}/-",
                                        style:
                                            const TextStyle(
                                          fontWeight:
                                              FontWeight
                                                  .bold,
                                        ),
                                      ),

                                      /// ADD BUTTON
                                      InkWell(
                                        onTap: () =>
                                            addToCart(data),
                                        child: Container(
                                          padding:
                                              const EdgeInsets
                                                  .symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration:
                                              BoxDecoration(
                                            color:
                                                Colors.green,
                                            borderRadius:
                                                BorderRadius
                                                    .circular(
                                                        6),
                                          ),
                                          child:
                                              const Text(
                                            "Add",
                                            style: TextStyle(
                                                color: Colors
                                                    .white),
                                          ),
                                        ),
                                      ),
                                    ],
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

              const Divider(),

              /// BOTTOM ADD BUTTON
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text("Total Price"),
                      Text(
                        "₹ ${data['price'] ?? 0}/-",
                        style: const TextStyle(
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () => addToCart(data),
                    child: const Text(
                      "Add To Cart",
                      style:
                          TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}