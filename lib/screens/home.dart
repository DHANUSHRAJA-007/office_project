import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:office_project/screens/product.dart';

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
            return  Card(
  child: ListTile(
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(product['name']),
        Text("Category : ${product['category']}"),

        // 👇 show only when out of stock
        if (product['count'] == 0)
          Text(
            "Out of stock",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          if(product['count']<10&& product['count'] >0)
          Text("Limited stock", style: TextStyle(
              color: Colors.orange.shade200,
              fontWeight: FontWeight.bold,
            ),)
      ],
    ),
    subtitle: Text("Price : ₹${product['price']}"),

    trailing: product['count'] > 0
        ? ElevatedButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('products')
                  .doc(product.id)
                  .update({
                'count': FieldValue.increment(-1),
              });
            },
            child: Text("Buy"),
          )
        : null, // ❌ no button if out of stock
  ),
);

          },
        );
      },
    );
  }
}
