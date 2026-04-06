import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_project/screens/deliver_status.dart';
import 'package:office_project/widgets/vieworder_card.dart';

class DeliveredPage extends StatelessWidget {
  const DeliveredPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('status', isEqualTo: 'shipped')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final orders = snapshot.data!.docs;

          if (orders.isEmpty) {
            return const Center(child: Text("No Shipped Orders"));
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];

              return InkWell(
                onTap: () {
                  Get.to(() => DeliverStatus(order: order));
                },

                child: VieworderCard(
                  orderId: order.id,
                  buyerName: order['buyerName'] ?? "Unknown",
                  total: order['total'],
                  status: order['status'],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
