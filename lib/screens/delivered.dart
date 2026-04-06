// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class Delivered extends StatelessWidget {
//   final DocumentSnapshot order;

//   const Delivered({super.key, required this.order});

//   @override
//   Widget build(BuildContext context) {

//     /// ✅ GET DATA HERE
//     final data = order.data() as Map<String, dynamic>;

//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//          leading: IconButton(
//           onPressed: () => Get.back(),
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//         ),
//         centerTitle: true,
//         title: const Text("Order Details",style: TextStyle(
//           color: Colors.white
//         ),),
//         backgroundColor: Colors.green,
//       ),

//       body: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//           children: [

//             /// 🟢 ORDER ID
//             Text("Order ID: ${order.id}",
//                 style: const TextStyle(fontWeight: FontWeight.bold)),

//             const SizedBox(height: 10),

//             /// 🟢 BUYER DETAILS
//             Text("Buyer: ${data['buyerName'] ?? "Unknown"}"),
//             Text("Address: ${data['buyerAddress'] ?? ""}"),

//             const SizedBox(height: 10),

//             /// 🟢 PRODUCTS
//             const Text("Products:",
//                 style: TextStyle(fontWeight: FontWeight.bold)),

//             ...List.generate(
//               (data['items'] as List).length,
//               (index) {
//                 final item = data['items'][index];

//                 return ListTile(
//                   title: Text(item['name']),
//                   subtitle: Text("Qty: ${item['quantity']}"),
//                   trailing: Text("₹ ${item['price']}"),
//                 );
//               },
//             ),

//             const SizedBox(height: 10),

//             /// 🟢 TOTAL
//             Text("Total: ₹${data['total']}",
//                 style: const TextStyle(fontWeight: FontWeight.bold)),

//             const Spacer(),

//             /// 🔥 DELIVER BUTTON (ONLY HERE)
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () async {
//                   await FirebaseFirestore.instance
//                       .collection('orders')
//                       .doc(order.id)
//                       .update({
//                     'status': 'delivered',
//                   });

//                   Get.back(); // go back to list

//                   Get.snackbar("Success", "Order Delivered");
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                   padding: const EdgeInsets.all(14),
//                 ),
//                 child: const Text(
//                   "Mark as Delivered",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Delivered extends StatelessWidget {
  final DocumentSnapshot order;

  const Delivered({super.key, required this.order});

Future<void> updateStock(List items, bool decrease) async {
  for (var item in items) {
    final productId = item['productId'];

    // ✅ FIX HERE
    final qty = int.tryParse(item['quantity'].toString()) ?? 1;

    print("👉 ProductId: $productId | Qty: $qty");

    if (productId == null) {
      print("❌ productId missing");
      continue;
    }

    final ref = FirebaseFirestore.instance
        .collection('products')
        .doc(productId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snap = await transaction.get(ref);

      if (!snap.exists) {
        print("❌ Product not found for ID: $productId");
        return;
      }

      final currentStock = snap['stock'] ?? 0;

      final newStock = decrease
          ? currentStock - qty
          : currentStock + qty;

      print("Old: $currentStock → New: $newStock");

      transaction.update(ref, {'stock': newStock});
    });
  }
}
  @override
  Widget build(BuildContext context) {
    final data = order.data() as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
        title: const Text(
          "Order Details",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🟢 ORDER ID CARD
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Icon(Icons.receipt, color: Colors.green),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Order ID: ${order.id}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              /// 🟢 BUYER DETAILS CARD
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Buyer Details",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Divider(),

                      Row(
                        children: [
                          const Icon(Icons.person, size: 18),
                          const SizedBox(width: 8),
                          Text(data['buyerName'] ?? "Unknown"),
                        ],
                      ),

                      const SizedBox(height: 6),

                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 18),
                          const SizedBox(width: 8),
                          Expanded(child: Text(data['buyerAddress'] ?? "")),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              /// 🟢 PRODUCTS CARD
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Products",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      const Divider(),

                      ...List.generate((data['items'] as List).length, (index) {
                        final item = data['items'][index];

                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.shopping_bag,
                                color: Colors.green,
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text("Qty: ${item['quantity']}"),
                                  ],
                                ),
                              ),

                              Text(
                                "₹ ${item['price']}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              /// 🟢 TOTAL CARD
              Card(
                color: Colors.green.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Amount",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "₹${data['total']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// 🔥 BUTTON
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  // onPressed: () async {
                  //   await FirebaseFirestore.instance
                  //       .collection('orders')
                  //       .doc(order.id)
                  //       .update({'status': 'delivered'});

                  //   Get.back();
                  //   Get.snackbar("Success", "Order Delivered");
                  // },
    
onPressed: () async {
  final docRef = FirebaseFirestore.instance
      .collection('orders')
      .doc(order.id);

  final freshDoc = await docRef.get(); // ✅ GET LATEST DATA
  final freshData = freshDoc.data() as Map<String, dynamic>;

  final items = freshData['items'];
  final currentStatus = freshData['status'];

  try {
    if (currentStatus != 'delivered') {
      await updateStock(items, true); // 🔻 decrease
    }

    await docRef.update({'status': 'delivered'});

    Get.back();
    Get.snackbar("Success", "Order Delivered");
  } catch (e) {
    print(e);
  }
},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Mark as Deliver",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2, // 2 buttons per row
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 4.5,

                children: [
                  /// ✅ DELIVER BUTTON

                  /// ❌ REJECT BUTTON
                  ElevatedButton(
            onPressed: () async {
  final docRef = FirebaseFirestore.instance
      .collection('orders')
      .doc(order.id);

  final freshDoc = await docRef.get();
  final freshData = freshDoc.data() as Map<String, dynamic>;

  final items = freshData['items'];
  final currentStatus = freshData['status'];

  try {
    if (currentStatus == 'delivered') {
      await updateStock(items, false); // 🔺 ADD BACK
    }

    await docRef.update({'status': 'rejected'});

    Get.back();
    Get.snackbar("Updated", "Order Rejected");
  } catch (e) {
    print(e);
  }
},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Reject",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  /// 🔄 OPTIONAL: ACCEPT BUTTON
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     await FirebaseFirestore.instance
                  //         .collection('orders')
                  //         .doc(order.id)
                  //         .update({'status': 'accepted'});

                  //     Get.back();
                  //     Get.snackbar("Success", "Order Accepted");
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.orange,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //   ),
                  //   child: const Text(
                  //     "Accept",
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),

                  /// ⏳ OPTIONAL: PENDING BUTTON
                  ElevatedButton(
               onPressed: () async {
  final docRef = FirebaseFirestore.instance
      .collection('orders')
      .doc(order.id);

  final freshDoc = await docRef.get();
  final freshData = freshDoc.data() as Map<String, dynamic>;

  final items = freshData['items'];
  final currentStatus = freshData['status'];

  try {
    if (currentStatus == 'delivered') {
      await updateStock(items, false); // 🔺 ADD BACK
    }

    await docRef.update({'status': 'pending'});

    Get.back();
    Get.snackbar("Updated", "Marked as Pending");
  } catch (e) {
    print(e);
  }
},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Pending",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
