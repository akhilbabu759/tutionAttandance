import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tution_attand/core/them/style.dart';
import 'package:tution_attand/screen/teacher/controller/teacher_controller.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
   final contr= Get.put(TeacherController());
   contr.getTeacherData();

    return  Scaffold(
      body: GetBuilder<TeacherController>(builder: (controller) {
             return controller.classBasedStudent.isEmpty?Center(child: CircularProgressIndicator(),): Column(children: [
              Container(
                color: Styleapp().blu,
                height: Get.height * 0.3,
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
                            radius: 16,
                            backgroundColor: Styleapp().blu,
                            child: Icon(Icons.arrow_back_ios_new),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(top:Get.height*0.05),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text(controller.classBasedStudent['7-A']![0].name,style: TextStyle(color: Styleapp().whit,fontWeight: FontWeight.bold,fontSize: 25),),
                            Text('class: 7',style: TextStyle(color: const Color.fromARGB(255, 228, 227, 227),fontSize: 20),),
                            Text('Roll: ${controller.classBasedStudent['7-A']![0].rollno}',style: TextStyle(color: Color.fromARGB(255, 228, 227, 227),fontSize: 20),)
                          ],),
                        ),
                        
             
                         Image.network('https://cdn-icons-png.flaticon.com/512/5917/5917136.png',fit: BoxFit.fitHeight,)
                        
                        
                      ]),
                ),
                       )
             
             ,
            Container(
              height: Get.height*0.075,width: Get.width,
              decoration: BoxDecoration(
                color: Styleapp().whit,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),boxShadow: [BoxShadow(color: Colors.black,blurRadius: 5,blurStyle: BlurStyle.outer ),BoxShadow(color: Colors.white,spreadRadius: 2)]
              ),
              child: Center(child: Text('Your attandance this week',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
            ),
            Expanded(child: ListView.builder(itemCount: 6,
              itemBuilder: (context, index) {
                List<String> day=['Monday','Tuesday','Wednesday','Thrusday','Friday','Saturday'];
                return Card(
                  child: ListTile(leading: Text(day[index],style: TextStyle(fontWeight: FontWeight.bold,),),
                    trailing: Text(index==3 ||index==5?'A':'P',style: TextStyle(fontWeight: FontWeight.bold,fontSize: Get.height*0.025,color:index==3 ||index==5?Colors.red: Colors.green)),
                  ),
                );
              },)),
              Container(
                  height: Get.height*0.13,width: Get.width,color: Styleapp().whit,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RichText(
        text: TextSpan(
          // style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
        TextSpan(
          text: 'Total Apresent: ',
          style: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black, // Color for the text "Total Absent: "
          ),
        ),
        TextSpan(
          text: '4', // Your number
          style: TextStyle(
            fontSize: 18,
            color: Colors.green, // Color for the number
          ),
        ),
          ],
        ),
      ),
      
                      RichText(
        text: TextSpan(
          // style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
          // style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
        TextSpan(
          text: 'Total Absent: ',
          style: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black, // Color for the text "Total Absent: "
          ),
        ),
        TextSpan(
          text: '2', // Your number
          style: TextStyle(
            fontSize: 18,
            color: Colors.red, // Color for the number
          ),
        ),
          ],
        ),
      )
      
                      
                    ]),
                  ),
      
              )
          
        ]);
  }),
    );
  }
}