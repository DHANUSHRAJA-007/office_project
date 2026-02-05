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
    Future.delayed(Duration(seconds: 5), () {
      if (mounted) setState(() => showPopup = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          /// 🔥 PRODUCT LIST
          StreamBuilder(
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
                    subtitle: Text("Price : ${product['price']}"),

                    trailing: ElevatedButton(
                      onPressed: () {
                        Map<String, dynamic> cartItem = {
                          'name': product["name"],
                          'price': product["price"],
                        };

                        context.read<CartProvider>().addToCart(cartItem);

                        showAddPopup(); // ⭐ CALL POPUP HERE
                      },
                      child: Text("Add to cart"),
                    ),
                  );
                },
              );
            },
          ),

          /// 🔥 POPUP UI
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
                  width: 200,
                  duration: Duration(milliseconds: 500),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(blurRadius: 10, color: Colors.black26),
                    ],
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
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
