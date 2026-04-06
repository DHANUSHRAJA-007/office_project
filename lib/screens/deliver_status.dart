import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliverStatus extends StatelessWidget {
  final DocumentSnapshot order;

   DeliverStatus({super.key, required this.order});
Future<void> updateStock(List items) async {
  for (var item in items) {
    final productId = item['productId'];
    final qty = int.tryParse(item['quantity'].toString()) ?? 1;

    if (productId == null) continue;

    final ref = FirebaseFirestore.instance
        .collection('products')
        .doc(productId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snap = await transaction.get(ref);

      if (!snap.exists) return;

      final currentStock = snap['stock'] ?? 0;

      transaction.update(ref, {
        'stock': currentStock + qty, // 🔺 INCREASE
      });
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
        title:  Text(
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
                     // const SizedBox(width: 10),
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

               SizedBox(height: 12),

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
                       Text(
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
                          //const SizedBox(width: 8),
                          Text(data['buyerName'] ?? "Unknown"),
                        ],
                      ),

                       SizedBox(height: 6),

                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 18),
                         // const SizedBox(width: 8),
                          Expanded(child: Text(data['buyerAddress'] ?? "")),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

               SizedBox(height: 12),

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
                       Text(
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

                              //const SizedBox(width: 10),

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

               SizedBox(height: 12),

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
                       Text(
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

               SizedBox(height: 20),

              /// 🔥 BUTTON
              //const SizedBox(height: 20),

//               GridView.count(
//                 crossAxisCount: 2, // 2 buttons per row
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 childAspectRatio: 4.5,

// <<<<<<< HEAD
// //                 children: [
// //                   /// ✅ DELIVER BUTTON
// //                   SizedBox(
// //                     height: 50,
// //                     width: double.infinity,
// //                     child: ElevatedButton(
// //                       onPressed: () async {
// //                         await FirebaseFirestore.instance
// //                             .collection('orders')
// //                             .doc(order.id)
// //                             .update({'status': 'returned'});
// =======
//                         Get.back();
//                         Get.snackbar("Success", "Order returned");
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.grey,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: const Text(
//                         "Return",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
// >>>>>>> origin/dhanush

// //                         Get.back();
// //                         Get.snackbar("Success", "Order returned");
// //                       },
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: Colors.green,
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(12),
// //                         ),
// //                       ),
// //                       child: const Text(
// //                         "Return",
// //                         style: TextStyle(
// //                           color: Colors.white,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                     ),
// //                   ),

// <<<<<<< HEAD
// //                   /// 🔄 OPTIONAL: ACCEPT BUTTON
// //                   ElevatedButton(
// //                     onPressed: () async {
// //                       await FirebaseFirestore.instance
// //                           .collection('orders')
// //                           .doc(order.id)

//                       Get.back();
//                       Get.snackbar("Success", "Order Accepted");
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text(
//                       "Accept",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),

//                       Get.back();
//                       Get.snackbar("Success", "Order Accepted");
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.orange,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text(
//                       "Accept",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),

//                   /// ❌ REJECT BUTTON
//                   ElevatedButton(
//                    onPressed: () async {
//   final docRef = FirebaseFirestore.instance
//       .collection('orders')
//       .doc(order.id);

//   final freshDoc = await docRef.get();
//   final data = freshDoc.data() as Map<String, dynamic>;

//   final items = data['items'];

//   await updateStock(items); // 🔺 INCREASE STOCK

//   await docRef.update({'status': 'rejected'});

//   Get.back();
//   Get.snackbar("Success", "Order Rejected");
// },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text(
//                       "Reject",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),

//                   /// ⏳ OPTIONAL: PENDING BUTTON
//                   ElevatedButton(
//                     onPressed: () async {
//                       await FirebaseFirestore.instance
//                           .collection('orders')
//                           .doc(order.id)
//                           .update({'status': 'pending'});

//                       Get.back();
//                       Get.snackbar("Success", "Marked as Pending");
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.orange,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text(
//                       "Pending",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
GridView.count(
  crossAxisCount: 2,
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  crossAxisSpacing: 10,
  mainAxisSpacing: 10,
  childAspectRatio: 4.5,
  children: [

    /// 🟢 RETURN
    ElevatedButton(
      onPressed: () async {
        final docRef = FirebaseFirestore.instance
            .collection('orders')
            .doc(order.id);

        final freshDoc = await docRef.get();
        final data = freshDoc.data() as Map<String, dynamic>;

        await updateStock(data['items']); // 🔺 increase

        await docRef.update({'status': 'returned'});

        Get.back();
        Get.snackbar("Success", "Order Returned");
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text("Return",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    ),

    /// 🟡 ACCEPT
    ElevatedButton(
      onPressed: () async {
        final docRef = FirebaseFirestore.instance
            .collection('orders')
            .doc(order.id);

        final freshDoc = await docRef.get();
        final data = freshDoc.data() as Map<String, dynamic>;

        await updateStock(data['items']); // 🔺 increase

        await docRef.update({'status': 'accepted'});

        Get.back();
        Get.snackbar("Success", "Order Accepted");
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text("Accept",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    ),

    /// 🔴 REJECT
    ElevatedButton(
      onPressed: () async {
        final docRef = FirebaseFirestore.instance
            .collection('orders')
            .doc(order.id);

        final freshDoc = await docRef.get();
        final data = freshDoc.data() as Map<String, dynamic>;

        await updateStock(data['items']); // 🔺 increase

        await docRef.update({'status': 'rejected'});

        Get.back();
        Get.snackbar("Success", "Order Rejected");
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text("Reject",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    ),

    /// 🟠 PENDING
    ElevatedButton(
      onPressed: () async {
        final docRef = FirebaseFirestore.instance
            .collection('orders')
            .doc(order.id);

        final freshDoc = await docRef.get();
        final data = freshDoc.data() as Map<String, dynamic>;

        await updateStock(data['items']); // 🔺 increase

        await docRef.update({'status': 'pending'});

        Get.back();
        Get.snackbar("Success", "Marked as Pending");
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text("Pending",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
