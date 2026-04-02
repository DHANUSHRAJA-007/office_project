// import 'package:flutter/material.dart';
// import 'package:get/get_navigation/src/routes/default_transitions.dart';
// class Acceptorderpage extends StatelessWidget {
//   const Acceptorderpage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back,color: Colors.white),),
//         title: Text("Accept Order",style: TextStyle(color: Colors.white),),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListView(
//           scrollDirection: Axis.vertical,
//           children: [
//             Card(
//                 elevation: 3,
//               // color: Colors.grey,
//               child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Order ID: 123456",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,)
//                   ),
//                   Divider(color: Colors.grey, thickness: 1),
//                   Row(children: [
//                     SizedBox(child: CircleAvatar()),
//                     SizedBox(width: 10,),

//                     SizedBox(
//                       child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Emily Davis"),
//                           Text("+1 234 567 890"),
//                           Text("452 Maple Street, Springfield"),
//                         ],
//                       ),
//                     ),
//                   ],)

//                 ],
//               ),
//             ),
//                         SizedBox(height: 20,),
//             Card(
//              elevation: 3,
//               child: Column(
//               children: [
//                 Container(
//                   width: double.infinity,
//                    color: Colors.grey[300],
//                    child: Text("Product for delivery",
//                    textAlign: TextAlign.left,
//                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),),
//                 ),
//                 Row(
//                   children: [
//                     SizedBox(
//                       child:CircleAvatar()

//                     ),SizedBox(width: 10,),
//                     Column(crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Product Name"),
//                         Text("Grocery Hub"),
//                         Text("Price: \$50.00/2kg"),
//                       ],
//                     )
//                   ],
//                 ),
//                 Divider(color: Colors.grey, thickness: 1),
//                  Row(
//                   children: [
//                     SizedBox(
//                       child: CircleAvatar()

//                     ),SizedBox(width: 10,),
//                     Column(crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Product Name"),
//                         Text("Grocery Hub"),
//                         Text("Price: \$50.00/2kg"),
//                       ],
//                     )
//                   ],
//                 ),

//               ],
//             ),
//             ),
//             SizedBox(height: 20,),
//             Card(
//               elevation: 3,
//               child: Column(
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     color: Colors.grey[300],
//                     child: Text("Buyer Details",
//                     textAlign: TextAlign.left,
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),),
//                   ),
//                   Row(
//                     children: [
//                       SizedBox(
//                         child: CircleAvatar()

