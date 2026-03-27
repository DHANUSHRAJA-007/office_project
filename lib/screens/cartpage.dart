import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_project/screens/addresspage.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

class Cartpage extends StatefulWidget {
  const Cartpage({super.key});

  @override
  State<Cartpage> createState() => _CartpageState();
}

Future<void> placeOrder(
  DocumentSnapshot userDoc,
  List cart,
  int total,
  CartProvider cartProvider,
) async {
  final user = FirebaseAuth.instance.currentUser;

  final cartItems = cart.map((item) {
    return {
      'name': item['name'],
      'price': item['price'],
      'quantity': item['quantity'],
    };
  }).toList();

  await FirebaseFirestore.instance.collection('orders').add({
    'buyerId': user!.uid,
    'buyerName': userDoc['name'],
    'buyerAddress': userDoc['address'],
    'items': cartItems,
    'total': total,
    'status': 'pending',
    'timestamp': FieldValue.serverTimestamp(),
  });

  cartProvider.clearCart();

  Get.snackbar("Success", "Order placed successfully");
}

class _CartpageState extends State<Cartpage> {
  int getTotal(List cart) {
    int total = 0;

    for (var item in cart) {
      int price = int.tryParse(item['price'].toString()) ?? 0;
      int quantity = item['quantity'] ?? 1;

      total += price * quantity;
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final cart = context.watch<CartProvider>().cartItems;
    print(cart);

    int subtotal = getTotal(cart);
    int delivery = 20;
    int discount = 0;
    int total = subtotal + delivery - discount;

    return Scaffold(
      backgroundColor: const Color(0xffECECEC),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffECECEC),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: cart.isEmpty
          ? const Center(child: Text("No items in the cart"))
          : Column(
              children: [
                /// CART ITEMS
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: cart.length,
                    itemBuilder: (_, index) {
                      final item = cart[index];

                      int price = int.tryParse(item['price'].toString()) ?? 0;

                      int quantity = item['quantity'] ?? 1;

                      int newprice = price * quantity;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),

                        child: Row(
                          children: [
                            /// IMAGE
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "assets/v1.jpg",
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                              ),
                            ),

                            const SizedBox(width: 12),

                            /// DETAILS
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item["name"],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                    item["offer"] != null
                                        ? "Offer: ${item["offer"]}"
                                        : "No Offer",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  Row(
                                    children: [
                                      Text(
                                        "₹ $newprice/",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        "Kg",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            /// QUANTITY
                            Row(
                              children: [
                                /// MINUS
                                Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(Icons.remove, size: 16),
                                    onPressed: () {
                                      if (quantity > 1) {
                                        setState(() {
                                          item['quantity'] = quantity - 1;
                                        });
                                      } else {
                                        context.read<CartProvider>().removeItem(
                                          index,
                                        );
                                      }
                                    },
                                  ),
                                ),

                                const SizedBox(width: 8),

                                Text(
                                  "$quantity",
                                  style: const TextStyle(fontSize: 15),
                                ),

                                const SizedBox(width: 8),

                                /// PLUS
                                Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(Icons.add, size: 16),
                                    onPressed: () {
                                      setState(() {
                                        item['quantity'] = quantity + 1;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                /// BILL SECTION
                Container(
                  padding: const EdgeInsets.all(16),

                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),

                  child: Column(
                    children: [
                      /// PROMO CODE
                      const SizedBox(height: 20),

                      /// BILL DETAILS
                      billRow("Sub Total", subtotal),
                      billRow("Delivery Fee", delivery),
                      billRow("Discount", discount),

                      const Divider(),

                      billRow("TOTAL COST", total, isBold: true),
                      const Divider(),

                      FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(user!.uid)
                            .get(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const SizedBox();
                          }

                          final data =
                              snapshot.data!.data() as Map<String, dynamic>?;

                          String address =
                              data?['address'] ?? "No Address Added";

                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),

                                const Text(
                                  "Delivery Address",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  address,
                                  style: TextStyle(color: Colors.grey.shade700),
                                ),

                                const SizedBox(height: 10),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),

                      /// CHECKOUT BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () async {
                            try {
                              final cartProvider = context.read<CartProvider>();
                              final cart = cartProvider.cartItems;

                              if (cart.isEmpty) {
                                Get.snackbar("Error", "Cart is empty");
                                return;
                              }

                              print("🔥 Button clicked");

                              /// ✅ FIX 1: correct user fetch
                              final user = FirebaseAuth.instance.currentUser;

                              if (user == null) {
                                Get.snackbar("Error", "User not logged in");
                                return;
                              }

                              /// ✅ Fetch user details
                              final userDoc = await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(user.uid)
                                  .get();

                              /// 🔥 CHECK ADDRESS BEFORE ORDER
                              if (!userDoc.data()!.containsKey('address') ||
                                  userDoc['address'] == null ||
                                  userDoc['address'].toString().isEmpty) {
                                Get.snackbar(
                                  "Error",
                                  "Please add address first",
                                );

                                /// 👉 Go to address page
                                bool? result = await Get.to(
                                  () => AddAddressPage(fromCheckout: true),
                                );

                                /// 🔥 If address added → continue order
                                if (result == true) {
                                  // reload userDoc
                                  final updatedUserDoc = await FirebaseFirestore
                                      .instance
                                      .collection('users')
                                      .doc(user.uid)
                                      .get();

                                  /// now continue order
                                  await placeOrder(
                                    updatedUserDoc,
                                    cart,
                                    total,
                                    cartProvider,
                                  );
                                }
                                return;
                              }

                              /// ✅ Convert cart items
                              final cartItems = cart.map((item) {
                                return {
                                  'name': item['name'],
                                  'price': item['price'],
                                  'quantity': item['quantity'],
                                };
                              }).toList();

                              /// ✅ Save order (IMPORTANT: await)
                              await FirebaseFirestore.instance
                                  .collection('orders')
                                  .add({
                                    'buyerId': user.uid,
                                    'buyerName': userDoc['name'],
                                    'buyerAddress': userDoc['address'],
                                    'items': cartItems, // 🔥 VERY IMPORTANT
                                    'total':
                                        total, // your already calculated total
                                    'status': 'pending',
                                    'timestamp': FieldValue.serverTimestamp(),
                                  });

                              print("✅ Order added to Firestore");

                              /// ✅ Clear cart
                              cartProvider.clearCart();

                              Get.snackbar(
                                "Success",
                                "Order placed successfully",
                              );
                            } catch (e) {
                              print("❌ Error: $e");
                              Get.snackbar("Error", e.toString());
                            }
                          },
                          child: const Text(
                            "Proceed to Checkout",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  /// BILL ROW WIDGET
  Widget billRow(String title, int price, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 18 : 15,
            ),
          ),
          Text(
            "₹ $price",
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 18 : 15,
            ),
          ),
        ],
      ),
    );
  }
}
