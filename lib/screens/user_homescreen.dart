// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:office_project/widgets/bannerslider.dart';
// import 'package:office_project/widgets/category_scroll.dart';

// class UserHomescreen extends StatefulWidget {
//   const UserHomescreen({super.key});

//   @override
//   State<UserHomescreen> createState() => _UserHomescreenState();
// }

// class _UserHomescreenState extends State<UserHomescreen> {
//  final CollectionReference products = FirebaseFirestore.instance.collection(
//     'products',
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
//         child: Column(
//           spacing: 10,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Location"),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Icon(Icons.location_on_outlined),
//                     Text(
//                       "Bengaluru,India",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Icon(Icons.keyboard_arrow_down_outlined),
//                   ],
//                 ),
//                 SizedBox(
//                   width: 25,
//                   height: 25,
//                   child: IconButton(
//                     onPressed: () {},
//                     icon: const Icon(
//                       Icons.notifications_outlined,
//                       size: 18,
//                       color: Colors.white,
//                     ),
//                     padding: EdgeInsets.zero,
//                     constraints: const BoxConstraints(),
//                     style: const ButtonStyle(
//                       backgroundColor: WidgetStatePropertyAll(Colors.green),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//              Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: [
//                  Container(
//                         height: 40,
//                         width: 400,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey),
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                         ),
//                         child: SearchBar(
//                           elevation: WidgetStatePropertyAll(0),
//                           shape: MaterialStateProperty.all(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           leading: Icon(Icons.search),
//                           hintText: "Search Orders",
//                         ),
//                       ),
//                       Container(
//                         height:40 ,
//                         width: 40,
//                         decoration: BoxDecoration(border: Border.all(),
//                         borderRadius: BorderRadius.all(Radius.circular(8))
//                         ),
//                         child: Icon(Icons.tune),
//                       )
//                ],
//              ),

//              BannerSlider(),

//              Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Category",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
//                 TextButton(onPressed: (){}, child: Text("See All",style: TextStyle(color: Colors.green),))
//               ],
//              ),
//              Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: [
//                  CategoryScroll(image: 'assets/veggie.png', name: 'Vegetables',),
//                  CategoryScroll(image: 'assets/fruits.png', name: "Fruits"),
//                  CategoryScroll(image: 'assets/veggie.png', name: 'Vegetables',),
//                  CategoryScroll(image: 'assets/fruits.png', name: "Fruits"),
//                 CategoryScroll(image: 'assets/veggie.png', name: 'Vegetables',),
//                ]
//              ),
//              Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Best Deal",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
//                 TextButton(onPressed: (){}, child: Text("See All",style: TextStyle(color: Colors.green),))
//               ],
//              ),
//              Expanded(
//                child: StreamBuilder<QuerySnapshot>(
//                  stream: products.snapshots(),
//                  builder: (context, snapshot) {
//                    if (!snapshot.hasData) {
//                      return const Center(child: CircularProgressIndicator());
//                    }

//                    var productList = snapshot.data!.docs;

//                    if (productList.isEmpty) {
//                      return const Center(child: Text("No products available"));
//                    }

//                    return GridView.builder(
//                      padding: const EdgeInsets.all(10),
//                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                        crossAxisCount: 2, // number of columns
//                        crossAxisSpacing: 10,
//                        mainAxisSpacing: 10,
//                        childAspectRatio: 0.75,
//                      ),
//                      itemCount: productList.length,
//                      itemBuilder: (context, index) {
//                        var product = productList[index];

//                        return Card(
//                          child: Padding(
//                            padding: const EdgeInsets.all(8),
//                            child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [

//                   Text(
//                     product['productName'],
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),

//                   const SizedBox(height: 5),

//                   Text("Category : ${product['category']}"),

//                   const SizedBox(height: 5),

//                   Text("Price : ₹${product['price']}"),

//                   const SizedBox(height: 5),

//                   if (product['stock'] == 0)
//                     const Text(
//                       "Out of stock",
//                       style: TextStyle(
//                         color: Colors.red,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),

//                   if (product['stock'] < 10 && product['stock'] > 0)
//                     const Text(
//                       "Limited stock",
//                       style: TextStyle(
//                         color: Colors.orange,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),

//                   const Spacer(),

//                   if (product['stock'] > 0)
//                     Column(
//                       children: [

//                         // ElevatedButton(
//                         //   onPressed: () {
//                         //     Map<String, dynamic> cartItem = {
//                         //       'name': product["productName"],
//                         //       'price': product["price"],
//                         //       'quantity': 1
//                         //     };

//                         //     context.read<CartProvider>().addToCart(cartItem);

