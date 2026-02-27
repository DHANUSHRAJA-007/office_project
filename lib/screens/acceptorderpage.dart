// import 'package:flutter/material.dart';
// import 'package:get/get_navigation/src/routes/default_transitions.dart';
// class Acceptorderpage extends StatelessWidget {
//   const Acceptorderpage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back,color: Colors.white),),
//         title: Text("Accept Order",style: TextStyle(color: Colors.white),),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListView(
//           scrollDirection: Axis.vertical,
//           children: [
//             Card(
//                 elevation: 3,
//               // color: Colors.grey,
//               child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Order ID: 123456",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,)
//                   ),
//                   Divider(color: Colors.grey, thickness: 1),
//                   Row(children: [
//                     SizedBox(child: CircleAvatar()),
//                     SizedBox(width: 10,),

//                     SizedBox(
//                       child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Emily Davis"),
//                           Text("+1 234 567 890"),
//                           Text("452 Maple Street, Springfield"),
//                         ],
//                       ),
//                     ),
//                   ],)


//                 ],
//               ),
//             ),
//                         SizedBox(height: 20,),
//             Card(
//              elevation: 3,
//               child: Column(
//               children: [
//                 Container(
//                   width: double.infinity,
//                    color: Colors.grey[300],
//                    child: Text("Product for delivery", 
//                    textAlign: TextAlign.left,
//                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),),
//                 ),
//                 Row(
//                   children: [
//                     SizedBox(
//                       child:CircleAvatar()

//                     ),SizedBox(width: 10,),
//                     Column(crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Product Name"),
//                         Text("Grocery Hub"),
//                         Text("Price: \$50.00/2kg"),
//                       ],
//                     )
//                   ],
//                 ),
//                 Divider(color: Colors.grey, thickness: 1),
//                  Row(
//                   children: [
//                     SizedBox(
//                       child: CircleAvatar()

//                     ),SizedBox(width: 10,),
//                     Column(crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Product Name"),
//                         Text("Grocery Hub"),
//                         Text("Price: \$50.00/2kg"),
//                       ],
//                     )
//                   ],
//                 ),

//               ],
//             ),
//             ),
//             SizedBox(height: 20,),
//             Card(
//               elevation: 3,
//               child: Column(
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     color: Colors.grey[300],
//                     child: Text("Buyer Details", 
//                     textAlign: TextAlign.left,
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),),
//                   ),
//                   Row(
//                     children: [
//                       SizedBox(
//                         child: CircleAvatar()

//                       ),SizedBox(width: 10,),
//                       Column(crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Emily Davis"),
//                           // Text("+1 234 567 890"),
//                           Text("452 Maple Street, Springfield \n bangalore"),
//                         ],
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             Card(
//               elevation: 3,
//               child: Column(
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     color: Colors.grey[300],
//                     child: Text("Special Instructions", 
//                     textAlign: TextAlign.left,
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
                    
//                       Column(crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Please deliver between 5-6 PM."),
//                           Text("Leave the package at the front door if no one is home."),
//                           Divider(color: Colors.grey, thickness: 2),
//                           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                              SizedBox(child: Text("total Amount",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                             
//                              SizedBox(child: Text(  "\$100.00",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
//                         ],
//                       )
                      
//                     ],
//                   )
//                 ],
//               ),]
//             )
          
//             ),
//             SizedBox(height: 20,),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                       ElevatedButton(
//               onPressed: (){}, 
//               child: Text("Reject", style: TextStyle(color: Colors.white)),
//               style: ElevatedButton.styleFrom(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),fixedSize: Size(160, 40),
//               backgroundColor: Colors.red,
            
//             ),),
//             ElevatedButton(
//               onPressed: (){},
//                child: Text("Accept Order",style: TextStyle(color: Colors.white),),
//                style: ElevatedButton.styleFrom(
//                 shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),fixedSize: Size(160, 40),
//               backgroundColor: Colors.green,
              
//             ),)
//             ],)
           
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:office_project/widgets/buyercard.dart';
import 'package:office_project/widgets/buyerinstructioncard.dart';
import 'package:office_project/widgets/ordercard.dart';
import 'package:office_project/widgets/productcard.dart';

class Acceptorderpage extends StatelessWidget {
  const Acceptorderpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          "Accept Order",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              /// Scrollable Content
              Expanded(
                child: ListView(
                  children: [

                    /// ORDER CARD
                    ordercard(),

                    const SizedBox(height: 16),

                    Productcard(),

                    const SizedBox(height: 16),

                    /// BUYER DETAILS
                    Buyercard(),

                    const SizedBox(height: 16),

                    /// SPECIAL INSTRUCTIONS
                  Buyerinstructioncard()
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// BUTTONS
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Reject",style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text("Accept Order",style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  
  
 



 
}
