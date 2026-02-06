import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_project/screens/cart_provider.dart';
import 'package:office_project/screens/cartpage.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CollectionReference products = FirebaseFirestore.instance.collection(
    'products',
  );

  bool showPopup = false;

  void showAddPopup() {
    setState(() => showPopup = true);

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => showPopup = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          // PRODUCT LIST
          StreamBuilder<QuerySnapshot>(
            stream: products.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              var productList = snapshot.data!.docs;

              if (productList.isEmpty) {
                return const Center(child: Text("No products available"));
              }

              return ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  var product = productList[index];

                  return Card(
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product['name']),
                          Text("Category : ${product['category']}"),

                          if (product['count'] == 0)
                            const Text(
                              "Out of stock",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                          if (product['count'] < 10 && product['count'] > 0)
                            Text(
                              "Limited stock",
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ],
                      ),

                      subtitle: Text("Price : ₹${product['price']}"),

                      trailing: product['count'] > 0
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // ADD TO CART BUTTON
                                ElevatedButton(
                                  onPressed: () {
                                    Map<String, dynamic> cartItem = {
                                      'name': product["name"],
                                      'price': product["price"],
                                    };

                                    context.read<CartProvider>().addToCart(
                                      cartItem,
                                    );

                                    showAddPopup();
                                  },
                                  child: Text("Add to cart"),
                                ),

                                ///BUY BUTTON
                                ElevatedButton(
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection('products')
                                        .doc(product.id)
                                        .update({
                                          'count': FieldValue.increment(-1),
                                        });
                                  },
                                  child: const Text("Buy"),
                                ),
                              ],
                            )
                          : null,
                    ),
                  );
                },
              );
            },
          ),

          //POPUP UI (Correct Position)
          if (showPopup)
            Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Get.to(Cartpage());
                },
                child: AnimatedContainer(
                  height: 60,
                  duration: const Duration(milliseconds: 400),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(blurRadius: 10, color: Colors.black26),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        "Added to Cart",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
