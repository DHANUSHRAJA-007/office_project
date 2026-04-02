// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

// class Adddetailspage extends StatefulWidget {
//   const Adddetailspage({super.key});

//   @override
//   State<Adddetailspage> createState() => _AdddetailspageState();
// }

// class _AdddetailspageState extends State<Adddetailspage> {
//   int count = 0;
//   double finalPrice = 0;

//   bool isFetchedProduct = false;

//   final List<String> items = ["250 grams", "500 grams", "1 kg"];
//   final List<String> categories = [
//     "Fruits",
//     "Vegetable",
//     "Malt",
//   ];

//   late String selectedValue;
//   DateTime? selectedDate;
//   String? selectedItem;

//   final TextEditingController productIdController = TextEditingController();
//   final TextEditingController productNameController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController tagController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController taxController = TextEditingController();
//   final TextEditingController percentageController = TextEditingController();
//   final TextEditingController offerController = TextEditingController();

//   final ExpansionTileController _controller = ExpansionTileController();

//   Future<void> generateProductId(String category) async {
//     if (category.isEmpty) return;

//     String prefix;

//     switch (category) {
//       case "Fruits":
//         prefix = "ASAIF";
//         break;
//       case "Juice":
//         prefix = "ASAIJ";
//         break;
//       case "Vegetable":
//         prefix = "ASAIV";
//         break;
//       case "Malt":
//         prefix = "ASAIM";
//         break;
//       default:
//         prefix = "ASAI";
//     }

//     QuerySnapshot snapshot = await FirebaseFirestore.instance
//         .collection('products')
//         .where("category", isEqualTo: category)
//         .get();

//     int productCount = snapshot.docs.length + 1;

//     String productId = "$prefix${productCount.toString().padLeft(3, '0')}";

//     productIdController.text = productId;
//   }

//   void calculateFinalPrice() {
//     double price = double.tryParse(priceController.text) ?? 0;
//     double gst = double.tryParse(percentageController.text) ?? 0;
//     double offerPercent = double.tryParse(offerController.text) ?? 0;

//     double discountAmount = price * offerPercent / 100;
//     double discountedPrice = price - discountAmount;

//     double gstAmount = discountedPrice * gst / 100;

//     setState(() {
//       finalPrice = discountedPrice + gstAmount;
//     });
//   }

//   Future<void> fetchProduct() async {
//     QuerySnapshot snapshot =
//         await FirebaseFirestore.instance.collection("products").get();

//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return ListView(
//           children: snapshot.docs.map((doc) {
//             var data = doc.data() as Map<String, dynamic>;

//             return ListTile(
//               title: Text(
//                 "${data["productId"] ?? ""}   ${data["productName"] ?? ""}",
//               ),
//               onTap: () {
//                 productIdController.text = data["productId"] ?? "";
//                 productNameController.text = data["productName"] ?? "";
//                 descriptionController.text = data["description"] ?? "";
//                 tagController.text = data["tag"] ?? "";

//                 priceController.text = data["price"].toString();
//                 taxController.text = data["tax"] ?? "";
//                 percentageController.text = data["percentage"] ?? "";
//                 offerController.text = data["offer"] ?? "";

//                 selectedItem = data["category"];

//                 isFetchedProduct = true;

//                 calculateFinalPrice();

//                 setState(() {});

//                 Navigator.pop(context);
//               },
//             );
//           }).toList(),
//         );
//       },
//     );
//   }

//   Future<void> saveProduct() async {
//     try {
//       await FirebaseFirestore.instance.collection('products').add({
//         'productId': productIdController.text.trim(),
//         'productName': productNameController.text.trim(),
//         'category': selectedItem ?? "",
//         'description': descriptionController.text.trim(),
//         'tag': tagController.text.trim(),
//         'price': double.tryParse(priceController.text) ?? 0,
//         'tax': taxController.text.trim(),
//         'percentage': percentageController.text.trim(),
//         'offer': offerController.text.trim(),
//         'finalPrice': finalPrice,
//         'stock': count,
//         'unit': selectedValue,
//         'packingDate': selectedDate ?? DateTime.now(),
//         'createdAt': FieldValue.serverTimestamp(),
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Product Saved Successfully")),
//       );

//       isFetchedProduct = false;

//       if (selectedItem != null) {
//         generateProductId(selectedItem!);
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Error: $e")));
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     selectedValue = items.first;
//   }

//   Future<void> pickDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2030),
//     );

