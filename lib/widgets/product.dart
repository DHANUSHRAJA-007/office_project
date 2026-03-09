import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../screens/view_productpage.dart';

class Product extends StatelessWidget {
  final DocumentSnapshot product;

  const Product({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    var data = product.data() as Map<String, dynamic>;

    return InkWell(
      onTap: () {
        Get.to(
          ViewProductpage(
            productId: product.id,
            productData: product,
          ),
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// OFFER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "Offer ${data['offer']} %",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 5),

              /// IMAGE
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/fruits.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const Divider(),

              /// PRODUCT NAME
              Text(
                data['productName'],
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 4),

              /// PRICE
              Row(
                children: [
                  Text(
                    "₹${data['price']}/",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    " kg",
                    style: TextStyle(color: Colors.grey),
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