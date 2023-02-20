import 'dart:convert';
import 'package:blackbox/View/ui/Home/home_barcode_scanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../Utils/Common_textfield.dart';
import '../../Utils/button.dart';
import '../../repository/Verify_otp.dart';

class VerifyOtp extends StatefulWidget {
  VerifyOtp({Key? key}) : super(key: key);

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  TextEditingController otpController = TextEditingController();
  TextEditingController newPassword = TextEditingController();

  var otp;
  var email = "";

  bool isFromSignup = false;

  @override
  initState() {
    super.initState();
    email = Get.arguments[0];
    otp = Get.arguments[1];
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.only(top: 160),
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              width: Get.width,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                       'Enter Verification Code',
                      style:  TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,),

                    ),
                  ),
                  SizedBox(
                    height:15,
                  ),
                  CommonTextFieldWidget(
                    hint: "New Password",
                    controller: newPassword,
                  ),
                  SizedBox(
                    height:15,
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
                  SizedBox(
                    height: 15,
                  ),
                  CommonButton('Verify', () {
                    if (otpController.text != otp) {
                      Fluttertoast.showToast(msg: "otp is not matched ");
                    } else if (otpController.text == otp) {
                      verifyForgotEmail(
                          email.toString(),
                          newPassword.text.toString(),
                          otp.toString(),
                        context)
                          .then((value) {
                        Fluttertoast.showToast(msg: value.message.toString());
                      });
                    }
                  },),

                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
