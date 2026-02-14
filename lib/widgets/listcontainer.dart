import 'package:flutter/material.dart';
class Listcontainer extends StatelessWidget {
  const Listcontainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      
      
      child: Card(
       
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            spacing: 5,
            children: [
              SizedBox(
                width: 60,
                child: Image.asset("assets/v1.jpg"),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: SizedBox(
                    
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("name"),
                        Text("catagories"),
                        Text("₹250/1 kg")
                      ],
                    ),),
              ),
              
                
                  
                      SizedBox(
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Container(
                        width: double.infinity,
                        color: Colors.green,
                        padding: const EdgeInsets.all(4),
                        child: const Text(
                          "in_stock",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                          
                    
                  ]))
                    
                  
                
            ],
          ),
        ),
      ),
    )
    ;
  }
}