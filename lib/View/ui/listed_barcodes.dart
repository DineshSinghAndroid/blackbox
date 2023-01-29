import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListedBarcodes extends StatefulWidget {
  const ListedBarcodes({Key? key}) : super(key: key);

  @override
  State<ListedBarcodes> createState() => _ListedBarcodesState();
}

class _ListedBarcodesState extends State<ListedBarcodes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
         child: SingleChildScrollView(
           child: Column(
             children: [
               Row(
                 children: [
                   Text("BBX VISIBLE",style: TextStyle(
                       fontSize: 43.sp,
                       fontWeight: FontWeight.w700
                       ,color: Colors.white
                   ),),
                   Icon(Icons.download,
                   color: Colors.white,
                     size: 20.sp,
                   )
                 ],
               )
             ],
           ),
         ),

       ),
    );
  }
}
