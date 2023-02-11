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

  Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isUserLoggedIn = prefs.getBool(WebConstants.IS_USER_LOGGED_IN) ?? false;
    setState(() {});
    Timer(const Duration(seconds: 3), () async {
      runMain();
    });
  }

  void runMain() {
    if (isUserLoggedIn == true) {
      Get.toNamed(MyRouter.barcodeScreen);
    } else {
      Get.toNamed(MyRouter.loginScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: screenSize.width * 45,
          decoration: const BoxDecoration(color: Colors.white),
        ),
        Positioned(
          top: screenSize.width * 0.75,
          left: screenSize.width * 0.22,
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            height: screenSize.width * 0.40,
            width: screenSize.width * 0.55,
            decoration: const BoxDecoration(color: Colors.black12),
            child: Image.asset("assets/images/logo.png"),
          ),
        ),
      ],
    ));
  }
}
