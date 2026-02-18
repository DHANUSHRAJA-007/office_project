// import 'package:flutter/material.dart';
// import 'package:office_project/widgets/buyercard.dart';
// class Paymentdetailspage extends StatelessWidget {
//   const Paymentdetailspage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back,color: Colors.white),),
//         title: Text("Payment Details",style: TextStyle(color: Colors.white),),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//             Text("Invoice # INV-1023",
//             style: TextStyle(fontSize: 18, 
//               fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           SizedBox(child: CircleAvatar()
//                           ),
//                           SizedBox(width: 10),
//                           SizedBox(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text("Emily Davis",style: TextStyle(fontWeight: FontWeight.bold),),
//                                 Text("+1 234 567 890"),
//                                 Text("emilydavis@gmail.com"),
                              
                               
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                         Divider(thickness: 1,color: Colors.grey,),
//                        Row(
//                                   children: [
//                                     Icon(Icons.location_on,color: Colors.grey,),
//                                     Text("452 Maple Street, Springfield"),
//                                   ],
//                                 )
//                     ],
//                   ),
//                 ),
                
//               ),
//               SizedBox(height: 20),
//               Card(
//                 child: Padding(padding:   const EdgeInsets.all(8.0),
//                 child: Column(children: [
//                   Container(
//                     width: double.infinity,
//                     color: Colors.grey[300],
//                     child: Text("Order Summary",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
//                   ),
//                   ListTile(
//                     leading: Text("2x fresh tomatoes "),
//                     trailing: Text("\$4.00"),
//                   ),
//                   Divider(thickness: 1,color: Colors.grey,),
//                   ListTile(
//                     leading: Text("1x whole wheat bread"),
//                     trailing: Text("\$3.00"),
//                   ),
//                   Divider(thickness: 1,color: Colors.grey,),
//                   ListTile(
//                     leading: Text("5x organic eggs"),
//                     trailing: Text("\$10.00"),
//                   ),
//                   Divider(thickness: 1,color: Colors.grey,),
//                   ListTile(
//                     leading: Text("Sub Total"),
//                     trailing: Text("\$17.00"),
//                   ),
//                   Divider(thickness: 1,color: Colors.grey,),
//                   ListTile(
//                     leading: Text("Delivery Fee"),
//                     trailing: Text("\$2.00"),
//                   ),
//                   Divider(thickness: 1,color: Colors.grey,),
//                   ListTile(
//                     leading: Text("Total Amount",style: TextStyle(fontWeight: FontWeight.bold),),
//                     trailing: Text("\$19.00",style: TextStyle(fontWeight: FontWeight.bold),),
//                   )
//                 ],
//                 ),
//               )
//               ),
//               SizedBox(height: 20),
//               Card(
//                 child: Padding(padding: const EdgeInsets.all(8.0),
//                 child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Payment Information",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 10),
//                     Card(
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                       child: Column(
//                         children: [
//                           ListTile(
//                             tileColor: Colors.green,
//                             textColor: Colors.white,
//                             title: Text("Strips",
                           
//                               ),
//                               trailing: Text("**** **** **** 1234",
                            
//                               )
//                           ),
//                           ListTile(
//                             tileColor: Colors.lightGreen,
//                             textColor: Colors.black,
//                             title: Text("Sara"),
//                             trailing: Text("Exp: 12/25| VISA"),
//                           )
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Text("Payment date: June 15, 2024"),
//                     Text("Payment method: Credit Card"),
//                     Text("Cardholder name: Sara"),
//                     SizedBox(height: 20),
//                     Divider(thickness: 1,color: Colors.grey,),
//                     Text("Transaction ID: TXN-789456123"),
//                     ElevatedButton(onPressed: (){}, child: Text("Generate Invoice"))
//                   ],
//                 )),
//               )
              
        
//             ],
//           ),
//         ),
//       ),
//       );
//   }
// }


import 'package:flutter/material.dart';

class Paymentdetailspage extends StatelessWidget {
  const Paymentdetailspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          "Payment Details",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Invoice
              const Text(
                "Invoice # INV-1023",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              /// Customer Card
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(radius: 25),
                          const SizedBox(width: 12),
                          Expanded(   // <-- FIXED overflow
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: const [
                                Text("Emily Davis",
                                    style: TextStyle(
                                        fontWeight:
                                            FontWeight.bold)),
                                SizedBox(height: 4),
                                Text("+1 234 567 890"),
                                SizedBox(height: 4),
                                Text("emilydavis@gmail.com"),
                              ],
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 12),
                      const Divider(),

                      const SizedBox(height: 8),

                      Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: const [
                          Icon(Icons.location_on,
                              color: Colors.grey, size: 18),
                          SizedBox(width: 6),
                          Expanded(   // <-- FIXED overflow
                            child: Text(
                                "452 Maple Street, Springfield"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Order Summary Card
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Order Summary",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 12),

                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title:
                            const Text("2x fresh tomatoes"),
                        trailing: const Text("\$4.00"),
                      ),
                      const Divider(),

                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text(
                            "1x whole wheat bread"),
                        trailing: const Text("\$3.00"),
                      ),
                      const Divider(),

                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title:
                            const Text("5x organic eggs"),
                        trailing: const Text("\$10.00"),
                      ),

                      const Divider(height: 24),

                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text("Sub Total"),
                        trailing: const Text("\$17.00"),
                      ),

                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title:
                            const Text("Delivery Fee"),
                        trailing: const Text("\$2.00"),
                      ),

                      const Divider(height: 24),

                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text(
                          "Total Amount",
                          style: TextStyle(
                              fontWeight:
                                  FontWeight.bold),
                        ),
                        trailing: const Text(
                          "\$19.00",
                          style: TextStyle(
                              fontWeight:
                                  FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Payment Info Card
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Payment Information",
                        style: TextStyle(
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 18),
                      ),

                      // const SizedBox(height: 12),

                      // Container(
                      //   width: double.infinity,
                      //   padding:
                      //       const EdgeInsets.all(14),
                      //   decoration: BoxDecoration(
                      //     color: Colors.green.shade50,
                      //     borderRadius:
                      //         BorderRadius.circular(10),
                      //   ),
                      //   child: Column(
                      //     crossAxisAlignment:
                      //         CrossAxisAlignment.start,
                      //     children: [
                      //       Container(
                      //         color: Colors.greenAccent,
                      //         child: 
                      //        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //          children: [
                      //            Text("Stripe",style: TextStyle(color: Colors.white),),
                      //           const SizedBox(height: 6),
                      //       const Text(
                      //           "**** **** **** 1234"),
                      //          ],
                      //        )),
                           
                      //       const SizedBox(height: 6),
                      //       const Text(
                      //           "Sara | Exp: 12/25 | VISA"),
                      //     ],
                      //   ),
                      // ),

                      const SizedBox(height: 16),
                      RichText(
                        text: TextSpan(
                          text: "Payment Date  : ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),children: [
                            TextSpan(
                              text: "June 15, 2024",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            )
                          ]
                        ),
                      ),
                      RichText(
                          text: TextSpan(
                            text: "Payment Method: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),children: [
                              TextSpan(
                                text: "Credit Card ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              )
                            ]
                          )),
                       RichText(
                          text: TextSpan(
                            text: "Cardholder       : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: "Sara",
                                style: TextStyle(
                                 fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                              )
                            ]
                          ),
                          ),

                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 8),

                      RichText(
                        text: TextSpan(
                          text: "Transaction ID: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: "TXN-789456123",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton
                              .styleFrom(
                            backgroundColor:
                                Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(8)) ,
                            padding:
                                const EdgeInsets
                                    .symmetric(
                                        vertical: 14),
                          ),
                          onPressed: () {},
                          child: const Text(
                              "Generate Invoice",style: TextStyle(color: Colors.white ),),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
