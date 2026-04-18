// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:office_project/screens/addresspage.dart';
// import 'package:provider/provider.dart';
// import 'cart_provider.dart';

// class Cartpage extends StatefulWidget {
//   const Cartpage({super.key});

//   @override
//   State<Cartpage> createState() => _CartpageState();
// }

// /// 🔥 PLACE ORDER FUNCTION (UPDATED ONLY productId ADDED)
// Future<void> placeOrder(
//   DocumentSnapshot userDoc,
//   List cart,
//   int total,
//   CartProvider cartProvider,
// ) async {
//   final user = FirebaseAuth.instance.currentUser;

//   final cartItems = cart.map((item) {
//     return {
//       'productId': item['productId'], // 🔥 ADD THIS LINE
//       'name': item['name'],
//       'price': item['price'],
//       'quantity': item['quantity'],
//     };
//   }).toList();

//   await FirebaseFirestore.instance.collection('orders').add({
//     'buyerId': user!.uid,
//     'buyerName': userDoc['name'],
//     'buyerAddress': userDoc['address'],
//     'buyermobile': userDoc['phonenumber'],
//     'items': cartItems,
//     'total': total,
//     'status': 'pending',
//     'timestamp': FieldValue.serverTimestamp(),
//   });

//   /// 🔥 CLEAR FIRESTORE CART ALSO
//   final cartDocs = await FirebaseFirestore.instance
//       .collection('cart')
//       .where('userId', isEqualTo: user.uid)
//       .get();

//   for (var doc in cartDocs.docs) {
//     await doc.reference.delete();
//   }

//   cartProvider.clearCart();

//   Get.snackbar("Success", "Order placed successfully");
// }

// class _CartpageState extends State<Cartpage> {
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;

//     if (user == null) {
//       return const Scaffold(body: Center(child: Text("User not logged in")));
//     }

//     return Scaffold(
//       backgroundColor: const Color(0xffECECEC),

//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           "My Cart",
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         backgroundColor: Colors.green,
//       ),

//       /// 🔥 FIRESTORE CART
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('cart')
//             .where('userId', isEqualTo: user.uid)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           final cartDocs = snapshot.data!.docs;

//           if (cartDocs.isEmpty) {
//             return const Center(child: Text("No items in the cart"));
//           }

//           /// 🔥 CALCULATE TOTAL
//           int subtotal = 0;

//           for (var doc in cartDocs) {
//             final data = doc.data() as Map<String, dynamic>;
//             int price = int.tryParse(data['price'].toString()) ?? 0;
//             int quantity = data['quantity'] ?? 1;
//             subtotal += price * quantity;
//           }

//           int delivery = 20;
//           int discount = 0;
//           int total = subtotal + delivery - discount;

//           List cart = cartDocs.map((doc) {
//             final data = doc.data() as Map<String, dynamic>;

//             return {
//               ...data,
//               'cartDocId': doc.id, // optional but safe
//             };
//           }).toList();

//           return Column(
//             children: [
//               /// 🔥 CART ITEMS
//               Expanded(
//                 child: ListView.builder(
//                   padding: const EdgeInsets.all(12),
//                   itemCount: cartDocs.length,
//                   itemBuilder: (_, index) {
//                     final doc = cartDocs[index];
//                     final data = doc.data() as Map<String, dynamic>;

//                     int price = int.tryParse(data['price'].toString()) ?? 0;
//                     int quantity = data['quantity'] ?? 1;
//                     int newprice = price * quantity;

//                     return Container(
//                       margin: const EdgeInsets.only(bottom: 12),
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(14),
//                       ),
//                       child: Row(
//                         children: [
//                           Image.asset("assets/v1.jpg", height: 70),

//                           const SizedBox(width: 12),

//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   data["name"],
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 5),
//                                 Text("₹ $newprice"),
//                               ],
//                             ),
//                           ),

