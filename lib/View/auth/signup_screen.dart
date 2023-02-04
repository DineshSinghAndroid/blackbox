




import 'package:blackbox/View/auth/login_screen.dart';
import 'package:blackbox/View/ui/home_barcode_scanner.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Utils/app_theme.dart';
import '../../Utils/button.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>
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
    )..addListener(
          () {
        setState(() {});
      },
    )..addStatusListener(
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
                        'SIGN IN',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(),
                      component1(Icons.account_circle_outlined, 'User name...',
                          false, false),
                      component1(Icons.email_outlined, 'Email...', false, true),
                      component1(
                          Icons.lock_outline, 'Password...', true, false),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
SizedBox(width: 35,)
                          ,
                          RichText(
                            text: TextSpan(
                              text: 'Login to existing Account !',
                              style: TextStyle(color: AppTheme.orange),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                                  HapticFeedback.lightImpact();
                                  Fluttertoast.showToast(
                                    msg: 'Login to continue',
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
                        child: CommonButton("SIGN-IN", (){

                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              BarcodeScanner(),));
                          HapticFeedback.lightImpact();
                          Fluttertoast.showToast(
                            msg: 'SIGN-IN button pressed',
                          );

                        }),
                      ),
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

  Widget component1(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _width / 8,
      width: _width / 1.22,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: _width / 30),
      decoration: BoxDecoration(
        // color: AppTheme.gray,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black,width: 1)
      ),
      child: TextField(
        style: TextStyle(color: Colors.black.withOpacity(.9)),
        obscureText: isPassword,
        keyboardType: isEmail ?
        TextInputType.emailAddress : TextInputType.text,
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
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}