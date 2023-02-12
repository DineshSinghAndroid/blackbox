import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

// import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../View/auth/login_screen.dart';
import '../main.dart';
import 'WebConstants.dart';
import 'connection_validater.dart';

Future<void> handleErrorWithStatus(
    int statusCode, BuildContext mContext) async {
  try {
    if (statusCode == 401) {
      final prefs = await SharedPreferences.getInstance();

      prefs.setBool(WebConstants.IS_USER_LOGGED_IN, false);
      // global.channel.sink.close();
      Navigator.pushAndRemoveUntil(
          mContext,
          PageRouteBuilder(pageBuilder: (BuildContext context,
              Animation animation, Animation secondaryAnimation) {
            return LoginScreen();
          }, transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return new SlideTransition(
              position: new Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          }),
          (Route route) => false);
      Fluttertoast.showToast(msg: "Session expired, Login again");
    } else if (statusCode == 400) {
      Fluttertoast.showToast(msg: "Invalid request!");
    } else if (statusCode == 403) {
      Fluttertoast.showToast(
          msg: "You don't have permission to access the requested resource");
    } else if
    (statusCode == 404) {
      Fluttertoast.showToast(msg: "The requested resource does not exist");
    }
    else if (statusCode == 500)
    {
      Fluttertoast.showToast(msg: "Internal Server Error");
    } else if (statusCode == 503)
    {
      Fluttertoast.showToast(msg: "Service Unavailable");
    } else if (statusCode == 111) {
      Fluttertoast.showToast(msg: "Service Connection Refused");
    }
    else {

      Fluttertoast.showToast(msg: "Something went wrong");
    }
  } catch (_, stackTrace) {
    SentryExemption.sentryExemption(_, stackTrace);
  }
}
// import 'package:sentry_flutter/sentry_flutter.dart';

class SentryExemption {
  static sentryExemption(e, stackTrace) async {
    // await Sentry.captureException(
    //   e,
    //   stackTrace: stackTrace,
    // );
  }
}
