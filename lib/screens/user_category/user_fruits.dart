
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserFruits extends StatefulWidget {
  const UserFruits({super.key});

  @override
  State<UserFruits> createState() => _UserFruitsState();
}
Map<String, bool> likedProducts = {};
class _UserFruitsState extends State<UserFruits> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Fruits",
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
            .where('category', isEqualTo: 'Fruits')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No Fruits Available",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount =2;
              if(constraints.maxWidth>900){
                crossAxisCount=4;
              }else if(constraints.maxWidth>600){
                crossAxisCount=3;
              }
            
            return GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: snapshot.data!.docs.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                var product = snapshot.data!.docs[index];
                var data =
                    product.data() as Map<String, dynamic>;
            
                return  _productCard(product);
              },
            );}
          );
        },
      ),
    );
  }

  Widget _productCard(var product) {
    return InkWell(
      onTap: () {
        
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// OFFER + LIKE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child:  Text(
                      "Offer ${product['offer']}%",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
      
                  // IconButton(
                  //   padding: EdgeInsets.zero,
                  //   constraints: const BoxConstraints(),
                  //   onPressed: () {
                  //     setState(() {
                  //       likedProducts[product.id] =
                  //           !(likedProducts[product.id] ?? false);
                  //     });
                  //   },
                  //   icon: Icon(
                  //     Icons.favorite,
                  //     size: 20,
                  //     color: likedProducts[product.id] == true
                  //         ? Colors.red
                  //         : Colors.grey,
                  //   ),
                  // ),
                ],
              ),
      
              const SizedBox(height: 5),
      
              /// IMAGE
              Expanded(
                child: Center(
                  child: Image.asset('assets/fruits.png', fit: BoxFit.contain),
                ),
              ),
      
              const Divider(thickness: 1),
      
              /// NAME + RATING
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      product['productName'],
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
      
                  const Row(
                    children: [
                      Icon(Icons.star, size: 14, color: Colors.amber),
                      SizedBox(width: 2),
                      Text("4.9", style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
      
              const SizedBox(height: 4),
      
              /// PRICE + ADD BUTTON
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "₹${product['price']}/",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text(" kg", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
      
                  InkWell(
                    onTap: () {
                      
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        "Add",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}