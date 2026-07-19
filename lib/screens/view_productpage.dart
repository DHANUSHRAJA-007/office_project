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