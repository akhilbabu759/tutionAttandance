import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tution_attand/core/them/style.dart';

class TeacherScreen extends StatelessWidget {
  const TeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styleapp().bkcol,
      body: Column(children: [
        Container(
          color: Styleapp().blu,
          height: Get.height * 0.17,
          child: Padding(
            padding:
                EdgeInsets.only(top: Get.height * 0.06, left: 10, right: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Styleapp().whit,
                    radius: 19,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Styleapp().blu,
                      child: Icon(Icons.arrow_back_ios_new),
                    ),
                  ),
                  Text(
                    'Attendance',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Styleapp().whit),
                  ),
                  Icon(
                    Icons.search,
                    size: 24,
                    color: Styleapp().whit,
                  )
                ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Center(child: Text('17/07/2023',style: TextStyle(color: Styleapp().blu,fontWeight: FontWeight.bold),)),
                    height: Get.height * 0.05,
                    width: Get.width * 0.45,
                    decoration: BoxDecoration(color: Styleapp().whit,
                        border: Border.all(
                          color: Styleapp().blu,
                          width: 0.4,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ), Container(
                    child: Center(child: Text('Class 7-A',style: TextStyle(color: Styleapp().blu,fontWeight: FontWeight.bold),)),
                    height: Get.height * 0.05,
                    width: Get.width * 0.45,
                    decoration: BoxDecoration(color: Styleapp().whit,
                        border: Border.all(
                          color: Styleapp().blu,
                          width: 0.4,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  )
                ],
              ),
              Container(
                    height: Get.height * 0.18,
                    width: Get.width ,
                    decoration: BoxDecoration(color: Styleapp().whit,
                        border: Border.all(
                          color: Styleapp().blu,
                          width: 0.4,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Column(
                      children: [
                        
                      ],
                    ),
                  )
            ],
          ),
        )
      ]),
    );
  }
}
