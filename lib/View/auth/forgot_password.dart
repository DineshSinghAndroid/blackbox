import 'package:blackbox/Utils/Common_textfield.dart';
import 'package:blackbox/router/MyRouter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../Utils/app_theme.dart';
import '../../Utils/button.dart';
import '../../repository/forgot_password_repo.dart';

class ForgotPasswordScreen extends StatefulWidget {
  String username;

  ForgotPasswordScreen({Key? key, required this.username}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
                  child: Image.asset('assets/images/bbx.jpeg')),
              CommonTextFieldWidget(
                hint: "Phone",
                controller: username,
              ),
              const SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.center,
                child: CommonButton(
                  "Submit",
                  () async {
                    if (username.text.length == 10) {
                      forgotEmail(
                        username.text.toString(),
                        context,
                      ).then((value) async {
                        if (value.message == "OTP successfully send.") {
                          Fluttertoast.showToast(
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.TOP,
                              msg: value.message.toString());
                          Get.toNamed(MyRouter.verifyOtp,
                              arguments: ([
                                username.text,
                                value.otp.toString()
                              ]));
                        }
                      });
                    } else {
                      Fluttertoast.showToast(
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.TOP,
                          msg: "Please Enter Correct Phone Number");
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              const Text("We will Send a password reset phone number ")
            ],
          ),
        ),
      ),
    );
  }
}
