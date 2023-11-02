import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tution_attand/core/them/style.dart';

class statusWidget extends StatelessWidget {
  const statusWidget({super.key, required this.tex, required this.updator});
  final String tex;
  final String updator;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text(
        tex,
        style: TextStyle(
            color:updator.toUpperCase()==tex.toUpperCase()?Styleapp().whit: Color.fromARGB(255, 185, 184, 180),
            fontWeight: FontWeight.bold),
      )),
      height: Get.height * 0.05,
      width: Get.width * 0.25,
      decoration: BoxDecoration(
          color:updator.toUpperCase()==tex.toUpperCase()?Styleapp().blu: Styleapp().whit,
          border: Border.all(
            color: Styleapp().blu,
            width: 0.4,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }
}
