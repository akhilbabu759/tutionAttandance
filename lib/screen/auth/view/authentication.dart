import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tution_attand/screen/auth/controller/auth_controller.dart';
import 'package:tution_attand/screen/auth/view/widget/my_button.dart';
import 'package:tution_attand/screen/auth/view/widget/my_textfield.dart';
import 'package:tution_attand/screen/student/view/student_screen.dart';
import 'package:tution_attand/screen/teacher/view/teacher_screen.dart';



class LoginPage extends StatelessWidget {
  LoginPage({super.key});
final contro=Get.put(AuthController());


  void signUserIn() {
    print('object');
    log('ggg');
    contro.signin(email:contro.usernameController.text ,password: contro.passwordController.text);
    
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 50),
            const Icon(
              Icons.lock,
              size: 100,
            ),
            const SizedBox(height: 50),
            GetBuilder<AuthController>(builder: (controller) {
              return Text(
                '${controller.userCheck?'Student':'Teacher'} Login Page',
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              );}
            ),
            const SizedBox(height: 25),
            MyTextField(
              controller:contro. usernameController,
              hintText: 'Email',
              obscureText: false,
            ),
            const SizedBox(height: 10),
            MyTextField(
              controller:contro. passwordController,
              hintText: 'Password',
              obscureText: true,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            MyButton(
              onTap: signUserIn,
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                  
            
                ]
      ),
      
    ),
    Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GetBuilder<AuthController>(builder: (controller) {
          return ElevatedButton(onPressed: () {
            controller.usercheckfun(!controller.userCheck);
            
          }, child: Center(child: Text('Login as ${controller.userCheck?'Teacher':'Student'}'),));
        },
        ),
      ],
    )
    
    ]))));
  }
}