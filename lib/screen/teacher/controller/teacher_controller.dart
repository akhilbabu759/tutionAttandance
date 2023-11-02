import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:tution_attand/core/them/style.dart';
import 'package:tution_attand/screen/teacher/model/stu_model.dart';
import 'package:tution_attand/screen/teacher/model/teacher_model.dart';
class TeacherController extends GetxController{

 List<Student> filterStudent=[];
 List<Student> listStudent=[];
 List<String> filterStatuslist=[];
 List<String> filterKeyList=['7-a','7-b'];
String classValue='';
Map<String, List<Student>> classBasedStudent={};

 void filterstatus(){
  filterStatuslist.clear();
  List<Student> ?loc=classBasedStudent[classValue]!.toList();
        log(loc[1].status.toString(),name: 'ghjbjbjhvh ');
        log(classValue);
        for(int i=0;i<loc.length;i++){
          
          filterStatuslist.add(loc![i].status);
          update();
          log('message7');
        }
        log(filterStatuslist.toString());

  update();
 }
void updateSelectedValue(String val){
  classValue=val;
  update();
  filterstatus();
  update();

}
  void statusUpdate(String val,int i){
    filterStatuslist[i]=val;
    update();

  }

  // void filtertheStudent(List<Student> li){
  //   filterStudent.clear();
  //   for(int i=0;i<=li.length;i++){
  //     filterStudent.add(li[i])

  //   }
  //   filterStudent


  // }


Future<void> getTeacherData() async {
  log('message');
  try {
    final DocumentReference teacherDocument =
        FirebaseFirestore.instance.collection('teacher').doc(FirebaseAuth.instance.currentUser!.email??'akhilb401@gmail.com');

    final DocumentSnapshot teacherSnapshot = await teacherDocument.get();
    log('message2');
      log(teacherSnapshot.data().toString(),name: 'jhfklm');
    if (teacherSnapshot.exists) {
      final Map<String, dynamic>? classData = teacherSnapshot.data() as Map<String, dynamic>?;
      log(classData.toString(),name: 'no');
      log('message3');
      if (classData != null) {
        listStudent.clear();
        filterKeyList.clear();
        filterStatuslist.clear();

        // Separate students into class-specific lists
        final Map<String, List<Student>> classStudentMap = {};

        classData.forEach((className, students) {
          if (students is List) {
            log('message4');
            final List<Student> studentsForClass = [];

            for (var studentData in students) {
              final Student student = Student.fromJson(studentData as Map<String, dynamic>);
              studentsForClass.add(student);
            }

            classStudentMap[className] = studentsForClass;
            log('message5');
          }
        });

        // Store class-specific student lists
        classStudentMap.forEach((className, students) {
          listStudent.addAll(students);
          filterKeyList.add(className);
          log('message6');
          update();
           // Assumes that the first student's status is used
        });
        
        classBasedStudent=classStudentMap;
        update();
        log(filterStatuslist.toString(),name: '1');
        log(filterKeyList.toString(),name: '2');
        log(listStudent.toString(),name: '3');
        log(classStudentMap.toString(),name: '4');
        log('message9');

        classValue = filterKeyList[0];
        update();
        filterstatus();
        log(filterStatuslist.toString(),name: 'njan');
        update();
      } else {
        log('messageuio');
        // Handle case where 'class' field is missing or empty
      }
    } else {
      log('messagehgjk');
      // Handle case where teacher document does not exist
    }
  } catch (e) {
    log(e.toString(),name: '1900');
    print('Error fetching teacher data: $e');
    update();
  }
  update();
}



Future<void> updateStatusInFirestore(String className, List<Student> updatedStudents) async {
  log('update call');
  log(updatedStudents[0].status);
  try {
    final DocumentReference teacherDocument = FirebaseFirestore.instance.collection('teacher').doc(FirebaseAuth.instance.currentUser!.email);
    log('update call2');
    // Get the current data from Firestore
    final DocumentSnapshot teacherSnapshot = await teacherDocument.get();
    log('update call3');
    final Map<String, dynamic>? classData = teacherSnapshot.data() as Map<String, dynamic>?;
    log(classData.toString(),name: 'loppp');
    log(teacherSnapshot.data().toString(),name: '90504950');
    log('update call4');

    if (classData != null) {
      log('update call5');
      final List<Map<String, dynamic>> existingStudents = List<Map<String, dynamic>>.from(classData[className]);
log('update call6');
      // Update the status of existing students
      for (int i = 0; i < updatedStudents.length; i++) {
        log('update call7');
        existingStudents[i]['status'] = updatedStudents[i].status!;
        existingStudents[i]['date']=DateFormat('dd/MM/yyyy').format(DateTime.now());

      }
      log('update call8');

      // Update the Firestore document
      await teacherDocument.update({className: existingStudents});
      log('update call9');
      getTeacherData();
    }
    Get.snackbar('Success', 'successfully Updated',backgroundColor: Colors.green,colorText: Colors.black);
  } catch (e) {
    log(e.toString());
    print('Error updating status in Firestore: $e');
  }
}






  
}