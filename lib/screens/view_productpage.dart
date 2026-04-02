// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:office_project/screens/updateproductpage.dart';

// class ViewProductpage extends StatefulWidget {
//   final String productId;
//   final DocumentSnapshot productData;
//   const ViewProductpage({
//     super.key,
//     required this.productId,
//     required this.productData,
//   });

//   @override
//   State<ViewProductpage> createState() => _ViewProductpageState();
// }

// class _ViewProductpageState extends State<ViewProductpage> {
//   void _showDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Are you sure want to delete this product?"),

//           actions: [
//             Row(
//               spacing: 15,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                     shape: BeveledRectangleBorder(),
//                   ),
//                   child: Text("No", style: TextStyle(color: Colors.white)),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     deleteProduct(context);
//                     Navigator.pop(context);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     shape: BeveledRectangleBorder(),
//                   ),
//                   child: Text('Yes', style: TextStyle(color: Colors.white)),
//                 ),
//                 // _button("Edit", Colors.green),
//               ],
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void deleteProduct(BuildContext context) async {
//     await FirebaseFirestore.instance
//         .collection('products')
//         .doc(widget.productId)
//         .delete();
//     Navigator.pop(context);
//   }

//   //  void updateProduct(
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.green,
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//         ),
//         title: const Text(
//           "View Product",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('products')
//             .doc(widget.productId)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData || !snapshot.data!.exists) {
//             return const Center(child: Text("Product not found"));
//           }

//           final data = snapshot.data!;

//           return Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 20.0,
//                   vertical: 60,
//                 ),
//                 child: SizedBox(
//                   width: 450,
//                   child: Card(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 30,
//                         horizontal: 20,
//                       ),
//                       child: Column(
//                         children: [
//                           Align(
//                             alignment: Alignment.topRight,
//                             child: InkWell(
//                               onTap: () {
//                                 Get.back();
//                               },
//                               child: Container(
//                                 height: 20,
//                                 width: 20,
//                                 color: Colors.grey,
//                                 child: const Icon(
//                                   Icons.close,
//                                   color: Colors.white,
//                                   size: 15,
//                                 ),
//                               ),
//                             ),
//                           ),

//                           const SizedBox(height: 10),

//                           const Image(
//                             image: AssetImage("assets/v1.jpg"),
//                             height: 100,
//                             width: 100,
//                           ),

//                           const SizedBox(height: 30),

//                           _details("Product Id", data["productId"] ?? "no id"),
//                           _details("Product Name", data['productName']),
//                           _details("Product Categories", data['category']),
//                             _details("Stock", data['stock']),
                         

//                           _details("Exist Only", data["unit"]),
                        
//                           _details("Price", "₹${data['price']}"),
//                            _details("Offers", data['offer'] ?? "no offer"),

//                            _details("Final Price", data['finalPrice'] ?? "0"),
//                           const SizedBox(height: 30),

//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               ElevatedButton(
//                                 onPressed: () {
//                                   _showDialog(context);
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.red,
//                                   shape: BeveledRectangleBorder(),
//                                 ),
//                                 child: const Text(
//                                   "Delete",
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ),

//                               const SizedBox(width: 30),

//                               ElevatedButton(
//                                 onPressed: () async {
//                                   await Get.to(
//                                     () => Updateproductpage(
//                                       productId: widget.productId,
//                                       productData: data,
//                                     ),
//                                   );
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.green,
//                                   shape: BeveledRectangleBorder(),
//                                 ),
//                                 child: const Text(
//                                   'Edit',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Widget _details(String title, dynamic value) {
//     return SizedBox(
//       width: 260,
//       height: 20,
//       // color: Colors.yellow,
//       child: Row(
//         children: [
//           SizedBox(
//             width: 130,
//             // color: Colors.red,
//             child: Text(title),
//           ),
//           Container(
//             alignment: Alignment.center,
//             width: 15,
//             // color: Colors.white,
//             child: Text(":  "),
//           ),
//           Text(value.toString()),
//         ],
//       ),
//     );
//   }
// }
// //   Widget _button(String name, Color color) {
// //     return ElevatedButton(
// //       onPressed: () {},
// //       style: ElevatedButton.styleFrom(
// //         backgroundColor: color,
// //         shape: BeveledRectangleBorder(),
// //       ),
// //       child: Text(name, style: TextStyle(color: Colors.white)),
// //     );
// //   }
// // }


// // import 'package:flutter/material.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';

// // class ProductDetailPage extends StatelessWidget {
// //   final String productId;
// //   final DocumentSnapshot productData;