//                           Row(
//                             children: [
//                               /// ➖ DECREMENT
//                               Container(
//                                 width: 28,
//                                 height: 28,
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey.shade300,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: IconButton(
//                                   padding: EdgeInsets.zero,
//                                   icon: const Icon(Icons.remove, size: 16),
//                                   onPressed: () async {
//                                     if (quantity > 1) {
//                                       await FirebaseFirestore.instance
//                                           .collection('cart')
//                                           .doc(doc.id)
//                                           .update({'quantity': quantity - 1});
//                                     } else {
//                                       await FirebaseFirestore.instance
//                                           .collection('cart')
//                                           .doc(doc.id)
//                                           .delete();
//                                     }
//                                   },
//                                 ),
//                               ),

//                               const SizedBox(width: 8),

//                               Text("$quantity"),

//                               const SizedBox(width: 8),

//                               /// ➕ INCREMENT
//                               Container(
//                                 width: 28,
//                                 height: 28,
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey.shade300,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: IconButton(
//                                   padding: EdgeInsets.zero,
//                                   icon: const Icon(Icons.add, size: 16),
//                                   onPressed: () async {
//                                     await FirebaseFirestore.instance
//                                         .collection('cart')
//                                         .doc(doc.id)
//                                         .update({'quantity': quantity + 1});
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),

//               /// 🔥 BILL SECTION
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
//                 ),
//                 child: Column(
//                   children: [
//                     billRow("Sub Total", subtotal),
//                     billRow("Delivery Fee", delivery),
//                     billRow("Discount", discount),
//                     const Divider(),
//                     billRow("TOTAL COST", total, isBold: true),
//                     const Divider(),

//                     /// 🔥 ADDRESS
//                     FutureBuilder<DocumentSnapshot>(
//                       future: FirebaseFirestore.instance
//                           .collection('users')
//                           .doc(user.uid)
//                           .get(),
//                       builder: (context, snapshot) {
//                         if (!snapshot.hasData) {
//                           return const SizedBox();
//                         }

//                         final data =
//                             snapshot.data!.data() as Map<String, dynamic>?;

//                         String address = data?['address'] ?? "No Address Added";
//                         String phonenumber =
//                             data?['phonenumber'] ?? "No Phone Number";

//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               "Delivery Address",
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                             const SizedBox(height: 5),
//                             Text(address),
//                             Row(
//                               children: [
//                                 Text(
//                                   "Mobile Number : ",
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 Text(phonenumber),
//                               ],
//                             ),
//                           ],
//                         );
//                       },
//                     ),

//                     const SizedBox(height: 20),

//                     /// 🔥 CHECKOUT BUTTON
//                     SizedBox(
//                       width: double.infinity,
//                       height: 40,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.green,
//                         ),
//                         onPressed: () async {
//                           try {
//                             final cartProvider = context.read<CartProvider>();

//                             final userDoc = await FirebaseFirestore.instance
//                                 .collection('users')
//                                 .doc(user.uid)
//                                 .get();

//                             if (!userDoc.data()!.containsKey('address') ||
//                                 userDoc['address'] == null ||
//                                 userDoc['address'].toString().isEmpty) {
//                               Get.snackbar("Error", "Please add address first");

//                               bool? result = await Get.to(
//                                 () => AddAddressPage(fromCheckout: true),
//                               );

//                               if (result == true) {
//                                 final updatedUserDoc = await FirebaseFirestore
//                                     .instance
//                                     .collection('users')
//                                     .doc(user.uid)
//                                     .get();

//                                 await placeOrder(
//                                   updatedUserDoc,
//                                   cart,
//                                   total,
//                                   cartProvider,
//                                 );
//                               }
//                               return;
//                             }

//                             await placeOrder(
//                               userDoc,
//                               cart,
//                               total,
//                               cartProvider,
//                             );
//                           } catch (e) {
//                             Get.snackbar("Error", e.toString());
//                           }
//                         },
//                         child: const Text(
//                           "Proceed to Checkout",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Widget billRow(String title, int price, {bool isBold = false}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [Text(title), Text("₹ $price")],
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_project/screens/addresspage.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart'; // ✅ ADDED
import 'cart_provider.dart';

class Cartpage extends StatefulWidget {
  const Cartpage({super.key});

  @override
  State<Cartpage> createState() => _CartpageState();
}

/// 🔥 PLACE ORDER FUNCTION (UNCHANGED)
Future<void> placeOrder(
  DocumentSnapshot userDoc,
  List cart,
  int total,
  CartProvider cartProvider,
) async {
  final user = FirebaseAuth.instance.currentUser;

  final cartItems = cart.map((item) {
    return {
      'productId': item['productId'],
      'name': item['name'],
      'price': item['price'],
      'quantity': item['quantity'],
    };
  }).toList();

  await FirebaseFirestore.instance.collection('orders').add({
    'buyerId': user!.uid,
    'buyerName': userDoc['name'],
    'buyerAddress': userDoc['address'],
    'buyermobile': userDoc['phonenumber'],
    'items': cartItems,
    'total': total,
    'status': 'pending',
    'timestamp': FieldValue.serverTimestamp(),
  });

  final cartDocs = await FirebaseFirestore.instance
      .collection('cart')
      .where('userId', isEqualTo: user.uid)
      .get();

  for (var doc in cartDocs.docs) {
    await doc.reference.delete();
  }

  cartProvider.clearCart();

 // Get.snackbar("Success", "Order placed successfully");
}

class _CartpageState extends State<Cartpage> {
  // ✅ GLOBAL VARIABLES (IMPORTANT FIX)
  List cart = [];
  int total = 0;

  // ✅ RAZORPAY
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handleSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handleError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleWallet);
  }

  // ✅ OPEN PAYMENT
  void openCheckout() {
    var options = {
      'key': 'rzp_test_SbfR8cM92dAPsi', // 🔴 PUT YOUR TEST KEY
      'amount': total * 100,
      'name': 'AASHAI',
      'description': 'Order Payment',
      'prefill': {'contact': '9876543210', 'email': 'test@gmail.com'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e);
    }
  }

  // ✅ PAYMENT SUCCESS
  void _handleSuccess(PaymentSuccessResponse response) async {
    final user = FirebaseAuth.instance.currentUser;
    final cartProvider = context.read<CartProvider>();

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    await placeOrder(userDoc, cart, total, cartProvider);

    Get.snackbar(
      "Success",
      "Payment Successful & Order Placed",
      backgroundColor: Colors.white,
      colorText: Colors.black,
    );
  }

  // ❌ PAYMENT FAILED
  void _handleError(PaymentFailureResponse response) {
    String message = "Your order was not placed. Please try again.";

    if (response.code == Razorpay.PAYMENT_CANCELLED) {
      message = "Payment cancelled. Your order was not placed.";
    } else if (response.code == Razorpay.NETWORK_ERROR) {
      message = "Network issue. Your order was not placed.";
    }

    Get.snackbar(
      "Payment Failed ❌",
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  // 💳 WALLET
  void _handleWallet(ExternalWalletResponse response) {
    print("Wallet: ${response.walletName}");
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(body: Center(child: Text("User not logged in")));
    }

    return Scaffold(
      backgroundColor: const Color(0xffECECEC),

      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('cart')
            .where('userId', isEqualTo: user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final cartDocs = snapshot.data!.docs;

          if (cartDocs.isEmpty) {
            return const Center(child: Text("No items in the cart"));
          }

          int subtotal = 0;

          for (var doc in cartDocs) {
            final data = doc.data() as Map<String, dynamic>;
            int price = int.tryParse(data['price'].toString()) ?? 0;
            int quantity = data['quantity'] ?? 1;
            subtotal += price * quantity;
          }

          int delivery = 20;
          int discount = 0;

          // ✅ UPDATE GLOBAL VALUES
          total = subtotal + delivery - discount;

          cart = cartDocs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return {...data, 'cartDocId': doc.id};
          }).toList();

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: cartDocs.length,
                  itemBuilder: (_, index) {
                    final doc = cartDocs[index];
                    final data = doc.data() as Map<String, dynamic>;

                    int price = int.tryParse(data['price'].toString()) ?? 0;
                    int quantity = data['quantity'] ?? 1;
                    int newprice = price * quantity;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Image.asset("assets/v1.jpg", height: 70),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data["name"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text("₹ $newprice"),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(Icons.remove, size: 16),
                                  onPressed: () async {
                                    if (quantity > 1) {
                                      await FirebaseFirestore.instance
                                          .collection('cart')
                                          .doc(doc.id)
                                          .update({'quantity': quantity - 1});
                                    } else {
                                      await FirebaseFirestore.instance
                                          .collection('cart')
                                          .doc(doc.id)
                                          .delete();
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text("$quantity"),
                              const SizedBox(width: 8),
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(Icons.add, size: 16),
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection('cart')
                                        .doc(doc.id)
                                        .update({'quantity': quantity + 1});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                child: Column(
                  children: [
                    billRow("Sub Total", subtotal),
                    billRow("Delivery Fee", delivery),
                    billRow("Discount", discount),
                    const Divider(),
                    billRow("TOTAL COST", total, isBold: true),
                    const Divider(),

                    FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid)
                          .get(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox();
                        }

                        final data =
                            snapshot.data!.data() as Map<String, dynamic>?;

                        String address = data?['address'] ?? "No Address Added";
                        String phonenumber =
                            data?['phonenumber'] ?? "No Phone Number";

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Delivery Address",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(address),
                            Row(
                              children: [
                                const Text(
                                  "Mobile Number : ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(phonenumber),
                              ],
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () async {
                          final userDoc = await FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.uid)
                              .get();

                          if (!userDoc.data()!.containsKey('address') ||
                              userDoc['address'] == null ||
                              userDoc['address'].toString().isEmpty) {
                            Get.snackbar("Error", "Please add address first");
                            return;
                          }

                          // ✅ OPEN RAZORPAY
                          openCheckout();
                        },
                        child: const Text(
                          "Proceed to Checkout",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget billRow(String title, int price, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(title), Text("₹ $price")],
    );
  }
}
