import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  final CollectionReference products = FirebaseFirestore.instance.collection(
    'products',
  );
  void addProduct(String name, price, category) {
    products.add({
      "name": name,
      "price": price,
      "category": category,
      "Createdat": FieldValue.serverTimestamp(),
    });
  }

  void deleteProduct(String docId) {
    products.doc(docId).delete();
  }

  void updateProduct(String docId, String name, String price, String category) {
    products.doc(docId).update({
      "name": name,
      "price": price,
      'category': category,
    });
  }

  void openProductDialog({
    String? docId,
    String? existingName,
    String? existingPrice,
    String? existingcategory,
  }) {
    TextEditingController namecontroller = TextEditingController(
      text: existingName,
    );

    TextEditingController pricecontroller = TextEditingController(
      text: existingPrice,
    );
    TextEditingController categorycontroller = TextEditingController(
      text: existingcategory
    );

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
                decoration: InputDecoration(labelText: "Product Name"),
              ),
              TextField(
                controller: pricecontroller,
                decoration: InputDecoration(labelText: "Price"),
              ),
              TextField(
                controller: categorycontroller,
                decoration: InputDecoration(labelText: "category"),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (docId == null) {
                  // ADD
                  addProduct(
                    namecontroller.text,
                    pricecontroller.text,
                    categorycontroller.text,
                  );
                } else {
                  // UPDATE
                  updateProduct(
                    docId,
                    namecontroller.text,
                    pricecontroller.text,
                    categorycontroller.text,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: products.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var productList = snapshot.data!.docs;

          if (productList.isEmpty) {
            return Center(child: Text("No Products Added"));
          }

          return ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              var product = productList[index];
              var productDoc = productList[index];
              String docId = productDoc.id;
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product["name"]),
                    Text("Category:${product['category']}"),
                  ],
                ),
                subtitle: Text("Price: ₹${product["price"]}"),
                trailing: Wrap(
                  children: [
                    IconButton(
                      onPressed: () {
                        openProductDialog(
                          docId: docId,
                          existingName: product["name"],
                          existingPrice: product["price"],
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        deleteProduct(docId);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: "Click to add product",
        shape: CircleBorder(),
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        onPressed: () {
          openProductDialog();
        },
      ),
    );
  }
}
