import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../widgets/product.dart';

class Vegetablepage extends StatefulWidget {
  const Vegetablepage({super.key});

  @override
  State<Vegetablepage> createState() => _VegetablepageState();
}

class _VegetablepageState extends State<Vegetablepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Vegetables",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('products')
            .where('category', isEqualTo: 'Vegetable')
            .snapshots(),

        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No Vegetables Available",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return LayoutBuilder(
            builder: (context, constraints) {

              int crossAxisCount = 2;

              if (constraints.maxWidth > 900) {
                crossAxisCount = 4;
              } 
              else if (constraints.maxWidth > 600) {
                crossAxisCount = 3;
              }

              return GridView.builder(
                padding: const EdgeInsets.all(12),

                itemCount: snapshot.data!.docs.length,

                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),

                itemBuilder: (context, index) {

                  var product = snapshot.data!.docs[index];

                  return Product(product: product);
                },
              );
            },
          );
        },
      ),
    );
  }
}