//                         //     showAddPopup();
//                         //   },
//                         //   child: const Text("Add to cart"),
//                         // ),

//                         ElevatedButton(
//                           onPressed: () async {
//                             await FirebaseFirestore.instance
//                                 .collection('products')
//                                 .doc(product.id)
//                                 .update({
//                               'stock': FieldValue.increment(-1),
//                             });
//                           },
//                           child: const Text("Buy"),
//                         ),
//                       ],
//                     )
//                 ],
//                            ),
//                          ),
//                        );
//                      },
//                    );
//                  },
//                ),
//              )
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:office_project/widgets/bannerslider.dart';
// import 'package:office_project/widgets/category_scroll.dart';

// class UserHomescreen extends StatefulWidget {
//   const UserHomescreen({super.key});

//   @override
//   State<UserHomescreen> createState() => _UserHomescreenState();
// }

// class _UserHomescreenState extends State<UserHomescreen> {
//   final CollectionReference products = FirebaseFirestore.instance.collection(
//     'products',
//   );
//   Map<String, bool> likedProducts = {};
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [

//                 const SizedBox(height: 10),

//                 /// SEARCH BAR
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         height: 40,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: const SearchBar(
//                           elevation: WidgetStatePropertyAll(0),
//                           leading: Icon(Icons.search),
//                           hintText: "Search Products",
//                         ),
//                       ),
//                     ),

//                     const SizedBox(width: 10),

//                     Container(
//                       height: 40,
//                       width: 40,
//                       decoration: BoxDecoration(
//                         border: Border.all(),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: const Icon(Icons.tune),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 15),

//                 /// BANNER
//                 SizedBox(height: 150, child: const BannerSlider()),

//                 const SizedBox(height: 15),

//                 /// CATEGORY TITLE
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       "Category",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {},
//                       child: const Text(
//                         "See All",
//                         style: TextStyle(color: Colors.green),
//                       ),
//                     ),
//                   ],
//                 ),

//                 /// CATEGORY SCROLL
//                 SizedBox(
//                   height: 90,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: const [
//                       CategoryScroll(
//                         image: 'assets/veggie.png',
//                         name: 'Vegetables',
//                       ),
//                       CategoryScroll(
//                         image: 'assets/fruits.png',
//                         name: 'Fruits',
//                       ),
//                       CategoryScroll(
//                         image: 'assets/veggie.png',
//                         name: 'Vegetables',
//                       ),
//                       CategoryScroll(
//                         image: 'assets/fruits.png',
//                         name: 'Fruits',
//                       ),
//                       CategoryScroll(
//                         image: 'assets/veggie.png',
//                         name: 'Vegetables',
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 10),

//                 /// BEST DEAL TITLE
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       "Best Deal",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {},
//                       child: const Text(
//                         "See All",
//                         style: TextStyle(color: Colors.green),
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 10),

//                 /// PRODUCT GRID
//                 StreamBuilder<QuerySnapshot>(
//                   stream: products.snapshots(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator());
//                     }

//                     if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                       return const Center(child: Text("No products available"));
//                     }

//                     var productList = snapshot.data!.docs;

//                     return GridView.builder(
//                       shrinkWrap: true,
//                       physics: BouncingScrollPhysics(),
//                       itemCount: productList.length,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             crossAxisSpacing: 10,
//                             mainAxisSpacing: 10,
//                             childAspectRatio: 0.75,
//                           ),
//                       itemBuilder: (context, index) {
//                         var product = productList[index];
//                         return SizedBox(
//                           height: 238,
//                           width: 200,
//                           child: Card(
//                             child: Column(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 10.0,
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         height: 25,
//                                         width: 75,
//                                         decoration: BoxDecoration(
//                                           color: Colors.orange,
//                                           borderRadius: BorderRadius.all(
//                                             Radius.circular(5),
//                                           ),
//                                         ),

