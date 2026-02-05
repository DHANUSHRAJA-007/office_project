import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart'; 

class Cartpage extends StatelessWidget {
  const Cartpage({super.key});

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
                  ),
                );
              },
            ),
    );
  }
}
