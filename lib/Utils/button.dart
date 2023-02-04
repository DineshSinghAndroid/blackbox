import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Container CommonButton(String text, OnTap){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),

          color: Colors.blue,

    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: MaterialButton(onPressed: OnTap,child: Text(text,style: TextStyle(
        fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white
      ),),),
    ),
  );
}