//                                         child: Center(
//                                           child: Text(
//                                             "Offer 3%",
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 15,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       IconButton(
//                                         onPressed: () {},
//                                         icon: Icon(
//                                           Icons.favorite,

//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Image(
//                                   image: AssetImage('assets/fruits.png'),
//                                   height: 120,
//                                 ),
//                                 Divider(
//                                   thickness: 1.5,
//                                   color: const Color.fromARGB(255, 72, 72, 73),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 10.0,
//                                     vertical: 3,
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         //name
//                                         product['productName'],
//                                         style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       Row(
//                                         spacing: 4,
//                                         children: [
//                                           Icon(
//                                             Icons.star,
//                                             color: Colors.amber,
//                                             size: 15,
//                                           ),
//                                           Text(
//                                             "4.9",
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 10.0,
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Text(
//                                             // price
//                                             "₹${product['price']}",
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           Text(
//                                             "kg",
//                                             style: TextStyle(
//                                               color: const Color.fromARGB(
//                                                 255,
//                                                 85,
//                                                 85,
//                                                 85,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       InkWell(
//                                         onTap: () {},
//                                         child: Container(
//                                           width: 55,
//                                           decoration: BoxDecoration(
//                                             color: Colors.green,
//                                             borderRadius: BorderRadius.all(
//                                               Radius.circular(4),
//                                             ),
//                                           ),
//                                           child: Center(
//                                             child: Text(
//                                               "Add",
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );

//                         // Card(
//                         //   elevation: 3,
//                         //   child: Padding(
//                         //     padding: const EdgeInsets.all(8),
//                         //     child: Column(
//                         //       crossAxisAlignment: CrossAxisAlignment.start,
//                         //       children: [

//                         //         // Text(
//                         //         //   product['productName'],
//                         //         //   style: const TextStyle(
//                         //         //       fontWeight: FontWeight.bold),
//                         //         // ),

//                         //         // const SizedBox(height: 5),

//                         //         // Text("Category : ${product['category']}"),

//                         //         // const SizedBox(height: 5),

//                         //         // Text("Price : ₹${product['price']}"),

//                         //         const SizedBox(height: 5),

//                         //         if (product['stock'] == 0)
//                         //           const Text(
//                         //             "Out of stock",
//                         //             style: TextStyle(
//                         //                 color: Colors.red,
//                         //                 fontWeight: FontWeight.bold),
//                         //           ),

//                         //         if (product['stock'] < 10 &&
//                         //             product['stock'] > 0)
//                         //           const Text(
//                         //             "Limited stock",
//                         //             style: TextStyle(
//                         //                 color: Colors.orange,
//                         //                 fontWeight: FontWeight.bold),
//                         //           ),

//                         //         const Spacer(),

//                         //         if (product['stock'] > 0)
//                         //           ElevatedButton(
//                         //             onPressed: () async {
//                         //               await FirebaseFirestore.instance
//                         //                   .collection('products')
//                         //                   .doc(product.id)
//                         //                   .update({
//                         //                 'stock': FieldValue.increment(-1),
//                         //               });
//                         //             },
//                         //             child: const Text("Buy"),
//                         //           ),
//                         //       ],
//                         //     ),
//                         //   ),
//                         // );
//                       },
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:office_project/screens/productdetailspage.dart';
import 'package:office_project/widgets/bannerslider.dart';
import 'package:office_project/widgets/category_scroll.dart';

class UserHomescreen extends StatefulWidget {
  const UserHomescreen({super.key});

  @override
  State<UserHomescreen> createState() => _UserHomescreenState();
}

class _UserHomescreenState extends State<UserHomescreen> {
  final CollectionReference products = FirebaseFirestore.instance.collection(
    'products',
  );

  Map<String, bool> likedProducts = {};

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
                        child: const SearchBar(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                          elevation: WidgetStatePropertyAll(0),
                          leading: Icon(Icons.search),
                          hintText: "Search Products",
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.tune),
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
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "See All",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),

                /// CATEGORY SCROLL
                SizedBox(
                  height: 90,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      CategoryScroll(
                        image: 'assets/veggie.png',
                        name: 'Vegetables', route: '/vegetable',
                      ),

                      CategoryScroll(
                        image: 'assets/fruits.png',
                        name: 'Fruits', route: '/fruits',
                      ),

                      CategoryScroll(
                        image: 'assets/veggie.png',
                        name: 'Grocery', route: '',
                      ),

                      CategoryScroll(
                        image: 'assets/fruits.png',
                        name: 'Dry Fruits', route: '',
                      ),

                      CategoryScroll(
                        image: 'assets/veggie.png',
                        name: 'Protein Powder', route: '/protein',
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
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "See All",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
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

                    var productList = snapshot.data!.docs;

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
      borderRadius: BorderRadius.all(Radius.circular(20)),
      onTap: () {
        Get.to( Productdetailspage());
       
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
                    child: const Text(
                      "Offer 3%",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
      
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      setState(() {
                        likedProducts[product.id] =
                            !(likedProducts[product.id] ?? false);
                      });
                    },
                    icon: Icon(
                      Icons.favorite,
                      size: 20,
                      color: likedProducts[product.id] == true
                          ? Colors.red
                          : Colors.grey,
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
      
                  Container(
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
