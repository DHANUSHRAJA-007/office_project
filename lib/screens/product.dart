// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class Product extends StatefulWidget {
//   const Product({super.key});

//   @override
//   State<Product> createState() => _ProductState();
// }

// class _ProductState extends State<Product> {
//   final CollectionReference products = FirebaseFirestore.instance.collection(
//     'products',
//   );
//   void addProduct(String name, price, category, int count) {
//     products.add({
//       "name": name,
//       "price": price,
//       "category": category,
//       "count": count,
//       "Createdat": FieldValue.serverTimestamp(),
//     });
//   }

//   void deleteProduct(String docId) {
//     products.doc(docId).delete();
//   }

//   void updateProduct(
//     String docId,
//     String name,
//     String price,
//     String category,
//     int count,
//   ) {
//     products.doc(docId).update({
//       "name": name,
//       "price": price,
//       'category': category,
//       "count": count,
//     });
//   }

//   void openProductDialog({
//     String? docId,
//     String? existingName,
//     String? existingPrice,
//     String? existingcategory,
//     String? existingcount,
//   }) {
//     TextEditingController namecontroller = TextEditingController(
//       text: existingName,
//     );

//     TextEditingController pricecontroller = TextEditingController(
//       text: existingPrice,
//     );
//     TextEditingController categorycontroller = TextEditingController(
//       text: existingcategory,
//     );
//     TextEditingController countcontroller = TextEditingController(
//       text: existingcount,
//     );
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(docId == null ? "Add Product" : "Edit Product"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: namecontroller,
//                 decoration: InputDecoration(labelText: "Product Name"),
//               ),
//               TextField(
//                 controller: pricecontroller,
//                 decoration: InputDecoration(labelText: "Price"),
//               ),
//               TextField(
//                 controller: categorycontroller,
//                 decoration: InputDecoration(labelText: "category"),
//               ),
//               TextField(
//                 controller: countcontroller,
//                 decoration: InputDecoration(labelText: "count"),
//               ),
//             ],
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 int parsedCount = int.tryParse(countcontroller.text) ?? 0;
                
//                 if (docId == null) {
//                   // ADD
//                   addProduct(
//                     namecontroller.text,
//                     pricecontroller.text,
//                     categorycontroller.text,
//                     parsedCount,
//                   );
//                 } else {
//                   // UPDATE
//                   updateProduct(
//                     docId,
//                     namecontroller.text,
//                     pricecontroller.text,
//                     categorycontroller.text,
//                     parsedCount,
//                   );
//                 }

//                 Navigator.pop(context);
//               },
//               child: Text(docId == null ? "Add" : "Update"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         stream: products.snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }

//           var productList = snapshot.data!.docs;

//           if (productList.isEmpty) {
//             return Center(child: Text("No Products Added"));
//           }

//           return ListView.builder(
//             itemCount: productList.length,
//             itemBuilder: (context, index) {
//               var product = productList[index];
//               var productDoc = productList[index];
//               String docId = productDoc.id;
//               return ListTile(
//                 title: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(product["name"]),
//                     Text("Category:${product['category']}"),
//                     Text("count : ${product['count']}"),
//                   ],
//                 ),
//                 subtitle: Text("Price: ₹${product["price"]}"),
//                 trailing: Wrap(
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         openProductDialog(
//                           docId: docId,
//                           existingName: product["name"],
//                           existingPrice: product["price"],
//                           existingcount: product["count"],
//                         );
//                         updateProduct(
//                           docId,
//                           product['name'],
//                           product['price'],
//                           product['category'],
//                           product['count'],
//                         );
//                       },
//                       icon: Icon(Icons.edit),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         deleteProduct(docId);
//                       },
//                       icon: Icon(Icons.delete),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),

//       floatingActionButton: FloatingActionButton(
//         tooltip: "Click to add product",
//         shape: CircleBorder(),
//         backgroundColor: Colors.blue,
//         child: Icon(Icons.add),
//         onPressed: () {
//           openProductDialog();
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  // ---------------- ADD PRODUCT ----------------
  void addProduct(String name, String price, String category, int count) {
    products.add({
      "name": name,
      "price": int.tryParse(price) ?? 0, // ✅ store as int
      "category": category,
      "count": count,
      "Createdat": FieldValue.serverTimestamp(),
    });
  }

  // ---------------- DELETE PRODUCT ----------------
  void deleteProduct(String docId) {
    products.doc(docId).delete();
  }

  // ---------------- UPDATE PRODUCT ----------------
  void updateProduct(
    String docId,
    String name,
    String price,
    String category,
    int count,
  ) {
    products.doc(docId).update({
      "name": name,
      "price": int.tryParse(price) ?? 0, // ✅ store as int
      "category": category,
      "count": count,
    });
  }

  // ---------------- DIALOG ----------------
  void openProductDialog({
    String? docId,
    String? existingName,
    String? existingPrice,
    String? existingcategory,
    String? existingcount,
  }) {
    TextEditingController namecontroller =
        TextEditingController(text: existingName);

    TextEditingController pricecontroller =
        TextEditingController(text: existingPrice);

    TextEditingController categorycontroller =
        TextEditingController(text: existingcategory);

    TextEditingController countcontroller =
        TextEditingController(text: existingcount);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(docId == null ? "Add Product" : "Edit Product"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: namecontroller,
                decoration: const InputDecoration(labelText: "Product Name"),
              ),
              TextField(
                controller: pricecontroller,
                keyboardType: TextInputType.number, // ✅ number keyboard
                decoration: const InputDecoration(labelText: "Price"),
              ),
              TextField(
                controller: categorycontroller,
                decoration: const InputDecoration(labelText: "Category"),
              ),
              TextField(
                controller: countcontroller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Count"),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                int parsedCount = int.tryParse(countcontroller.text) ?? 0;

                if (docId == null) {
                  // ADD PRODUCT
                  addProduct(
                    namecontroller.text,
                    pricecontroller.text,
                    categorycontroller.text,
                    parsedCount,
                  );
                } else {
                  // UPDATE PRODUCT
                  updateProduct(
                    docId,
                    namecontroller.text,
                    pricecontroller.text,
                    categorycontroller.text,
                    parsedCount,
                  );
                }

                Navigator.pop(context);
              },
              child: Text(docId == null ? "Add" : "Update"),
            ),
          ],
        );
      },
    );
  }

  // ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: StreamBuilder(
        stream: products.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var productList = snapshot.data!.docs;

          if (productList.isEmpty) {
            return const Center(child: Text("No Products Added"));
          }

          return ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              var product = productList[index];
              String docId = product.id;

              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product["name"]),
                    Text("Category: ${product['category']}"),
                    Text("Count: ${product['count']}"),
                  ],
                ),
                subtitle: Text("Price: ₹${product["price"]}"),
                trailing: Wrap(
                  children: [
                    // -------- EDIT --------
                    IconButton(
                      onPressed: () {
                        openProductDialog(
                          docId: docId,
                          existingName: product["name"],
                          existingPrice: product["price"].toString(),
                          existingcategory: product["category"],
                          existingcount: product["count"].toString(),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),

                    // -------- DELETE --------
                    IconButton(
                      onPressed: () {
                        deleteProduct(docId);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),

      // ---------------- ADD BUTTON ----------------
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Product",
        child: const Icon(Icons.add),
        onPressed: () {
          openProductDialog();
        },
      ),
    );
  }
}
