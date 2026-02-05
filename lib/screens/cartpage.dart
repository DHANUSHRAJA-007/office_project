import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

class Cartpage extends StatefulWidget {
  const Cartpage({super.key});

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cartItems;

    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: cart.isEmpty
          ? const Center(child: Text("No items in the cart"))
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (_, index) {
                final item = cart[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    // leading: item["image"] != null
                    //     ? Image.memory(
                    //         Base64Decoder()
                    //             .convert(item["image"].split(',').last),
                    //         width: 60,
                    //         height: 60,
                    //         fit: BoxFit.cover,
                    //       )
                    //     : const Icon(Icons.image_not_supported),
                    title: Text(item["name"]),
                    subtitle: Text("₹${item["price"]}"),
                    trailing: Wrap(
                      spacing: 10,
                      alignment: WrapAlignment.center,
                      children: [
                        SizedBox(
                          height: 40,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            icon: Icon(Icons.add),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: 40,
                            width: 10,
                            child: Text(
                              "$quantity",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,

                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: IconButton(
                            onPressed: () {
                              if (quantity > 0) {
                                setState(() {
                                  quantity--;
                                });
                              }
                            },
                            icon: Icon(Icons.remove),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
