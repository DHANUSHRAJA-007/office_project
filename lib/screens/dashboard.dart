import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_project/recent_orderpage.dart';
import 'package:office_project/widgets/drawerbox.dart';

class Dashboard extends StatefulWidget {
  final Function(String status) onNavigateToOrders;

  const Dashboard({super.key, required this.onNavigateToOrders});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawerbox(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 HEADER
              Container(
                height: 80,
                decoration: const BoxDecoration(
                  color: Color(0xff4CAF50),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Builder(
                    //   builder: (context) => IconButton(
                    //     icon: const Icon(
                    //       Icons.sort,
                    //       color: Colors.white,
                    //       size: 28,
                    //     ),
                    //     onPressed: () {
                    //       Scaffold.of(context).openDrawer();
                    //     },
                    //   ),
                    // ),
                    const Text(
                      "AASHAI",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: const Icon(
                    //     Icons.notifications_outlined,
                    //     size: 28,
                    //     color: Colors.white,
                    //   ),
                    // ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// 🔹 DASHBOARD CARDS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('orders')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final orders = snapshot.data!.docs;

                    int pending = 0;
                    int accepted = 0;
                    int shipped = 0;
                    int rejected = 0;

                    for (var order in orders) {
                      String status = order['status'] ?? '';

                      if (status == 'pending') pending++;
                      if (status == 'accepted') accepted++;
                      if (status == 'shipped') shipped++;
                      if (status == 'rejected') rejected++;
                    }

                    return GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.6,
                      children: [
                        _dashCards(
                          const Color(0xFFFBD099),
                          "New Orders",
                          "$pending",
                          Icons.description_outlined,
                          "pending",
                        ),

                        _dashCards(
                          const Color(0xFFA0D29E),
                          "Accepted",
                          "$accepted",
                          Icons.check_circle_outline,
                          "accepted",
                        ),
                        _dashCards(
                          const Color(0xFFBCBFFB),
                          "Shipped",
                          "$shipped",
                          Icons.local_shipping_outlined,
                          "shipped",
                        ),
                        _dashCards(
                          const Color(0xFFFCD1D2),
                          "Cancelled",
                          "$rejected",
                          Icons.cancel_outlined,
                          "rejected",
                        ),
                      ],
                    );
                  },
                ),
                // LayoutBuilder(
                //     builder: (context, constraints) {
                //       int crossAxisCount =
                //           constraints.maxWidth > 600 ? 4 : 2;

                //       return GridView.count(
                //         crossAxisCount: crossAxisCount,
                //         shrinkWrap: true,
                //         physics: const NeverScrollableScrollPhysics(),
                //         mainAxisSpacing: 12,
                //         crossAxisSpacing: 12,
                //         childAspectRatio: 1.6,
                //         children: [
                //           _dashCards(
                //               const Color(0xFFFBD099),
                //               "New Orders",
                //               "70",
                //               Icons.description_outlined),
                //           _dashCards(
                //               const Color(0xFFA0D29E),
                //               "Total Sales",
                //               "150",
                //               Icons.currency_rupee),
                //           _dashCards(
                //               const Color(0xFFFCD1D2),
                //               "Product Stock",
                //               "300",
                //               Icons.inventory_2_outlined),
                //           _dashCards(
                //               const Color(0xFFBCBFFB),
                //               "Low Stock Alerts",
                //               "10",
                //               Icons.move_to_inbox_outlined),
                //         ],
                //       );
                //     },
                //   ),
              ),

              const SizedBox(height: 30),

              /// 🔹 RECENT ORDERS HEADER
              _sectionHeader("Recent Orders"),

              const SizedBox(height: 10),

              /// 🔹 RECENT ORDERS LIST
              // _recents("Sara", "#12345", "Delivered"),
              // const Divider(),
              // _recents("John", "#12346", "Pending"),
              // const Divider(),
              // _recents("David", "#12347", "Delivered"),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('orders')
                    .orderBy('timestamp', descending: true)
                    .limit(5)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final orders = snapshot.data!.docs;

                  if (orders.isEmpty) {
                    return const Center(child: Text("No Orders"));
                  }

                  return Column(
                    children: orders.map((order) {
                      final data = order.data() as Map<String, dynamic>;

                      return Column(
                        children: [
                          _recents(
                            data['buyerName'] ?? "Unknown",
                            order.id,
                            data['status'] ?? "pending",
                          ),
                          const Divider(),
                        ],
                      );
                    }).toList(),
                  );
                },
              ),

              const SizedBox(height: 30),

              /// 🔹 PRODUCT CATEGORY HEADER
              // _sectionHeader("Product Categories"),

              // const SizedBox(height: 10),

              // /// 🔹 CATEGORY GRID
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16),
              //   child: LayoutBuilder(
              //     builder: (context, constraints) {
              //       int crossAxisCount = constraints.maxWidth > 600 ? 6 : 4;

              //       return GridView.builder(
              //         shrinkWrap: true,
              //         physics: const NeverScrollableScrollPhysics(),
              //         itemCount: 8,
              //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //           crossAxisCount: crossAxisCount,
              //           mainAxisSpacing: 12,
              //           crossAxisSpacing: 12,
              //           childAspectRatio: 0.8,
              //         ),
              //         itemBuilder: (context, index) {
              //           return _categoryBox("Vegetables", "assets/v1.jpg");
              //         },
              //       );
              //     },
              //   ),
              // ),

              // const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 DASHBOARD CARD
  Widget _dashCards(
    Color color,
    String title,
    String value,
    IconData icon,
    String route,
  ) {
    return InkWell(
      onTap: () {
        widget.onNavigateToOrders(route);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color,
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Icon(icon, color: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 SECTION HEADER
  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          TextButton(
            onPressed: () {
              Get.to(RecentOrderpage());
            },
            child: const Text(
              "View All",
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 RECENT ORDER ITEM
  Widget _recents(String name, String id, String status) {
    Color getStatusColor(String status) {
      switch (status) {
        case 'pending':
          return Colors.orange;
        case 'accepted':
          return Colors.green;
        case 'shipped':
          return Colors.blue;
        case 'rejected':
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const CircleAvatar(radius: 25),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text("Order id : $id", style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: getStatusColor(status),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(status, style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  /// 🔹 CATEGORY BOX
  Widget _categoryBox(String name, String image) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(name, overflow: TextOverflow.ellipsis),
      ],
    );
  }
}
