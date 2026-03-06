import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Successpage extends StatelessWidget {
  const Successpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(onPressed: (){
        Get.back();
      }, icon: Icon(Icons.arrow_back_ios)),),
      body: Column(
        children: [
          SizedBox(
            height: 250,
          ),
          Center(child: Text("    Your Order Is \nSuccessfully Done",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25
          ),)),

          SizedBox(
            height: 180,
          ),

          Divider(thickness: 3,),
          Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
          child: InkWell(
            onTap: () {
              
            },
            child: Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Center(
                child: Text("View Order",style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
                ),),
              ),
            ),
          ),
          ),
          TextButton(onPressed: (){}, child:  Text("View E-Receipt",style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18
              ),),)
        ],
      ),
    );
  }
}