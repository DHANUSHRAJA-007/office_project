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
  void addProduct(String name, price) {
    products.add({
      "name": name,
      "price": price,
      "Createdat": FieldValue.serverTimestamp(),
    });
  }

  void openAddProductDialog() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController namecontroller = TextEditingController();
        TextEditingController pricecontroller = TextEditingController();
        return AlertDialog(
          title: Text("Add product"),
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
            
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                addProduct(namecontroller.text, pricecontroller.text);
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: products.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Permission Error / Something went wrong"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Loading Products..."));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text("No Data Available"));
          }

          final productList = snapshot.data!.docs;

          if (productList.isEmpty) {
            return Center(child: Text("No Products Added"));
          }

          return ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              final doc = productList[index];
              final product = doc.data() as Map<String, dynamic>;

              return ListTile(
                title: Text(product["name"] ?? ""),
                subtitle: Text("Price: ₹${product["price"] ?? ""}"),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        onPressed: () {
          openAddProductDialog();
        },
      ),
    );
  }
}
