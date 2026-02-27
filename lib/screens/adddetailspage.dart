import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Adddetailspage extends StatefulWidget {
  const Adddetailspage({super.key});

  @override
  State<Adddetailspage> createState() => _AdddetailspageState();
}

class _AdddetailspageState extends State<Adddetailspage> {
  int count = 0;

  final List<String> items = ["1 unit", "2 unit", "3 unit"];
  late String selectedValue;

  DateTime? selectedDate;

  final TextEditingController productIdController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController tagController = TextEditingController();

  final TextEditingController priceController = TextEditingController();
  final TextEditingController taxController = TextEditingController();
  final TextEditingController percentageController = TextEditingController();
  final TextEditingController offerController = TextEditingController();

  Future<void> saveProduct() async {
    // if (productIdController.text.isEmpty ||
    //     productNameController.text.isEmpty ||
    //     priceController.text.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text("Please fill required fields")),
    //   );
    //   return; // stop saving
    // }

    try {
      await FirebaseFirestore.instance.collection('addedproducts').add({
        'productId': productIdController.text.trim(),
        'productName': productNameController.text.trim(),
        'category': categoryController.text.trim(),
        'description': descriptionController.text.trim(),
        'tag': tagController.text.trim(),
        'price': double.tryParse(priceController.text) ?? 0,
        'tax': taxController.text.trim(),
        'percentage': percentageController.text.trim(),
        'offer': offerController.text.trim(),
        'stock': count,
        'unit': selectedValue,
        'packingDate': selectedDate ?? DateTime.now(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Product Saved Successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  void initState() {
    super.initState();
    selectedValue = items.first;
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text(
            "Add Details",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const TabBar(
              labelColor: Colors.green,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.green,
              tabs: [
                Tab(text: "Product Details"),
                Tab(text: "Price Details"),
              ],
            ),

            Expanded(
              child: TabBarView(
                children: [
                  /// ================= PRODUCT TAB =================
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildTextField(
                          "Product ID",
                          controller: productIdController,
                        ),
                        buildTextField(
                          "Product Name",
                          controller: productNameController,
                        ),
                        buildTextField(
                          "Product Category",
                          controller: categoryController,
                        ),
                        buildTextField(
                          "Description",
                          maxLines: 4,
                          controller: descriptionController,
                        ),
                        buildTextField("Add Tag", controller: tagController),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Save",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// ================= PRICE TAB =================
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // buildTextField(
                        //   "Price",
                        //   keyboardType: TextInputType.number, controller: priceController,
                        // ),
                        buildTextField(
                          "Price",
                          controller: priceController,
                          keyboardType: TextInputType.number,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: buildTextField(
                                "Tax (GST)",
                                controller: taxController,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: buildTextField(
                                "Percentage (%)",
                                controller: percentageController,
                              ),
                            ),
                          ],
                        ),
                        buildTextField("Offer", controller: offerController),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                    value: selectedValue,
                                    isExpanded: true,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
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
                                        selectedValue = value!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text("Date of Packing"),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedDate == null
                                    ? "Select Date"
                                    : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                              ),
                              IconButton(
                                onPressed: () => pickDate(context),
                                icon: const Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

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
                onPressed: saveProduct,
                child: const Text(
                  "Save",
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