//                       ),SizedBox(width: 10,),
//                       Column(crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Emily Davis"),
//                           // Text("+1 234 567 890"),
//                           Text("452 Maple Street, Springfield \n bangalore"),
//                         ],
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             Card(
//               elevation: 3,
//               child: Column(
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     color: Colors.grey[300],
//                     child: Text("Special Instructions",
//                     textAlign: TextAlign.left,
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [

//                       Column(crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Please deliver between 5-6 PM."),
//                           Text("Leave the package at the front door if no one is home."),
//                           Divider(color: Colors.grey, thickness: 2),
//                           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                              SizedBox(child: Text("total Amount",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),

//                              SizedBox(child: Text(  "\$100.00",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
//                         ],
//                       )

//                     ],
//                   )
//                 ],
//               ),]
//             )

//             ),
//             SizedBox(height: 20,),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                       ElevatedButton(
//               onPressed: (){},
//               child: Text("Reject", style: TextStyle(color: Colors.white)),
//               style: ElevatedButton.styleFrom(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),fixedSize: Size(160, 40),
//               backgroundColor: Colors.red,

//             ),),
//             ElevatedButton(
//               onPressed: (){},
//                child: Text("Accept Order",style: TextStyle(color: Colors.white),),
//                style: ElevatedButton.styleFrom(
//                 shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),fixedSize: Size(160, 40),
//               backgroundColor: Colors.green,

//             ),)
//             ],)

//           ],
//         ),
//       ),
//     );
//   }
// // }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:office_project/widgets/buyercard.dart';
// import 'package:office_project/widgets/buyerinstructioncard.dart';
// import 'package:office_project/widgets/ordercard.dart';
// import 'package:office_project/widgets/productcard.dart';

// class Acceptorderpage extends StatelessWidget {
//   final DocumentSnapshot order;
//   const Acceptorderpage({super.key, required this.order});

//   @override
//   Widget build(BuildContext context) {
//     final data = order.data() as Map<String, dynamic>;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         centerTitle: true,
//         title: const Text(
//           "Accept Order",
//           style: TextStyle(color: Colors.white),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//         ),
//       ),

//       // body: SafeArea(
//       //   child: Padding(
//       //     padding: const EdgeInsets.all(12),
//       //     child: Column(
//       //       children: [
//       //         /// Scrollable Content
//       //         Expanded(
//       //           child: ListView(
//       //             children: [

//       //               /// ORDER CARD
//       //               ordercard(),

//       //               const SizedBox(height: 16),

//       //               Productcard(),

//       //               const SizedBox(height: 16),

//       //               /// BUYER DETAILS
//       //               Buyercard(),

//       //               const SizedBox(height: 16),

//       //               /// SPECIAL INSTRUCTIONS
//       //             Buyerinstructioncard()
//       //             ],
//       //           ),
//       //         ),

//       //         const SizedBox(height: 10),

//       //         /// BUTTONS
//       //         Row(
//       //           children: [
//       //             Expanded(
//       //               child: ElevatedButton(
//       //                 onPressed: () {},
//       //                 style: ElevatedButton.styleFrom(
//       //                   backgroundColor: Colors.red,
//       //                   padding: const EdgeInsets.symmetric(vertical: 14),
//       //                   shape: RoundedRectangleBorder(
//       //                     borderRadius: BorderRadius.circular(8),
//       //                   ),
//       //                 ),
//       //                 child: const Text("Reject",style: TextStyle(color: Colors.white),),
//       //               ),
//       //             ),
//       //             const SizedBox(width: 12),
//       //             Expanded(
//       //               child: ElevatedButton(
//       //                 onPressed: () {},
//       //                 style: ElevatedButton.styleFrom(
//       //                   shape: RoundedRectangleBorder(
//       //                     borderRadius: BorderRadius.circular(8),
//       //                   ),
//       //                   backgroundColor: Colors.green,
//       //                   padding: const EdgeInsets.symmetric(vertical: 14),
//       //                 ),
//       //                 child: const Text("Accept Order",style: TextStyle(color: Colors.white),),
//       //               ),
//       //             ),
//       //           ],
//       //         )
//       //       ],
//       //     ),
//       //   ),
//       // ),
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
//             return const Center(child: Text("No pending orders"));
//           }

//           return ListView.builder(
//             padding: const EdgeInsets.all(12),
//             itemCount: orders.length,
//             itemBuilder: (context, index) {
//               final order = orders[index];
//               final data = order.data() as Map<String, dynamic>;

//               return Container(
//                 margin: const EdgeInsets.only(bottom: 16),
//                 child: Column(
//                   children: [
//                     /// ORDER ID + SELLER
//                     _sectionCard(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Order ID : #${order.id}",
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           const Divider(),

//                           Row(
//                             children: [
//                               const CircleAvatar(
//                                 radius: 25,
//                                 backgroundImage: NetworkImage('assets/v1.jpg'),
//                               ),
//                               const SizedBox(width: 10),

//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   // Text(order['sellerName'] ?? "Seller"),
//                                   // Text(order['phone'] ?? ""),
//                                   // Text(order['address'] ?? ""),
//                                   Text("Seller name"),
//                                   Text("Phone"),
//                                   Text("Seller address"),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 12),

//                     /// PRODUCTS
//                     _sectionTitle("Products for Delivery"),
//                     _sectionCard(
//                       child: Column(
//                         children: List.generate((order['items'] as List).length, (
//                           i,
//                         ) {
//                           final item = order['items'][i];
//                           return Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   const CircleAvatar(
//                                     backgroundImage: NetworkImage(
//                                       'assets/v1.jpg',
//                                     ),
//                                   ),
//                                   const SizedBox(width: 10),

//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(item['name']),
//                                         Text("Grocery Hub"),
//                                         Text(
//                                           "₹ ${item['price']} / ${item['quantity']}",
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const Divider(),
//                             ],
//                           );
//                         }),
//                       ),
//                     ),

//                     const SizedBox(height: 12),

//                     /// BUYER DETAILS
//                     _sectionTitle("Buyer Details"),
//                     _sectionCard(
//                       child: Row(
//                         children: [
//                           const CircleAvatar(
//                             radius: 25,
//                             backgroundImage: NetworkImage("assets/v1.jpg"),
//                           ),
//                           const SizedBox(width: 10),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(data['buyerName'] ?? "Buyer"),
//                               Text(data['buyerAddress'] ?? "no address"),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 12),

//                     /// INSTRUCTIONS + TOTAL
//                     _sectionTitle("Special Instructions"),
//                     _sectionCard(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Text(
//                           //   /order['instructions'] ?? "No instructions provided",
//                           // ),
//                           const Divider(),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text(
//                                 "Total Amount",
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 "₹ ${order['total']}",
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(height: 12),

//                     /// BUTTONS
//                     Row(
//                       children: [
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: () {
//                               FirebaseFirestore.instance
//                                   .collection('orders')
//                                   .doc(order.id)
//                                   .update({'status': 'rejected'});
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.red,
//                               padding: const EdgeInsets.symmetric(vertical: 14),
//                             ),
//                             child: const Text(
//                               "Reject",
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: () async {
//                               await FirebaseFirestore.instance
//                                   .collection('orders')
//                                   .doc(order.id)
//                                   .update({'status': 'accepted'});

//                               Get.back();
//                               Get.snackbar("Success", "Order Accepted");
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.green,
//                               padding: const EdgeInsets.symmetric(vertical: 14),
//                             ),
//                             child: const Text(
//                               "Accept & Deliver",
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   Widget _sectionCard({required Widget child}) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.shade300,
//             blurRadius: 5,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: child,
//     );
//   }

//   Widget _sectionTitle(String title) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.green.shade100,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Text(
//         title,
//         style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//       ),
//     );
//   }
// }import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Acceptorderpage extends StatelessWidget {
  final DocumentSnapshot order;

  const Acceptorderpage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final data = order.data() as Map<String, dynamic>;
    List items = data['items'] ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          "Accept Order",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              /// 🔥 SCROLL AREA
              Expanded(
                child: ListView(
                  children: [
                    _sectionTitle("Order ID : #${order.id}"),
                    _sectionCard(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage('assets/v1.jpg'),
                          ),
                          const SizedBox(width: 10),

                          /// ✅ FIXED OVERFLOW
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Seller name",
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text("Phone", overflow: TextOverflow.ellipsis),
                                SizedBox(height: 4),
                                Text(
                                  "Seller address",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// 🔥 PRODUCTS
                    _sectionTitle("Products for Delivery"),
                    _sectionCard(
                      child: Column(
                        children: List.generate(items.length, (i) {
                          final item = items[i];
                          int price =
                              int.tryParse(item['price'].toString()) ?? 0;
                          int quantity = item['quantity'] ?? 1;
                          int total = price * quantity;

                          return Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CircleAvatar(
                                    backgroundImage: AssetImage(
                                      'assets/v1.jpg',
                                    ),
                                  ),
                                  const SizedBox(width: 10),

                                  /// ✅ FIXED TEXT OVERFLOW
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['name'] ?? "",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        const Text("Grocery Hub"),
                                        const SizedBox(height: 4),
                                        Text(
                                          "₹ $price x $quantity = ₹ $total",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(),
                            ],
                          );
                        }),
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// 🔥 BUYER DETAILS
                    _sectionTitle("Buyer Details"),
                    _sectionCard(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage("assets/v1.jpg"),
                          ),
                          const SizedBox(width: 10),

                          /// ✅ FIXED OVERFLOW
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['buyerName'] ?? "Buyer",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  data['buyerAddress'] ?? "No address",
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// 🔥 TOTAL
                    _sectionTitle("Order Summary"),
                    _sectionCard(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Amount",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Flexible(
                            child: Text(
                              "₹ ${data['total']}",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// 🔥 BUTTONS (SAFE)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('orders')
                            .doc(order.id)
                            .update({'status': 'rejected'});

                        Get.back();
                        Get.snackbar("Rejected", "Order Rejected");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Reject",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('orders')
                            .doc(order.id)
                            .update({'status': 'accepted'});

                        Get.back();
                        Get.snackbar("Success", "Order Accepted");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Accept & Deliver",
                        style: TextStyle(color: Colors.white),
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
  }

  /// 🔥 CARD
  Widget _sectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  /// 🔥 TITLE
  Widget _sectionTitle(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
