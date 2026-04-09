import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Updateproductpage extends StatefulWidget {
  final String productId;
  final DocumentSnapshot productData;

  const Updateproductpage({
    super.key,
    required this.productId,
    required this.productData,
  });

  @override
  State<Updateproductpage> createState() => _UpdateproductpageState();
}

class _UpdateproductpageState extends State<Updateproductpage> {
  int count = 0;

  final List<String> items = ["250 grams", "500 grams", "1 kg"];

  final List<String> categories = ["Fruits", "Vegetable", "Malt"];

  final List<String> offers = ["25 %", "50 %", "75 %", "no offers"];

  late String selectedUnit;
  late String selectedOffer;

  DateTime? selectedDate;
  String? selectedItem;

  final TextEditingController productIdController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController tagController = TextEditingController();

  final TextEditingController priceController = TextEditingController();
  final TextEditingController offerController = TextEditingController();
  final TextEditingController finalPriceController = TextEditingController();

  final TextEditingController taxController = TextEditingController();
  final TextEditingController stockcontroller = TextEditingController();
  final ExpansionTileController _controller = ExpansionTileController();

  /// FINAL PRICE CALCULATION
  void calculateFinalPrice() {
    double price = double.tryParse(priceController.text) ?? 0;

    String offerText = offerController.text.replaceAll("%", "").trim();

    double offerPercent = double.tryParse(offerText) ?? 0;

    double finalPrice = price - (price * offerPercent / 100);

    finalPriceController.text = finalPrice.toStringAsFixed(2);
  }

  /// UPDATE FIRESTORE
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
            'offer': offerController.text,
            'finalPrice': double.tryParse(finalPriceController.text) ?? 0,

            'tax': taxController.text.trim(),
            'stock': stockcontroller.text,
            'unit': selectedUnit,

            'packingDate': selectedDate ?? DateTime.now(),
            'updatedAt': FieldValue.serverTimestamp(),
          });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Product Updated Successfully")),
      );

      Get.back(result: true);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
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
    offerController.text = data['offer']?.toString() ?? "";

    finalPriceController.text = data['finalPrice']?.toString() ?? "0";

    descriptionController.text = data['description'] ?? "";
    tagController.text = data['tag'] ?? "";
    taxController.text = data['tax'] ?? "";

    selectedItem = data['category'];

    selectedUnit = items.contains(data['unit']) ? data['unit'] : items.first;

    count = data['stock'] ?? 0;

    /// AUTO CALCULATE WHEN PRICE CHANGES
    priceController.addListener(() {
      calculateFinalPrice();
    });

    /// AUTO CALCULATE WHEN OFFER CHANGES
    offerController.addListener(() {
      calculateFinalPrice();
    });
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
          children: [
            Container(
              height: 90,
              width: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage("assets/one.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),

            buildTextField("Product ID", controller: productIdController),

            buildTextField("Product Name", controller: productNameController),

            /// CATEGORY
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Product Categories"),

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

            /// OFFER FIELD
            Column(
              children: [
                const SizedBox(height: 10),
                buildTextField(
                  "Offer",
                  controller: offerController,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),

            const SizedBox(width: 12),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Unit"),

                // const SizedBox(height: 6),
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

            const SizedBox(height: 15),

            /// PRICE
            buildTextField(
              "Price",
              controller: priceController,
              keyboardType: TextInputType.number,
            ),

            /// FINAL PRICE (VIEW ONLY)
            buildTextField(
              "Final Price",
              controller: finalPriceController,
              readOnly: true,
            ),

            const SizedBox(height: 30),

            /// UPDATE BUTTON
            Container(
              width: 300,
              height: 50,

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

  Widget buildTextField(
    String label, {
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
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
            readOnly: readOnly,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
        ],
      ),
    );
  }
}
