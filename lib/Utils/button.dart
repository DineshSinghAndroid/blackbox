import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Container CommonButton(String text, OnTap){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.black,
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: MaterialButton(onPressed: OnTap, minWidth: Get.width * 0.70 ,child: Text(text,style: TextStyle(
        fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white
      ),),),
    ),
  );
}