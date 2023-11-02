import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tution_attand/core/them/style.dart';
import 'package:tution_attand/screen/teacher/controller/teacher_controller.dart';
import 'package:tution_attand/screen/teacher/model/teacher_model.dart';
import 'package:tution_attand/screen/teacher/view/widget/status_widget.dart';
import 'package:intl/intl.dart';

class TeacherScreen extends StatelessWidget {
  const TeacherScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    final contro =Get.put(TeacherController());
    contro.getTeacherData();
    // log(.toString(),name: 'newop');
    
   
    return Scaffold(
      backgroundColor: Styleapp().bkcol,
      body: GetBuilder<TeacherController>(builder: (controller) {
      
        return contro.classValue.isEmpty?Center(child: CircularProgressIndicator(),): Column(children: [
          Container(
            color: Styleapp().blu,
            height: Get.height * 0.17,
            child: Padding(
              padding:
                  EdgeInsets.only(top: Get.height * 0.06, left: 10, right: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(onTap: () {
                      FirebaseAuth.instance.signOut();
                      
                      Get.back();
                      Get.snackbar('SiginOut', 'User SiginOuted');
                    },
                      child: CircleAvatar(
                        backgroundColor: Styleapp().whit,
                        radius: 19,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Styleapp().blu,
                          child: Icon(Icons.arrow_back_ios_new),
                        ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: Get.height * 0.05,
                      width: Get.width * 0.45,
                      decoration: BoxDecoration(
                          color: Styleapp().whit,
                          border: Border.all(
                            color: Styleapp().blu,
                            width: 0.4,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Center(
                          child: Text(
                        '${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                        style: TextStyle(
                            color: Styleapp().blu, fontWeight: FontWeight.bold),
                      )),
                    ),
                    Container(
                      height: Get.height * 0.05,
                      width: Get.width * 0.45,
                      decoration: BoxDecoration(
                          color: Styleapp().whit,
                          border: Border.all(
                            color: Styleapp().blu,
                            width: 0.4,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child:
                       Center(
                         child:
                          DropdownButton(underline: Text(''),style: TextStyle(fontWeight: FontWeight.bold,color: Styleapp().blu),
                                     value: controller.classValue,
                                     items: controller.filterKeyList.map((String item) {
                                       return DropdownMenuItem(
                                         value: item,
                                         child: Text(item),
                                       );
                                     }).toList(),
                                     onChanged: (value) {
                                       controller.updateSelectedValue(value!);
                                     },
                                   ),
                       ),
                      //  Center(
                      //     child: Text(
                      //   'Class 7-A',
                      //   style: TextStyle(
                      //       color: Styleapp().blu, fontWeight: FontWeight.bold),
                      // )),
                    )
                  ],
                ),
                
              ],
            ),
          ),
          Expanded(
                  child: ListView.builder(itemCount: contro.classBasedStudent[contro.classValue]!.length,
                    itemBuilder: (context, index) {
                       
                      log(index.toString());
                    return Padding(
                      padding: const EdgeInsets.only(left:10.0,right:10,bottom: 10),
                      child: Container(
                        height: Get.height * 0.18,
                        width: Get.width,
                        decoration: BoxDecoration(
                            color: Styleapp().whit,
                            border: Border.all(
                              color: Styleapp().blu,
                              width: 0.4,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(radius: Get.width*0.055,
                                    child: Text(
                                    contro.classBasedStudent[contro.classValue]![index].name.toString().substring(0,1).toUpperCase()??'',
                                    
                                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: Get.width*0.05),
                                    ),
                                  ),SizedBox(width: 8,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(contro.classBasedStudent[contro.classValue]![index].name,
                                        // contro.listStudent[index].classes[contro.classValue]!['name']??'',
                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: Get.width*0.04),
                                      ),
                                      Text(contro.classBasedStudent[contro.classValue]![index].rollno,
                                        // 'Roll No: ${contro.listStudent[index].classes[contro.classValue]!['rollno']}',
                                        style: TextStyle(color: const Color.fromARGB(255, 185, 184, 180)),)
                                    ],
                                  )
                                ],
                              ),
                              Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                                GestureDetector(onTap: () =>contro. statusUpdate('Present',index),
                                  child: statusWidget(tex: 'Present',updator:contro.filterStatuslist[index] )),
                                GestureDetector(onTap: () =>contro. statusUpdate('Absent',index),
                                  child: statusWidget(tex: 'Absent',updator:contro.filterStatuslist[index] )),
                                GestureDetector(onTap: () =>contro. statusUpdate('Leave',index),
                                  child: statusWidget(tex: 'Leave',updator:contro.filterStatuslist[index] )),
                                    
                              ],)
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:10.0,right: 10),
                  child: SizedBox(width: Get.width,height: Get.height*0.08,
                    child: Padding(
                      padding: const EdgeInsets.only(top:8.0,bottom: 8),
                      child: ElevatedButton(
                        onPressed: () {int i=-1;
                        contro.updateStatusInFirestore(contro.classValue,contro.classBasedStudent[contro.classValue]!.map((e) {i++; return Student(name: e.name, rollno: e.rollno, status: contro.filterStatuslist[i]);} ).toList());
                          // contro.updateStatusInFirestore(contro.classValue,contro.classBasedStudent[contro.classValue].map((e) {

                          //  return  e.status=contro.filterStatuslist[i]}));
                        
                      }, child: Text('Submit')),
                    ),
                  ),
                )
        ]);
      },
      ),
    );
  }
}

