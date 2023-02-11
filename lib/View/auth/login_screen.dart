import 'dart:convert';
import 'dart:developer';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:blackbox/Utils/app_theme.dart';
import 'package:blackbox/Utils/button.dart';
import 'package:blackbox/View/auth/signup_screen.dart';
import 'package:blackbox/View/ui/Home/home_barcode_scanner.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/Common_textfield.dart';
import '../../repository/login_repository.dart';
import '../../router/MyRouter.dart';

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

  // login(String phone, password) async {
  //   Map data = {"username": phone, "password": password};
  //   print("GOING DATA IS ::::>>>>$data");
  //
  //   String body = json.encode(data);
  //   var url = 'https://bbxlite.azurewebsites.net/api/userLogin?code=L3nlW6WNdjZT8BJJ4_CR1u3F8WL60s2jdfJCGND1pLGFAzFunHfX-w==';
  //   var response = await http.post(
  //     Uri.parse(url),
  //     body: body,
  //     headers: {"Content-Type": "application/json", "accept": "application/json", "Access-Control-Allow-Origin": "*"},
  //   );
  //   print(response.body);
  //   print(response.statusCode);
  //   String mess = json.decode(response.body)["message"].toString();
  //   String OTPfromServer = json.decode(response.body)["otp"].toString();
  //
  //   print("OTP IS ::::>>>" + OTPfromServer);
  //   if (response.statusCode == 200) {
  //     Fluttertoast.showToast(msg: mess);
  //
  //     print('success');
  //   } else {
  //     print('error');
  //
  //     Fluttertoast.showToast(msg: mess);
  //   }
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
     double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: _height,
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Expanded(child: SizedBox()),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(),
                        Padding(
                          padding:  EdgeInsets.only(left: Get.width * 0.30 , top: Get.width * 0.05),
                          child: Container(
                            height: 70,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.black12
                            ),
                            child: Image.asset('assets/images/logo.png'),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.08),
                       // component1(Icons.account_circle_outlined, 'Phone Number...', false, false , username),
                        CommonTextFieldWidget(
                          prefix: Icon(
                            Icons.account_circle_outlined,
                            color: Colors.black54.withOpacity(0.4),
                          ),
                          hint: 'Phone Number...',
                          controller: username,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          bgColor: Colors.black54.withOpacity(0.4),
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'Please Enter Phone Number'),
                            MinLengthValidator(10, errorText: 'Invalid Number'),
                          ]),
                        ),
                        SizedBox(height: 30,),
                        CommonTextFieldWidget(
                          prefix: Icon(
                            Icons.lock_outline,
                            color: Colors.black54.withOpacity(0.4),
                          ),
                          hint: 'Password',
                          controller: password,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          bgColor: Colors.black54.withOpacity(0.4),
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'Please Enter Password'),
                            //MinLengthValidator(10, errorText: 'Invalid Number'),
                          ]),
                        ),
                        //component1(Icons.lock_outline, 'Password...', true, false , password),
                        SizedBox(height: 20,),
                        Align(
                          alignment: Alignment.center,
                          child: CommonButton(
                            "Login", () {
                           // Get.offAllNamed(MyRouter.barcodeScreen);
                            // login(username.text.trim(), password.text.trim());
                            // HapticFeedback.lightImpact();
                            if(formKey.currentState!.validate()){
                              loginRepo(
                                phone: username.text,
                                password: password.text,
                                context: context,
                              ).then((value) async {
                                log(jsonEncode(value));
                                if (value.message == "User successfully logged in.") {
                                  SharedPreferences pref = await SharedPreferences.getInstance();
                                  pref.setString('cookie', jsonEncode(value.message));
                                  Get.offAllNamed(MyRouter.barcodeScreen ,
                                      arguments: ([
                                        username.text.toString(),
                                        password.text.toString()]));
                                }
                                else {
                                  Fluttertoast.showToast(msg: "Please Register Your Account");
                                }
                              });
                            }
                            else {
                              Fluttertoast.showToast(msg: "Please Fill All Fields!");
                            }
                          },
                          ),
                        ),
                        // SizedBox(height: 5,),
                        Padding(
                          padding: EdgeInsets.only(left: Get.width * 0.07 , top: Get.width * 0.05),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14),
                              children: [
                                TextSpan(
                                  text: 'New Consumer? ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                TextSpan(
                                    text: 'Click Here to Register',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.w500
                                      //decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.toNamed(MyRouter.signupScreen);
                                      }),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: 25.0 , top: 8),
                          child: Text('View Device Data' ,
                          style: TextStyle( color:  Colors.black , fontSize: 14 , fontWeight: FontWeight.w600),
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
      ),
    );
  }

  Widget component1(IconData icon, String hintText, bool isPassword, bool isEmail , Controller) {
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
        controller: Controller,
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
