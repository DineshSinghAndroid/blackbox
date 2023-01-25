import 'package:blackbox/View/auth/signup_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class BarcodeScanner extends StatefulWidget {
  @override
  _BarcodeScannerState createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: .7, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    )
      ..addListener(
            () {
          setState(() {});
        },
      )
      ..addStatusListener(
            (status) {
          if (status == AnimationStatus.completed) {
            _controller.reverse();
          } else if (status == AnimationStatus.dismissed) {
            _controller.forward();
          }
        },
      );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff292C31),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SafeArea(
          child: Padding(
            padding:EdgeInsets.symmetric(
              vertical: 40.h,horizontal: 35.w
            ),

            child: Column(
              children: [
                Text("BBX VISIBLE",style: TextStyle(
                  fontSize: 43.sp,
                  fontWeight: FontWeight.w700
                    ,color: Colors.white
                ),),
                SizedBox(height: _height/3,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 150,
                       width: 130.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                            ,
                        color: Colors.blue
                      ),
                      child: Column(
                        children: [
                          Container(
                            height:100,
                              // width: 100,
                              child: Lottie.network('https://assets7.lottiefiles.com/packages/lf20_2sapbqfh.json')),
                          SizedBox(height: 5.h,)
                          ,
                          Text("Device Add \n& Naming",style: TextStyle(
                            fontSize: 16,color: Colors.white,fontWeight: FontWeight.w500
                          ),),
                          SizedBox(height: 5.h,)
                          ,
                        ],
                      ),
                    ),


                    Container(
height: 150,
                        width: 130.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5))
                            ,
                        color: Colors.blue
                      ),
                      child: Column(
                        children: [
                          Container(
                            height:100,
                              // width: 100,
                              child: Lottie.network('https://assets9.lottiefiles.com/packages/lf20_49rdyysj.json')),
                          Spacer(),
                          Text("View Data",style: TextStyle(
                            fontSize: 16,color: Colors.white,fontWeight: FontWeight.w500
                          ),),
                          SizedBox(height: 15.h,)
                          ,
                        ],
                      ),
                    ),
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

   }

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
