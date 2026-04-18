import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:office_project/screens/productdetailspage.dart';
import 'package:office_project/screens/cart_provider.dart';
import 'package:office_project/screens/userhomepage.dart';
import 'package:office_project/widgets/bannerslider.dart';
import 'package:office_project/widgets/category_scroll.dart';
import 'package:provider/provider.dart';

class UserHomescreen extends StatefulWidget {
  const UserHomescreen({super.key});

  @override
  State<UserHomescreen> createState() => _UserHomescreenState();
}

class _UserHomescreenState extends State<UserHomescreen> {
  final CollectionReference products = FirebaseFirestore.instance.collection(
    'products',
  );

  // Map<String, bool> likedProducts = {};

  TextEditingController searchController = TextEditingController();
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    int crossAxisCount = 2;

    if (width > 900) {
      crossAxisCount = 4;
    } else if (width > 600) {
      crossAxisCount = 3;
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                /// SEARCH BAR
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SearchBar(
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {
                              searchText = value.toLowerCase();
                            });
                          },
                          shape: const WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          elevation: const WidgetStatePropertyAll(0),
                          leading: const Icon(Icons.search),
                          hintText: "Search Products",
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                /// BANNER
                const SizedBox(height: 150, child: BannerSlider()),

                const SizedBox(height: 15),

                /// CATEGORY TITLE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Category",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),

                /// CATEGORY SCROLL
                SizedBox(
                  height: 90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      CategoryScroll(
                        image: 'assets/veggie.png',
                        name: 'Vegetables',
                        route: '/vegetable',
                      ),
                      CategoryScroll(
                        image: 'assets/fruits.png',
                        name: 'Fruits',
                        route: '/fruits',
                      ),

                      CategoryScroll(
                        image: 'assets/veggie.png',
                        name: 'Malt',
                        route: '/protein',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                /// BEST DEAL TITLE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Best Deal",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    // TextButton(
                    //   onPressed: () {},
                    //   child: const Text(
                    //     "See All",
                    //     style: TextStyle(color: Colors.green),
                    //   ),
                    // ),
                  ],
                ),

                const SizedBox(height: 10),

                /// PRODUCT GRID
                StreamBuilder<QuerySnapshot>(
                  stream: products.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text("No products available"));
                    }

                    /// SEARCH FILTER
                    var productList = snapshot.data!.docs.where((product) {
                      String name = product['productName']
                          .toString()
                          .toLowerCase();

                      String category = product['category']
                          .toString()
                          .toLowerCase();

                      return name.contains(searchText) ||
                          category.contains(searchText);
                    }).toList();

                    if (productList.isEmpty) {
                      return const Center(
                        child: Text("No matching products found"),
                      );
                    }

                    return LayoutBuilder(
                      builder: (context, constraints) {
                        int crossAxisCount = 2;

                        if (constraints.maxWidth > 900) {
                          crossAxisCount = 4;
                        } else if (constraints.maxWidth > 600) {
                          crossAxisCount = 3;
                        }

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: productList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.78,
                              ),
                          itemBuilder: (context, index) {
                            var product = productList[index];

                            return _productCard(product);
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _productCard(var product) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      onTap: () {
        Get.to(() => Productdetailspage(product: product));
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
                    child: Text(
                      "Offer ${product['offer']}%",

                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
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
                  // const Row(
                  //   children: [
                  //     Icon(Icons.star, size: 14, color: Colors.amber),
                  //     SizedBox(width: 2),
                  //     Text(
                  //       "4.9",
                  //       style: TextStyle(fontWeight: FontWeight.bold),
                  //     ),
                  //   ],
                  // ),
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
                        "₹${product['price']}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      //const Text(" kg", style: TextStyle(color: Colors.grey)),
                    ],
                  ),

                  InkWell(
                    onTap: () async {
                      final user = FirebaseAuth.instance.currentUser;

                      if (user == null) {
                        Get.snackbar("Error", "User not logged in");
                        return;
                      }

                      Map<String, dynamic> cartItem = {
                        'name': product["productName"],
                        'price': product["price"],
                        'quantity': 1,
                        'productId': product.id,
                        'userId': user.uid,
                        'timestamp': FieldValue.serverTimestamp(),
                      };

                      /// ✅ SAVE TO FIRESTORE
                      await FirebaseFirestore.instance
                          .collection('cart')
                          .add(cartItem);

                      /// ✅ ALSO KEEP LOCAL CART
                      context.read<CartProvider>().addToCart(cartItem);

                      /// ✅ UI FEEDBACK
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 3),
                          backgroundColor: Colors.black,
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Product Added to the Cart"),
                              TextButton(
                                onPressed: () {
                                  Get.offAll(
                                    () => HomePage(role: "user"),
                                    arguments: 2,
                                  );
                                },
                                child: const Text(
                                  "GO TO CART",
                                  style: TextStyle(color: Colors.yellow),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
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
