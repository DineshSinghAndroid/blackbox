import 'dart:async';
import 'package:blackbox/Utils/WebConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../router/MyRouter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();
    init();
  }


  void runMain() {

    if (isUserLoggedIn == true) {
      Get.toNamed(MyRouter.barcodeScreen);
      print(isUserLoggedIn);
    } else {
      print("going to login page $isUserLoggedIn");

      Get.toNamed(MyRouter.loginScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child:  Image.asset("assets/images/bbx.jpeg"),



    ),
        ));
  }

    init() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        isUserLoggedIn = prefs.getBool(WebConstants.IS_USER_LOGGED_IN)??false;

      });
      Timer(const Duration(seconds: 3), () async {
        runMain();
      });
  }
}
