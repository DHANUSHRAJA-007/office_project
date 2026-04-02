// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:office_project/screens/acceptorderpage.dart';
// import 'package:office_project/widgets/vieworder_card.dart';

// class PendingOrders extends StatelessWidget {
//   const PendingOrders({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('orders')
//             .where('status', isEqualTo: 'pending')
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           final orders = snapshot.data!.docs;

//           if (orders.isEmpty) {
//             return const Center(child: Text("No Pending Orders"));
//           }

//           return ListView.builder(
//             itemCount: orders.length,
//             itemBuilder: (context, index) {
//               final order = orders[index];

//               return InkWell(
//                 onTap: () {
//                   Get.to(() => Acceptorderpage(order: order));
//                 },

//                 child: VieworderCard(
//                   orderId: order.id,
//                   buyerName: order['buyerName'] ?? "Unknown",
//                   total: order['total'],
//                   status: order['status'],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_project/screens/acceptorderpage.dart';
import 'package:office_project/widgets/vieworder_card.dart';

class PendingOrders extends StatelessWidget {
  const PendingOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .where('status', isEqualTo: 'pending')
          .snapshots(),
      builder: (context, snapshot) {
        /// 🔄 LOADING
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        /// ❌ ERROR
        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        }

        final orders = snapshot.data!.docs;

        /// 📭 EMPTY STATE
        if (orders.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inbox, size: 60, color: Colors.grey[400]),
                const SizedBox(height: 10),
                const Text("No Pending Orders", style: TextStyle(fontSize: 16)),
              ],
            ),
          );
        }

        /// 📦 LIST
        return RefreshIndicator(
          onRefresh: () async {
            // Firestore auto updates, so just delay for UX
            await Future.delayed(const Duration(milliseconds: 500));
          },
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    final order = orders[index];

                    print("Clicked Order ID: ${order.id}");

                    Get.to(() => Acceptorderpage(order: order));
                  },
                  child: SizedBox(
                    width: double.infinity, // 🔥 IMPORTANT
                    child: VieworderCard(
                      orderId: order.id,
                      buyerName: order['buyerName'] ?? "Unknown",
                      total: order['total'],
                      status: order['status'],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
