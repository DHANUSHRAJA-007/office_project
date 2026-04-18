// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
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
//   void addToCart(Map<String, dynamic> productData) async {
//   final user = FirebaseAuth.instance.currentUser;

//   if (user == null) {
//     Get.snackbar("Error", "User not logged in");
//     return;
//   }

//   Map<String, dynamic> cartItem = {
//     'userId': user.uid,
//     'productId': widget.product.id, // 🔥 IMPORTANT
//     'name': productData["productName"] ?? "",
//     'price': productData["price"] ?? 0,
//     'offer': productData["offer"]?.toString() ?? "No Offer",
//     'quantity': 1,
//   };

//   // 🔥 SAVE TO FIRESTORE
//   await FirebaseFirestore.instance.collection('cart').add(cartItem);

//   // OPTIONAL (keep if you want local state also)
//   context.read<CartProvider>().addToCart(cartItem);

//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       duration: const Duration(seconds: 3),
//       backgroundColor: Colors.black,
//       content: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text("Product Added to the Cart"),
//           TextButton(
//             onPressed: () {
//               Get.offAll(() => HomePage(role: "user"), arguments: 2);
//             },
//             child: const Text(
//               "GO TO CART",
//               style: TextStyle(color: Colors.yellow),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_project/screens/userhomepage.dart';
import 'package:provider/provider.dart';

import 'cart_provider.dart';

class Productdetailspage extends StatefulWidget {
  final DocumentSnapshot product;

  const Productdetailspage({super.key, required this.product});

  @override
  State<Productdetailspage> createState() => _ProductdetailspageState();
}

class _ProductdetailspageState extends State<Productdetailspage> {
  bool isliked = false;

  late Map<String, dynamic> data;

  @override
  void initState() {
    super.initState();
    data = widget.product.data() as Map<String, dynamic>;
  }

  /// ✅ FIXED ADD TO CART
  void addToCart(Map<String, dynamic> productData) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Get.snackbar("Error", "User not logged in");
      return;
    }

    try {
      Map<String, dynamic> cartItem = {
        'userId': user.uid,
        'productId': widget.product.id,
        'name': productData["productName"] ?? "",
        'price': productData["price"].toString(), // ✅ FIXED
        'offer': productData["offer"]?.toString() ?? "No Offer",
        'quantity': 1,
      };

      // 🔥 CHECK IF PRODUCT ALREADY EXISTS
      final existing = await FirebaseFirestore.instance
          .collection('cart')
          .where('userId', isEqualTo: user.uid)
          .where('productId', isEqualTo: widget.product.id)
          .get();

      if (existing.docs.isNotEmpty) {
        // ✅ INCREASE QUANTITY
        var doc = existing.docs.first;

        int currentQty = doc['quantity'] ?? 1;

        await doc.reference.update({'quantity': currentQty + 1});

        print("UPDATED QUANTITY");
      } else {
        // ✅ ADD NEW ITEM
        await FirebaseFirestore.instance.collection('cart').add(cartItem);

        print("ADDED NEW ITEM");
      }

      // OPTIONAL (local provider)
      context.read<CartProvider>().addToCart(cartItem);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.black,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Product Added to Cart"),
              TextButton(
                onPressed: () {
                  Get.offAll(() => HomePage(role: "user"), arguments: 2);
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
    } catch (e) {
      print("ERROR ADDING TO CART: $e");
      Get.snackbar("Error", "Failed to add to cart");
    }
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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// IMAGE
              SizedBox(
                height: size.height * 0.35,
                width: double.infinity,
                child: Image.asset('assets/fruits.png', fit: BoxFit.contain),
              ),

              const SizedBox(height: 10),

              /// PRODUCT INFO
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
              Text(data['description'] ?? "No description available"),

              const Divider(),

              /// MORE PRODUCTS
              const Text("More", style: TextStyle(fontWeight: FontWeight.bold)),

              const SizedBox(height: 10),

              SizedBox(
                height: 300,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('products')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var doc = snapshot.data!.docs[index];
                        var data = doc.data() as Map<String, dynamic>;

                        return Container(
                          width: 170,
                          margin: const EdgeInsets.only(right: 12),
                          child: Card(
                            elevation: 7,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 3,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        child: Text(
                                          data['offer'] != null
                                              ? "Offer ${data['offer']}"
                                              : "No Offer",
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),

                                  Expanded(
                                    child: Center(
                                      child: Image.asset('assets/fruits.png'),
                                    ),
                                  ),

                                  Text(
                                    data['productName'] ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "₹ ${data['price']}/-",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      InkWell(
                                        onTap: () => addToCart(data),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                          child: const Text(
                                            "Add",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Total Price"),
                      Text(
                        "₹ ${data['price'] ?? 0}/-",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
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
                      style: TextStyle(color: Colors.white),
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
