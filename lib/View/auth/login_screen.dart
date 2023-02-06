import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:blackbox/Utils/app_theme.dart';
import 'package:blackbox/Utils/button.dart';
import 'package:blackbox/View/auth/signup_screen.dart';
import 'package:blackbox/View/ui/home_barcode_scanner.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  TextEditingController AddName = TextEditingController();

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
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

  login(String phone, password) async {
    Map data = {"username": phone, "password": password};
    print("GOING DATA IS ::::>>>>$data");

    String body = json.encode(data);
    var url = 'https://bbxlite.azurewebsites.net/api/userLogin?code=L3nlW6WNdjZT8BJJ4_CR1u3F8WL60s2jdfJCGND1pLGFAzFunHfX-w==';
    var response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {"Content-Type": "application/json", "accept": "application/json", "Access-Control-Allow-Origin": "*"},
    );
    print(response.body);
    print(response.statusCode);
    String mess = json.decode(response.body)["message"].toString();
    String OTPfromServer = json.decode(response.body)["otp"].toString();

    print("OTP IS ::::>>>" + OTPfromServer);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: mess);

      print('success');
    } else {
      print('error');

      Fluttertoast.showToast(msg: mess);
    }
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
      backgroundColor: Colors.white,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: _height,
            child: Column(
              children: [
                Expanded(child: SizedBox()),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(),
                      Text(
                        'AlertWare',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.black,
                        ),
                      ),
                      SizedBox(),
                      component1(Icons.account_circle_outlined, 'Phone Number...', false, false),
                      component1(Icons.lock_outline, 'Password...', true, false),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Forgotten password!',
                              style: TextStyle(
                                color: AppTheme.orange,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  HapticFeedback.lightImpact();
                                  Fluttertoast.showToast(msg: 'Forgotten password! button pressed');
                                },
                            ),
                          ),
                          SizedBox(width: _width / 10),
                          RichText(
                            text: TextSpan(
                              text: 'Create a new Account',
                              style: TextStyle(color: AppTheme.orange),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignupScreen(),
                                      ));
                                  HapticFeedback.lightImpact();
                                  Fluttertoast.showToast(
                                    msg: 'Creating new account',
                                  );
                                },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      // Center(
                      //   child: Container(
                      //     margin: EdgeInsets.only(bottom: _width * .07),
                      //     height: _width * .7,
                      //     width: _width * .7,
                      //     decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       gradient: LinearGradient(
                      //         colors: [
                      //           Colors.transparent,
                      //           Colors.transparent,
                      //           Color(0xff09090A),
                      //         ],
                      //         begin: Alignment.topCenter,
                      //         end: Alignment.bottomCenter,
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      Align(
                        alignment: Alignment.center,
                        child: CommonButton(
                          "Login",
                          () {
                            login(username.text.trim(), password.text.trim());
                            HapticFeedback.lightImpact();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget component1(IconData icon, String hintText, bool isPassword, bool isEmail) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _width / 8,
      width: _width / 1.22,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: _width / 30),
      decoration: BoxDecoration(
          // color: AppTheme.gray,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black, width: 1)),
      child: TextField(
        style: TextStyle(color: Colors.black.withOpacity(.9)),
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.black.withOpacity(.7),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: AppTheme.black,
          ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
