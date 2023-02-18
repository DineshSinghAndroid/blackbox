import 'dart:convert';
import 'dart:developer';
import 'package:blackbox/Utils/WebConstants.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:blackbox/Utils/app_theme.dart';
import 'package:blackbox/Utils/button.dart';
import 'package:blackbox/View/auth/signup_screen.dart';
import 'package:blackbox/View/ui/Home/home_barcode_scanner.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/ModelLogin.dart';
import '../../Utils/Common_textfield.dart';
import '../../Utils/api_call_fram.dart';
import '../../Utils/connection_validater.dart';
import '../../repository/login_repository.dart';
import '../../router/MyRouter.dart';
import 'forgot_password.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  TextEditingController AddName = TextEditingController();

  TextEditingController phoneController = TextEditingController();
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: SizedBox()),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 50),

                           child: Image.asset('assets/images/bbx.jpeg'),
                        ),
                        SizedBox(height: Get.height * 0.08),
                        // component1(Icons.account_circle_outlined, 'Phone Number...', false, false , phoneController),
                        CommonTextFieldWidget(
                          prefix: Icon(
                            Icons.account_circle_outlined,
                            color: Colors.black54.withOpacity(0.4),
                          ),
                          hint: 'Phone Number...',
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          bgColor: Colors.black54.withOpacity(0.4),
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'Please Enter Phone Number'),
                            MinLengthValidator(10, errorText: 'Invalid Number'),
                          ]),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CommonTextFieldWidget(
                          prefix: Icon(
                            Icons.lock_outline,
                            color: Colors.black54.withOpacity(0.4),
                          ),
                          hint: 'Password',
                          obscureText: true,
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
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: CommonButton(
                            "Login",
                            () async {
                              if (formKey.currentState!.validate()) {
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString(WebConstants.USERNAME, phoneController.text);
                                prefs.setString(WebConstants.PASSWORD, password.text);

                                print(phoneController.text);
                                print("Datan shared prefs ====>>>>" + prefs.getString(WebConstants.USERNAME).toString());
                                print(password.text);
                                phoneController.text.isNotEmpty && phoneController.text.length == 10 && password.text.isNotEmpty && password.text.length >= 8
                                    ? {
                                        loginRepo(
                                          phone: phoneController.text,
                                          password: password.text,
                                          context: context,
                                        ).then((value) async {
                                          SharedPreferences prefs = await SharedPreferences.getInstance();
                                          prefs.setBool(WebConstants.IS_USER_LOGGED_IN, true);
                                        })
                                      }
                                    : Fluttertoast.showToast(msg: "Incorrect Username or Password");
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 15,),
                        Align(

                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black, fontSize: 14),
                              children: [
                                TextSpan(
                                  text: 'New Consumer? ',
                                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
                                ),

                                TextSpan(
                                    text: 'Click Here to Register',
                                    style: TextStyle(fontSize: 14, color: AppTheme.primaryColorBlue, fontWeight: FontWeight.w500
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
                        SizedBox(height: 20,),

                        Align(

                          alignment: Alignment.center,
                          child: InkWell(
                            onTap:(){},
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 40,vertical: 10),
                              decoration: BoxDecoration(
                                  color: AppTheme.primaryColorBlue,
                                  borderRadius: BorderRadius.all(Radius.circular(5))
                              ),
                              child: Text("View Device Data",style: TextStyle(
                                  color: Colors.white
                              ),),
                            ),
                          ),
                        ),
                        SizedBox(height: 100,)
                        ,
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(onTap: (){
Navigator.push(context,  MaterialPageRoute(builder: (context) => ForgotPasswordScreen(username:phoneController.text.toString()),));
                          },
                          child: Text("Forgot Password ?",style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18
                          ),),
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

  Widget component1(IconData icon, String hintText, bool isPassword, bool isEmail, Controller) {
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
