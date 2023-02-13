import 'dart:convert';
import 'dart:developer';

import 'package:blackbox/repository/verifyotp_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/Common_textfield.dart';
import '../../Utils/WebConstants.dart';
import '../../router/MyRouter.dart';
import '../ui/Home/home_barcode_scanner.dart';

class VerifyOTPScreen extends StatefulWidget {
  String  passwords;

   String usernames;




  // VerifyOTPScreen() ;
  VerifyOTPScreen({required this.usernames,required this.passwords}) ;
  @override
  _VerifyOTPScreenState createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  String otp = '';
  String username ='';
  String password = '';

  void initState() {
    init();
  }

  init() async {
    await SharedPreferences.getInstance().then((value) {
      // setState(() {
      //   username = value.getString(WebConstants.USERNAME).toString();
      //   password = value.getString(WebConstants.PASSWORD).toString();
      //   print("USer name and password on otp screen is  ${username}" +
      //       password.toString());
      // });
    });
    setState(() {
      username = widget.usernames;
      password = widget.passwords;
      print("USERNAME AND PASSWORD COMING FROM SIGN IS " +username.toString() + password.toString());
    });
  }

  TextEditingController otpController = TextEditingController();

  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  TextEditingController otp5 = TextEditingController();
  String? finalOtp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Enter your OTP code number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 28,
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: PinCodeTextField(
                  appContext: context,
                  textStyle: TextStyle(color: Colors.grey),
                  controller: otpController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  pastedTextStyle: TextStyle(
                    color: Colors.green.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                  animationType: AnimationType.fade,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "OTP code Required";
                    } else if (v.length != 5) {
                      return "Enter complete OTP code";
                    }
                    return null;
                  },
                  length: 5,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    //borderRadius: BorderRadius.circular(AddSize.size30),
                    fieldWidth: 50,
                    fieldHeight: 50,
                    activeColor: Colors.black38,
                    inactiveColor: Colors.black38,
                    errorBorderColor: Colors.black38,
                  ),
                  //   //runs when a code is typed in
                  keyboardType: TextInputType.number,
                  onChanged: (String VerificationCode) {
                    otp = VerificationCode;
                  },
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (otpController.text != otp) {
                      Fluttertoast.showToast(msg: 'Otp is not matched');
                    } else if (otpController.text == otp) {
                      verifyOtp(
                        username: widget.usernames,
                        password: widget.passwords,
                        otp: otpController.text,
                        context: context,
                      ).then((value) async {
                        log(jsonEncode(value));

                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool(WebConstants.IS_USER_LOGGED_IN, true);
                        Fluttertoast.showToast(msg: value.message.toString());
                        if (value.message == "Account activated.") {
                          Get.offAllNamed(
                            MyRouter.barcodeScreen,
                          );
                        }
                      });
                    }
                  },
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      'Verify',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                "Didn't you receive any code?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                "Resend New Code",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget component1(IconData icon, String hintText, bool isPassword,
      bool isEmail, Controller, type) {
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
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP({required bool first, last, controllers}) {
    return Container(
      //58080
      height: 50,
      width: 40,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          controller: controllers,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
            setState(() {
              finalOtp = otp1.text.toString() +
                  otp2.text.toString() +
                  otp3.text.toString() +
                  otp4.text.toString() +
                  otp5.text.toString();
              print("FInal opt is :::::::::>>>>>>>>>>>>>>>>" +
                  finalOtp.toString());
            });
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.blue),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
