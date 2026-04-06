import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConfirmedOrdersPage extends StatefulWidget {
  const ConfirmedOrdersPage({super.key});

  @override
  State<ConfirmedOrdersPage> createState() => _ConfirmedOrdersPageState();
}

class _ConfirmedOrdersPageState extends State<ConfirmedOrdersPage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    Color getStatusColor(String status) {
      switch (status) {
        case 'accepted':
          return Colors.green;
        case 'shipped':
          return Colors.blue;
        case 'pending':
          return Colors.orange;
        default:
          return Colors.grey;
      }
    }

    String getStatusText(String status) {
      switch (status) {
        case 'pending':
          return 'Ready for Shipment';
        case 'accepted':
          return 'Product Shipped';
        case 'shipped':
          return 'Shipped';
        default:
          return status;
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "My Orders",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('buyerId', isEqualTo: user!.uid)
            .where(
              'status',
              whereIn: ['accepted', 'shipped', 'pending'],
            ) // 🔥 IMPORTANT
            //  .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final orders = snapshot.data!.docs;

          if (orders.isEmpty) {
            return const Center(child: Text("No confirmed orders"));
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text("Order #${order.id}"),
                  subtitle: Text("₹ ${order['total']}"),

                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: getStatusColor(order['status']),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      getStatusText(order['status']),
                      // order['status'],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
