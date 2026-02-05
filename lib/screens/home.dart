import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CollectionReference products = FirebaseFirestore.instance.collection(
    'products',
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: products.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        var productList = snapshot.data!.docs;

        if (productList.isEmpty) {
          return Center(child: Text("No products available"));
        }
        return ListView.builder(
          itemCount: productList.length,
          itemBuilder: (context, index) {
            var product = productList[index];
            return ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product['name']),
                  Text("Category : ${product['category']}"),
                ],
              ),
              subtitle: Text("price : ${product['price']}"),
            );
          },
        );
      },
    );
  }
}
