// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:office_project/screens/view_productpage.dart';

// class Productdetailspage extends StatefulWidget {
//   const Productdetailspage({super.key});

//   @override
//   State<Productdetailspage> createState() => _ProductdetailspageState();
// }

// class _ProductdetailspageState extends State<Productdetailspage> {
//   bool isliked = false;

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
//               Text(
//                 "Product Details",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     isliked = !isliked;
//                   });
//                 },
//                 icon: Icon(
//                   Icons.favorite,
//                   color: isliked ? Colors.white : Colors.red,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             width: double.infinity,
//             child: Icon(Icons.image),
//             height: size.height * 0.4,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Productname",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Text("category"),
//                     Text("ratings"),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Text(
//                         "Price",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 10),
//           SizedBox(height: 100, child: Text("Product description")),
//           Divider(),
//           Text("More ", style: TextStyle(fontWeight: FontWeight.bold)),
//           SizedBox(height: 10),
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('products')
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return Text("no products available");
//                 }
//                 return GridView.builder(
//             padding: const EdgeInsets.all(12),
//             itemCount: snapshot.data!.docs.length,
//             gridDelegate:
//                 const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 12,
//               mainAxisSpacing: 12,
//               childAspectRatio: 0.75,
//             ),
//             itemBuilder: (context, index) {
//               var product = snapshot.data!.docs[index];
//               var data =
//                   product.data() as Map<String, dynamic>;

//               return  Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.shade300,
//                         blurRadius: 5,
//                         spreadRadius: 2,
//                       ),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Column(
//                       crossAxisAlignment:
//                           CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           data['productName'] ?? '',
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                         const SizedBox(height: 6),
//                         Text(
//                           data['description'] ?? '',
                          
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                               color: Colors.grey),
//                         ),
//                         const Spacer(),
//                         Text(
//                           "₹ ${data['price']}",
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.green,
//                           ),
//                         ),
//                         const SizedBox(height: 5),
//                         Text(
//                           "Stock: ${data['stock']} ${data['unit']}",
//                           style:
//                               const TextStyle(fontSize: 12),
//                         ),
//                       ],
//                     ),
//                   ),
              
//               );
//             },
//           );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class Productdetailspage extends StatefulWidget {
  const Productdetailspage({super.key});

  @override
  State<Productdetailspage> createState() => _ProductdetailspageState();
}

class _ProductdetailspageState extends State<Productdetailspage> {
  bool isliked = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(onPressed: () {
                Get.back();
              }, icon: const Icon(Icons.arrow_back)),
              
        automaticallyImplyLeading: false,
        centerTitle: true,
        title:  Text(
                  "Product Details",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                               ),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TOP BAR
          

          /// PRODUCT IMAGE
          SizedBox(
            width: double.infinity,
            height: size.height * 0.4,
            child: const Icon(Icons.image),
          ),

          /// PRODUCT INFO
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Productname",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("category"),
                    Text("ratings"),
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Price",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          const SizedBox(height: 100, child: Text("Product description")),

          const Divider(),

          const Text(
            "More ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          /// PRODUCT LIST
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('products')
                  .snapshots(),
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text("no products available");
                }

               return SizedBox(
  height: 300, // important for horizontal list
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.all(12),
    itemCount: snapshot.data!.docs.length,
    itemBuilder: (context, index) {

      var product = snapshot.data!.docs[index];
      var data = product.data() as Map<String, dynamic>;

      return Container(
        width: 170,
        margin: const EdgeInsets.only(right: 12),

        child: Card(
          elevation: 7,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),

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
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    // IconButton(
                    //   padding: EdgeInsets.zero,
                    //   constraints: const BoxConstraints(),
                    //   onPressed: () {
                    //     setState(() {
                    //       isliked = !isliked;
                    //     });
                    //   },
                    //   icon: Icon(
                    //     Icons.favorite,
                    //     size: 20,
                    //     color: isliked ? Colors.red : Colors.grey,
                    //   ),
                    // ),
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
                  data['productName'] ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                /// PRICE + ADD BUTTON
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      "₹${data['price']}/kg",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
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
    },
  ),
);
              },
            ),
          ),
        ],
      ),
    );
  }
}