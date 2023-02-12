import 'dart:convert';
import 'dart:developer';
import 'package:blackbox/View/auth/verifyOTPScreen.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:blackbox/Utils/ApiService.dart';
import 'package:blackbox/View/auth/login_screen.dart';
import 'package:blackbox/View/ui/Home/home_barcode_scanner.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/Common_textfield.dart';
import '../../Utils/WebConstants.dart';
import '../../Utils/app_theme.dart';
import '../../Utils/button.dart';
import '../../repository/signup_repository.dart';
import '../../router/MyRouter.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
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

  // register(String name, phone, email, password) async {
  //   Map data = {"name": name, "phone": phone, "username": phone, "email": email, "password": password};
  //   print("GOING DATA IS ::::>>>>$data");
  //
  //   String body = json.encode(data);
  //   var url = 'https://bbxlite.azurewebsites.net/api/registerUser?code=cy0as7vM-Mt_Mi7bu6OAJOdLeCUCdlhNc3fhPhy8HpKsAzFuA4OAaA==';
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
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => VerifyOTPScreen(realOTP: OTPfromServer),
  //         ));
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

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: SizedBox(
              height: _height,
              child: Column(
                children: [
                  Expanded(child: SizedBox()),
                  Expanded(
                    flex: 10,
                    child: Padding(
                      padding: EdgeInsets.only(top: Get.width * 0.05),
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
                          SizedBox(
                            height: Get.height * 0.05,
                          ),
                          CommonTextFieldWidget(
                            prefix: Icon(
                              Icons.account_circle_outlined,
                              color: Colors.black54.withOpacity(0.4),
                            ),
                            hint: 'Name',
                            controller: name,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            bgColor: Colors.black54.withOpacity(0.4),
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Please enter name'),
                              //MinLengthValidator(10, errorText: 'Invalid Number'),
                            ]),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          //component1(Icons.account_circle_outlined, 'Name', false, false, name, TextInputType.text),
                          // component1(Icons.account_circle_outlined, 'User name', false, false, username),
                          CommonTextFieldWidget(
                            prefix: Icon(
                              Icons.account_circle_outlined,
                              color: Colors.black54.withOpacity(0.4),
                            ),
                            hint: 'Phone',
                            controller: phone,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            bgColor: Colors.black54.withOpacity(0.4),
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Please enter phone number'),
                              MinLengthValidator(10, errorText: 'Invalid Number'),
                            ]),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          //component1(Icons.account_circle_outlined, 'Phone', false, false, phone, TextInputType.number),
                          CommonTextFieldWidget(
                            prefix: Icon(
                              Icons.email_outlined,
                              color: Colors.black54.withOpacity(0.4),
                            ),
                            hint: 'Email',
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            bgColor: Colors.black54.withOpacity(0.4),
                            validator: MultiValidator([
                              EmailValidator(errorText: 'Please enter valid email'),
                              RequiredValidator(errorText: 'Please enter name'),
                              //MinLengthValidator(10, errorText: 'Invalid Number'),
                            ]),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          //component1(Icons.email_outlined, 'Email', false, true, email, TextInputType.emailAddress),
                          CommonTextFieldWidget(
                            prefix: Icon(
                              Icons.lock_outline,
                              color: Colors.black54.withOpacity(0.4),
                            ),
                            hint: 'Password',
                            controller: password,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            bgColor: Colors.black54.withOpacity(0.4),
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Please enter password'),
                              MinLengthValidator(8, errorText: 'Password should be 8 characters long'),
                            ]),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          //component1(Icons.lock_outline, 'Password', true, false, password, TextInputType.visiblePassword),
                          Align(
                            alignment: Alignment.center,
                            child: CommonButton(
                              "SIGN-IN",
                              () {
                                if (formkey.currentState!.validate()) {
                                  if (name.text.length < 3 || email.text.length < 3 || phone.text.length < 10 || password.text.length < 8) {
                                    Fluttertoast.showToast(msg: "Please Fill all data");
                                  } else {
                                    //register(name.text.trim(), phone.text.trim(), email.text.trim(), password.text.trim().toString());
                                    signupRepo(
                                      name: name.text,
                                      phone: phone.text,
                                      email: email.text,
                                      password: password.text,
                                      context: context,
                                    ).then((value) async {
                                      log(jsonEncode(value));
                                      Fluttertoast.showToast(msg: value.message.toString());
                                      if (value.message == "OTP successfully send to your email.") {
                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        prefs.setString(WebConstants.USERNAME, username.text);
                                        prefs.setString(WebConstants.PASSWORD, password.text);
                                        Get.offAllNamed(MyRouter.verifyOtp);

                                      }
                                      // else {
                                      //   Fluttertoast.showToast(msg: "Something went Wrong");
                                      // }
                                    });
                                  }
                                } else {
                                  Fluttertoast.showToast(msg: "Please Fill All Fields!");
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 35,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Login to existing Account !',
                                  style: TextStyle(color: Colors.blueAccent),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginScreen(),
                                          ));
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
                  ),
                  Expanded(
                    flex: 3,
                    child: Stack(
                      children: [],
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

  Widget component1(IconData icon, String hintText, bool isPassword, bool isEmail, Controller, type) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      height: Get.height * 0.08,
      width: Get.width * 0.80,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: _width / 30),
      decoration: BoxDecoration(
          // color: AppTheme.gray,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black, width: 1)),
      margin: EdgeInsets.all(6),
      child: TextFormField(
        style: TextStyle(color: Colors.black.withOpacity(.9)),
        obscureText: isPassword,
        controller: Controller,
        keyboardType: type,
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
