import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tution_attand/screen/student/view/student_screen.dart';
import 'package:tution_attand/screen/teacher/view/teacher_screen.dart';

class AuthController extends GetxController{
  bool userCheck=true;
    final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  User ?get currentUser=>firebaseAuth.currentUser;
  Stream<User?> get authStateChange => firebaseAuth.authStateChanges();



void usercheckfun(bool valu){
  userCheck=valu;
  update();
}
  Future<void> signin({required String email,required String password})async{
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password
    );
    String userEmailAddress = userCredential.user!.email!;

// Create a Firestore reference for the user's collection
CollectionReference userCollection = FirebaseFirestore.instance.collection('teacher');

// Create a document in the user's collection with the user's email as the document ID
DocumentReference userDocument = userCollection.doc(userEmailAddress);

// Define the data you want to add to the document
Map<String, dynamic> userData = {
  '7-A': [
    {'name': 'manu', 'rollno': '489', 'status': ''},
    {'name': 'anu', 'rollno': '789', 'status': ''},
  ],
  '7-B': [
    {'name': 'shibu', 'rollno': '768', 'status': ''},
    {'name': 'ramu', 'rollno': '454', 'status': ''},
  ],
};

// Add the data to the Firestore document
userDocument.set(userData).then((value) {
  print('Document added successfully');
}).catchError((error) {
  print('Error adding document: $error');
});

    if(usernameController.text !='' && passwordController.text!='' &&usernameController.text.contains('@gmail.com')){
            
          userCheck?Get.to(StudentScreen()): Get.to(TeacherScreen());
    }
    else{
      Get.snackbar('Enter correct email format', 'Entre email and password properly');
    }
    
  } on FirebaseAuthException catch (e) {
    log(e.code. toString());
    if (e.code == 'email-already-in-use') {
      try{
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if(usernameController.text !='' && passwordController.text!='' &&usernameController.text.contains('@gmail.com')){
           
          userCheck?Get.to(StudentScreen()): Get.to(TeacherScreen());
      
   }
    else{
      

      Get.snackbar('Enter correct email format', 'Entre email and password properly');
    }
     } on FirebaseAuthException catch(e){
      Get.snackbar('Enter correct email format', 'Entre email and password properly');
      log(e.toString());
    }
    } else {
      Get.snackbar('Enter correct email format', 'Entre email and password properly');
      log(e.toString());
      print('Error: ${e.message}');
    }
  }
}




   
    
    

  

  



}