//     if (picked != null) {
//       setState(() {
//         selectedDate = picked;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         resizeToAvoidBottomInset: true,
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: Colors.green,
//           title: const Text(
//             "Add Details",
//             style: TextStyle(color: Colors.white),
//           ),
//           centerTitle: true,
//           leading: IconButton(
//             onPressed: () {
//               Get.back();
//             },
//             icon: const Icon(Icons.arrow_back, color: Colors.white),
//           ),
//         ),
//         body: Column(
//           children: [
//             const TabBar(
//               labelColor: Colors.green,
//               unselectedLabelColor: Colors.grey,
//               indicatorColor: Colors.green,
//               tabs: [
//                 Tab(text: "Product Details"),
//                 Tab(text: "Price Details"),
//               ],
//             ),
//             Expanded(
//               child: TabBarView(
//                 children: [
//                   SingleChildScrollView(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         buildTextField(
//                           "Product ID",
//                           controller: productIdController,
//                           readOnly: true,
//                         ),
//                         buildTextField(
//                           "Product Name",
//                           controller: productNameController,
//                         ),
//                         const Text("Fetch Product"),
//                         const SizedBox(height: 6),
//                         GestureDetector(
//                           onTap: fetchProduct,
//                           child: Container(
//                             height: 50,
//                             width: double.infinity,
//                             alignment: Alignment.centerLeft,
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 10),
//                             decoration: BoxDecoration(
//                               border: Border.all(),
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             child: const Text(
//                               "Tap to Fetch Product",
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         const Text("Category"),
//                         const SizedBox(height: 6),
//                         Container(
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.black),
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: ExpansionTile(
//                             controller: _controller,
//                             tilePadding:
//                                 const EdgeInsets.symmetric(horizontal: 12),
//                             title: Text(
//                               selectedItem ?? "Select Category",
//                               style: TextStyle(
//                                 color: selectedItem == null
//                                     ? Colors.grey
//                                     : Colors.black,
//                               ),
//                             ),
//                             children: categories.map((item) {
//                               return ListTile(
//                                 title: Text(item),
//                                 onTap: () async {
//                                   setState(() {
//                                     selectedItem = item;
//                                   });

//                                   if (!isFetchedProduct) {
//                                     await generateProductId(item);
//                                   }

//                                   _controller.collapse();
//                                 },
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                         buildTextField(
//                           "Description",
//                           maxLines: 4,
//                           controller: descriptionController,
//                         ),
//                         buildTextField(
//                           "Add Tag",
//                           controller: tagController,
//                         ),
//                         const SizedBox(height: 30),
//                       ],
//                     ),
//                   ),
//                   SingleChildScrollView(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         buildTextField(
//                           "Price",
//                           controller: priceController,
//                           keyboardType: TextInputType.number,
//                           onChanged: (_) => calculateFinalPrice(),
//                         ),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: buildTextField(
//                                 "Tax (GST)",
//                                 controller: taxController,
//                               ),
//                             ),
//                             const SizedBox(width: 12),
//                             Expanded(
//                               child: buildTextField(
//                                 "Percentage (%)",
//                                 controller: percentageController,
//                                 keyboardType: TextInputType.number,
//                                 onChanged: (_) => calculateFinalPrice(),
//                               ),
//                             ),
//                           ],
//                         ),
//                         buildTextField(
//                           "Offer (%)",
//                           controller: offerController,
//                           keyboardType: TextInputType.number,
//                           onChanged: (_) => calculateFinalPrice(),
//                         ),
//                         const Text("Final Price"),
//                         Container(
//                           height: 50,
//                           width: double.infinity,
//                           alignment: Alignment.centerLeft,
//                           padding:
//                               const EdgeInsets.symmetric(horizontal: 10),
//                           decoration: BoxDecoration(border: Border.all()),
//                           child: Text(
//                             finalPrice.toStringAsFixed(2),
//                             style: const TextStyle(fontSize: 18),
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Row(
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                 children: [
//                                   const Text("Stock"),
//                                   const SizedBox(height: 6),
//                                   Container(
//                                     height: 50,
//                                     decoration: BoxDecoration(
//                                       border: Border.all(),
//                                       borderRadius:
//                                           BorderRadius.circular(5),
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         IconButton(
//                                           onPressed: () {
//                                             setState(() {
//                                               if (count > 0) count--;
//                                             });
//                                           },
//                                           icon:
//                                               const Icon(Icons.remove),
//                                         ),
//                                         Text("$count"),
//                                         IconButton(
//                                           onPressed: () {
//                                             setState(() {
//                                               count++;
//                                             });
//                                           },
//                                           icon: const Icon(Icons.add),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(width: 12),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                 children: [
//                                   const Text("Unit"),
//                                   const SizedBox(height: 6),
//                                   DropdownButtonFormField<String>(
//                                     value: selectedValue,
//                                     isExpanded: true,
//                                     decoration:
//                                         const InputDecoration(
//                                       border: OutlineInputBorder(),
//                                     ),
//                                     items: items
//                                         .map(
//                                           (item) =>
//                                               DropdownMenuItem<String>(
//                                             value: item,
//                                             child: Text(item),
//                                           ),
//                                         )
//                                         .toList(),
//                                     onChanged: (value) {
//                                       setState(() {
//                                         selectedValue = value!;
//                                       });
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 20),
//                         const Text("Date of Packing"),
//                         const SizedBox(height: 6),
//                         Container(
//                           padding:
//                               const EdgeInsets.symmetric(horizontal: 12),
//                           decoration: BoxDecoration(
//                             border: Border.all(),
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: Row(
//                             mainAxisAlignment:
//                                 MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 selectedDate == null
//                                     ? "Select Date"
//                                     : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
//                               ),
//                               IconButton(
//                                 onPressed: () => pickDate(context),
//                                 icon: const Icon(
//                                     Icons.calendar_month),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               width: 300,
//               height: 50,
//               margin: const EdgeInsets.only(bottom: 10),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                 ),
//                 onPressed: saveProduct,
//                 child: const Text(
//                   "Save",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildTextField(
//     String label, {
//     required TextEditingController controller,
//     int maxLines = 1,
//     TextInputType keyboardType = TextInputType.text,
//     Function(String)? onChanged,
//     bool readOnly = false,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label),
//           const SizedBox(height: 6),
//           TextField(
//             controller: controller,
//             maxLines: maxLines,
//             keyboardType: keyboardType,
//             onChanged: onChanged,
//             readOnly: readOnly,
//             decoration:  
//                 const InputDecoration(border: OutlineInputBorder()),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Adddetailspage extends StatefulWidget {
  const Adddetailspage({super.key});

  @override
  State<Adddetailspage> createState() => _AdddetailspageState();
}

class _AdddetailspageState extends State<Adddetailspage> {
  int count = 0;
  double finalPrice = 0;

  bool isFetchedProduct = false;

  final List<String> items = ["250 grams", "500 grams", "1 kg"];
  final List<String> categories = [
    "Fruits",
    "Vegetable",
    "Malt",
  ];

  late String selectedValue;
  DateTime? selectedDate;
  String? selectedItem;

  final TextEditingController productIdController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
 // final TextEditingController tagController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController taxController = TextEditingController();
  final TextEditingController percentageController = TextEditingController();
  final TextEditingController offerController = TextEditingController();

  final ExpansionTileController _controller = ExpansionTileController();

  Future<void> generateProductId(String category) async {
  if (category.isEmpty) return;

  String prefix;

  switch (category) {
    case "Fruits":
      prefix = "ASAIF";
      break;
    case "Vegetable":
      prefix = "ASAIV";
      break;
    case "Malt":
      prefix = "ASAIM";
      break;
    case "Juice":
      prefix = "ASAIJ";
      break;
    default:
      prefix = "ASAI";
  }

  try {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('products')
        .where("category", isEqualTo: category)
        .get(); // ✅ removed orderBy (no index issue)

    int maxNumber = 0;

    for (var doc in snapshot.docs) {
      String id = doc["productId"] ?? "";

      if (id.startsWith(prefix)) {
        String numberPart = id.replaceAll(prefix, "");
        int num = int.tryParse(numberPart) ?? 0;

        if (num > maxNumber) {
          maxNumber = num;
        }
      }
    }

    int nextNumber = maxNumber + 1;

    String newId = "$prefix${nextNumber.toString().padLeft(3, '0')}";

    setState(() {
      productIdController.text = newId;
    });

  } catch (e) {
    print("ID Generation Error: $e");
  }
}

  void calculateFinalPrice() {
    double price = double.tryParse(priceController.text) ?? 0;
    double gst = double.tryParse(percentageController.text) ?? 0;
    double offerPercent = double.tryParse(offerController.text) ?? 0;

    double discountAmount = price * offerPercent / 100;
    double discountedPrice = price - discountAmount;

    double gstAmount = discountedPrice * gst / 100;

    setState(() {
      finalPrice = discountedPrice + gstAmount;
    });
  }

  Future<void> fetchProduct() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection("products").get();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ListView(
          children: snapshot.docs.map((doc) {
            var data = doc.data() as Map<String, dynamic>;

            return ListTile(
              title: Text(
                "${data["productId"] ?? ""}   ${data["productName"] ?? ""}",
              ),
              onTap: () async {
                // ❌ REMOVED OLD ID SETTING

                productNameController.text = data["productName"] ?? "";
                descriptionController.text = data["description"] ?? "";
                //tagController.text = data["tag"] ?? "";

                priceController.text = data["price"].toString();
                taxController.text = data["tax"] ?? "";
                percentageController.text = data["percentage"] ?? "";
                offerController.text = data["offer"] ?? "";

                selectedItem = data["category"];

                isFetchedProduct = true;

                // ✅ GENERATE NEW ID
                if (selectedItem != null) {
                  await generateProductId(selectedItem!);
                }

                calculateFinalPrice();

                setState(() {});

                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  Future<void> saveProduct() async {
    try {
      await FirebaseFirestore.instance.collection('products').add({
        'productId': productIdController.text.trim(),
        'productName': productNameController.text.trim(),
        'category': selectedItem ?? "",
        'description': descriptionController.text.trim(),
       // 'tag': tagController.text.trim(),
        'price': double.tryParse(priceController.text) ?? 0,
        'tax': taxController.text.trim(),
        'percentage': percentageController.text.trim(),
        'offer': offerController.text.trim(),
        'finalPrice': finalPrice,
        'stock': count,
        'unit': selectedValue,
        'packingDate': selectedDate ?? DateTime.now(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Product Saved Successfully")),
      );

      isFetchedProduct = false;

      if (selectedItem != null) {
        generateProductId(selectedItem!);
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
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
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          title: const Text(
            "Add Details",
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
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildTextField(
                          "Product ID",
                          controller: productIdController,
                          readOnly: true,
                        ),
                        buildTextField(
                          "Product Name",
                          controller: productNameController,
                        ),
                        const Text("Fetch Product"),
                        const SizedBox(height: 6),
                        GestureDetector(
                          onTap: fetchProduct,
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              "Tap to Fetch Product",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text("Category"),
                        const SizedBox(height: 6),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ExpansionTile(
                            controller: _controller,
                            tilePadding:
                                const EdgeInsets.symmetric(horizontal: 12),
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
                                onTap: () async {
                                  setState(() {
                                    selectedItem = item;
                                  });

                                  if (!isFetchedProduct) {
                                    await generateProductId(item);
                                  }

                                  _controller.collapse();
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        buildTextField(
                          "Description",
                          maxLines: 4,
                          controller: descriptionController,
                        ),
                        // buildTextField(
                        //   "Add Tag",
                        //   controller: tagController,
                        // ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildTextField(
                          "Price",
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          onChanged: (_) => calculateFinalPrice(),
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
                                keyboardType: TextInputType.number,
                                onChanged: (_) => calculateFinalPrice(),
                              ),
                            ),
                          ],
                        ),
                        buildTextField(
                          "Offer (%)",
                          controller: offerController,
                          keyboardType: TextInputType.number,
                          onChanged: (_) => calculateFinalPrice(),
                        ),
                        const Text("Final Price"),
                        Container(
                          height: 50,
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          padding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(border: Border.all()),
                          child: Text(
                            finalPrice.toStringAsFixed(2),
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Text("Stock"),
                                  const SizedBox(height: 6),
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius:
                                          BorderRadius.circular(5),
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
                                          icon:
                                              const Icon(Icons.remove),
                                        ),
                                        Text("$count"),
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
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Text("Unit"),
                                  const SizedBox(height: 6),
                                  DropdownButtonFormField<String>(
                                    value: selectedValue,
                                    isExpanded: true,
                                    decoration:
                                        const InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                    items: items
                                        .map(
                                          (item) =>
                                              DropdownMenuItem<String>(
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
                          padding:
                              const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedDate == null
                                    ? "Select Date"
                                    : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                              ),
                              IconButton(
                                onPressed: () => pickDate(context),
                                icon: const Icon(
                                    Icons.calendar_month),
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

  Widget buildTextField(
    String label, {
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    Function(String)? onChanged,
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
            onChanged: onChanged,
            readOnly: readOnly,
            decoration:
                const InputDecoration(border: OutlineInputBorder()),
          ),
        ],
      ),
    );
  }
}