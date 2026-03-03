import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Updateproductpage extends StatefulWidget {
  final String productId;
  final DocumentSnapshot productData;
  const Updateproductpage({super.key, required this.productId, required this.productData});

  @override
  State<Updateproductpage> createState() => _UpdateproductpageState();
}

class _UpdateproductpageState extends State<Updateproductpage> {
  int count = 0;

  final List<String> items = ["1 unit", "2 unit", "3 unit"];
  final List<String> categories = [
    "Fruits",
    "Juice",
    "Vegetable",
    "ProteinPowder",
  ];
  final List<String> offers = ["25 %", "50 %", "75 %", "no offers"];
  late String selectedUnit;
  late String selectedOffer;
  DateTime? selectedDate;
  String? selectedItem;
  final TextEditingController productIdController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  final ExpansionTileController _controller = ExpansionTileController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController taxController = TextEditingController();
  final TextEditingController percentageController = TextEditingController();
  final TextEditingController offerController = TextEditingController();

  Future<void> updateProduct() async {
  try {
    await FirebaseFirestore.instance
        .collection('products')
        .doc(widget.productId)
        .update({
      'productId': productIdController.text.trim(),
      'productName': productNameController.text.trim(),
      'category': selectedItem ?? "",
      'description': descriptionController.text.trim(),
      'tag': tagController.text.trim(),
      'price': double.tryParse(priceController.text) ?? 0,
      'tax': taxController.text.trim(),
      'offer': selectedOffer,
      'stock': count,
      'unit': selectedUnit,
      'packingDate': selectedDate ?? DateTime.now(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Product Updated Successfully")),
    );

    Get.back(result: true); // go back after update
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e")),
    );
  }
}

  @override
  void initState() {
    super.initState();
    selectedOffer = offers.first;
    selectedUnit = items.first;
    final data = widget.productData;

  productIdController.text = data['productId'] ?? "";
  productNameController.text = data['productName'] ?? "";
  priceController.text = data['price'].toString();
  descriptionController.text = data['description'] ?? "";
  tagController.text = data['tag'] ?? "";
  taxController.text = data['tax'] ?? "";

  selectedItem = data['category'];
  selectedUnit = items.contains(data['unit'])
    ? data['unit']
    : items.first;

selectedOffer = offers.contains(data['offer'])
    ? data['offer']
    : offers.first;
  count = data['stock'] ?? 0;
  }

  

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        title: const Text(
          "Update Product",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 90,
              width: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  image: AssetImage("assets/one.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),

            buildTextField("Product ID", controller: productIdController),
            buildTextField("Product Name", controller: productNameController),

            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Product Categories"),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ExpansionTile(
                      controller: _controller,
                      tilePadding: const EdgeInsets.symmetric(horizontal: 12),
                      title: Text(
                        selectedItem ?? "Select Category",
                        style: TextStyle(
                          color: selectedItem == null
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                      children: categories.map((item) {
                        return ListTile(
                          title: Text(item),
                          onTap: () {
                            setState(() {
                              selectedItem = item;
                            });
                            _controller.collapse();
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // SizedBox(
            //   width: double.infinity,
            //   height: 50,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.green,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(25),
            //       ),
            //     ),
            //     onPressed: () {},
            //     child: const Text(
            //       "Save",
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            // ),

            // buildTextField(
            //   "Price",
            //   keyboardType: TextInputType.number, controller: priceController,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 235,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      buildTextField("Offer", controller: offerController),
                    ],
                  ),
                ),

                SizedBox(
                  width: 235,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Value"),
                      const SizedBox(height: 3),
                      DropdownButtonFormField<String>(
                        value: selectedOffer,
                        isExpanded: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        items: offers
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedOffer = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Stock"),
                      const SizedBox(height: 6),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (count > 0) count--;
                                });
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            Text(
                              "$count",
                              style: const TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  count++;
                                });
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Unit"),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        value: selectedUnit,
                        isExpanded: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        items: items
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedUnit = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            buildTextField(
              "Price",
              controller: priceController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 30),

            /// 🔹 Bottom Curved Save Button
            Container(
              width: 300,
              height: 50,
              margin: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: updateProduct,
                child: const Text(
                  "Update",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //   Widget buildTextField(
  //     String label, {
  //     int maxLines = 1,
  //     TextInputType keyboardType = TextInputType.text,
  //   }) {
  //     return Padding(
  //       padding: const EdgeInsets.only(bottom: 16),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(label),
  //           const SizedBox(height: 6),
  //           TextField(
  //             maxLines: maxLines,
  //             keyboardType: keyboardType,
  //             decoration: const InputDecoration(border: OutlineInputBorder()),
  //           ),
  //         ],
  //       ),
  //     );
  //   }

  Widget buildTextField(
    String label, {
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
        ],
      ),
    );
  }
}
