import 'package:blackbox/Utils/Toast/ToastCustom.dart';
import 'package:blackbox/View/auth/ForgotPassword_otp.dart';
import 'package:blackbox/View/auth/verifyOTPScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Model/SignUpModel/ModelRegistration.dart';
import '../../../Utils/Loader/LoadingScreen.dart';
import '../../../Utils/PrintLog/PrintLog.dart';
import '../../ApiController/ApiController.dart';
import '../../ApiController/WebConstant.dart';

class SignUpController extends GetxController {
  final ApiController _apiCtrl = ApiController();


  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String timezone = 'EST';

  checkSignUp({required BuildContext context}) {
    if (usernameController.text.isNotEmpty && phoneController.text.isNotEmpty && emailController.text.isNotEmpty && passwordController.text.isNotEmpty && timezone.isNotEmpty) {
      signUp(context: context);
    } else {
      ToastCustom.showToast(msg: "Please complete all fields first");
    }
  }

  Future<SignUpModel?> signUp({required BuildContext context}) async {
    CustomLoading().show(context, true);

    Map<String, dynamic> dictparm = {
      "name": usernameController.text.trim(),
      "phone": phoneController.text.trim(),
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "timezone": timezone,
    };
    PrintLog.printLog("Map is :::>>>>>::::$dictparm");
    String url = WebApiConstant.singUp;
    await _apiCtrl.signUpApi(url: url, context: context, dictParameter: dictparm).then((result) {
      if (result != null) {
        try {
          if (result == 200) {
            ToastCustom.showToast(msg: "Registration Successful");
            PrintLog.printLog(result);
            CustomLoading().show(context, false);

            goToVerifyOtp(context: context);
          } else if (result == 412) {
            CustomLoading().show(context, false);

            ToastCustom.showToast(msg: "Username already in user");
            PrintLog.printLog(result);
            userNameAlreadyUsed(context: context);
          } else if (result == 301) {
            CustomLoading().show(context, false);

            ToastCustom.showToast(msg: "Please complete where you left out");
            PrintLog.printLog(result);
            goToVerifyOtp(context: context);
          }
        } catch (_) {
          CustomLoading().show(context, false);
          PrintLog.printLog("Exception at controller screen is : $_");
        }
      } else {
        CustomLoading().show(context, false);
        ToastCustom.showToast(msg: "Please try again ");
        update();
      }
    });
    CustomLoading().show(context, false);

  }

  void goToVerifyOtp({required context}) {
    PrintLog.printLog("Going to verify otp screen");
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyOTPScreen(usernames: phoneController.text, passwords: passwordController.text),
        ));
  }

  void userNameAlreadyUsed({required BuildContext context}) {
    ///if any
  }
}
