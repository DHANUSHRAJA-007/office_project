import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:office_project/screens/fruitspage.dart';
import 'package:office_project/screens/maltpage.dart';
import 'package:office_project/screens/user_category/user_fruits.dart';
import 'package:office_project/screens/user_category/user_protein.dart';
import 'package:office_project/screens/user_category/user_vegetables.dart';

class CategoryScroll extends StatelessWidget {
  final String image,name,route;
  const CategoryScroll({super.key, required this.image, required this.name, required this.route});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          onTap: () {
            if (route=='/vegetable')
            {
              Get.to(
                UserVegetables());
            }
            else if(route=='/fruits'){
              Get.to(UserFruits());
            }
            else if(route=='/protein')
            {
              Get.to(UserProtein());
            }
          },
          child: Container(
            height: 70,width: 70,
            decoration: BoxDecoration(
             boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // shadow color
              spreadRadius: 1, // how much the shadow spreads
              blurRadius: 8, // softness of shadow
              offset: Offset(0, 4), // position of shadow (x,y)
            ),
          ],
              shape: BoxShape.circle
            ),
            child: Card(
              shape: CircleBorder(),
              elevation: 7,
              child: Image.asset(image),
            ),
          ),
        ),
        Text(name)
      ],
      
    );
  }
}