// //   const ProductDetailPage({
// //     super.key,
// //     required this.productId,
// //     required this.productData,
// //   });

// //   void deleteProduct(BuildContext context) async {
// //     await FirebaseFirestore.instance
// //         .collection('products')
// //         .doc(productId)
// //         .delete();

// //     Navigator.pop(context);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Product Details"),
// //         backgroundColor: Colors.green,
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(20),
// //         child: Column(
// //           children: [
// //             // Image.network(
// //             //   productData['imageUrl'],
// //             //   height: 150,
// //             // ),
// //             const SizedBox(height: 20),

// //             _detail("Name", productData['productName']),
// //             _detail("Category", productData['category']),
// //             _detail("Price", "₹ ${productData['price']}"),
// //             _detail("Stock", productData['stock']),

// //             const SizedBox(height: 40),

// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //               children: [
// //                 ElevatedButton(
// //                   onPressed: () => deleteProduct(context),
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.red,
// //                   ),
// //                   child: const Text("Delete"),
// //                 ),
// //                 ElevatedButton(
// //                   onPressed: () {
// //                     // Navigate to Update Page
// //                   },
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: Colors.green,
// //                   ),
// //                   child: const Text("Update"),
// //                 ),
// //               ],
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _detail(String title, dynamic value) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(vertical: 8),
// //       child: Row(
// //         children: [
// //           Expanded(child: Text(title)),
// //           const Text(": "),
// //           Expanded(child: Text(value.toString())),
// //         ],
// //       ),
// //     );
// //   }
// // }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_project/screens/updateproductpage.dart';

class ViewProductpage extends StatefulWidget {
  final String productId;
  final DocumentSnapshot productData;

  const ViewProductpage({
    super.key,
    required this.productId,
    required this.productData,
  });

  @override
  State<ViewProductpage> createState() => _ViewProductpageState();
}

class _ViewProductpageState extends State<ViewProductpage> {
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Are you sure want to delete this product?"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: const BeveledRectangleBorder(),
                  ),
                  child: const Text("No", style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {
                    deleteProduct(context);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: const BeveledRectangleBorder(),
                  ),
                  child: const Text('Yes', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void deleteProduct(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection('products')
        .doc(widget.productId)
        .delete();
    Navigator.pop(context);
  }

  String formatDate(Timestamp? timestamp) {
    if (timestamp == null) return "";
    final date = timestamp.toDate();
    return "${date.day}-${date.month}-${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          "View Product",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('products')
            .doc(widget.productId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("Product not found"));
          }

          final data = snapshot.data!;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: 40,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 20,
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                height: 20,
                                width: 20,
                                color: Colors.grey,
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          const Image(
                            image: AssetImage("assets/v1.jpg"),
                            height: 100,
                            width: 100,
                          ),

                          const SizedBox(height: 20),

                          _details("Product Id", data["productId"] ?? ""),
                          _details("Product Name", data['productName'] ?? ""),
                          _details("Category", data['category'] ?? ""),

                          // ✅ MULTI-LINE DESCRIPTION SUPPORT
                          _detailsMulti("Description", data['description'] ?? ""),

                          //_details("Tag", data['tag'] ?? ""),
                          _details("Stock", data['stock'] ?? 0),
                          _details("Unit", data["unit"] ?? ""),
                          _details("Price", "₹${data['price'] ?? 0}"),
                          _details("GST", data['tax'] ?? ""),
                          _details("GST %", data['percentage'] ?? ""),
                          _details("Offer", data['offer'] ?? ""),
                          _details("Final Price", data['finalPrice'] ?? 0),

                          _details(
                            "Packing Date",
                            formatDate(data['packingDate']),
                          ),

                          _details(
                            "Created At",
                            formatDate(data['createdAt']),
                          ),

                          const SizedBox(height: 30),

                          Wrap(
                            spacing: 20,
                            runSpacing: 10,
                            alignment: WrapAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  _showDialog(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: const BeveledRectangleBorder(),
                                ),
                                child: const Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await Get.to(
                                    () => Updateproductpage(
                                      productId: widget.productId,
                                      productData: data,
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: const BeveledRectangleBorder(),
                                ),
                                child: const Text(
                                  'Edit',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ✅ NORMAL FIELD
  Widget _details(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: Text(title)),
          const Text(": "),
          Expanded(
            flex: 3,
            child: Text(value.toString()),
          ),
        ],
      ),
    );
  }

  // ✅ MULTI-LINE DESCRIPTION
  Widget _detailsMulti(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: Text(title)),
          const Text(": "),
          Expanded(
            flex: 3,
            child: Text(
              value.toString(),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}