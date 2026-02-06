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

                int price = int.tryParse(item['price'].toString()) ?? 0;
                int quantity = item['quantity'] ?? 1;

                int newprice = price * quantity;

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(item["name"]),
                    subtitle: Text("₹ $newprice"),
                    // leading: item["image"] != null
                    //     ? Image.memory(
                    //         Base64Decoder()
                    //             .convert(item["image"].split(',').last),
                    //         width: 60,
                    //         height: 60,
                    //         fit: BoxFit.cover,
                    //       )
                    //     : const Icon(Icons.image_not_supported),
                    trailing: Wrap(
                      spacing: 10,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              item['quantity'] = quantity + 1; // ✅ update item
                            });
                          },
                          icon: const Icon(Icons.add),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "$quantity",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            if (quantity > 1) {
                              setState(() {
                                item['quantity'] =
                                    quantity - 1; // ✅ update item
                              });
                            }
                          },
                          icon: const Icon(Icons.remove),
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
