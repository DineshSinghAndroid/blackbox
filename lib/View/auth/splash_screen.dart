import 'dart:async';
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
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      if(pref.getString("cookie") != null){
        //Get.offAllNamed(MyRouter.bottomnavbar);
      }  else {
          Get.offAllNamed(MyRouter.loginScreen);
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
          children: [
            Container(
              height: screenSize.width * 45,
              decoration: const BoxDecoration(
                color: Colors.white
              ),
            ),
            Positioned(
              top: screenSize.width * 0.75,
              left: screenSize.width * 0.22,
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                height: screenSize.width * 0.40,
                width: screenSize.width * 0.55,
                decoration: const BoxDecoration(
                  color: Colors.black12
                ),
                child: Image.asset("assets/images/logo.png"),
              ),
            ),
          ],
        ));
  }
}
