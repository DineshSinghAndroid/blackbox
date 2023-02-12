import 'dart:convert';
import 'dart:math';
import 'package:blackbox/Model/ModelCommonResponse.dart';
import 'package:blackbox/Utils/WebConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../Model/ModelRegistration.dart';
import '../Utils/Helper.dart';
import '../Utils/connection_validater.dart';
import '../View/auth/login_screen.dart';
import '../View/ui/Home/home_barcode_scanner.dart';
import '../main.dart';

Future<ModelCommonResponse?> loginRepo({phone, password, context}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);
  bool checkInternet = await ConnectionValidator().check();
  if (checkInternet) {
  try {
    var auth =
        'https://bbxlite.azurewebsites.net/api/userLogin?code=L3nlW6WNdjZT8BJJ4_CR1u3F8WL60s2jdfJCGND1pLGFAzFunHfX-w==';

    var map = <String, dynamic>{};
    map['username'] = phone;
    map['password'] = password;
    print(map);

    final headers = {
      HttpHeaders.contentTypeHeader: 'text/plain; charset=utf-8',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.accessControlAllowOriginHeader: '*'
    };

    http.Response response = await http.post(Uri.parse(auth),
        body: jsonEncode(map), headers: headers);
    print(response.statusCode.toString());

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      log(data);

      String ApiMessage = json.decode(response.body)["message"].toString() ;
      print(ApiMessage);

      Helpers.hideLoader(loader);
      print('SERVER RESPONSE::${response.statusCode}');
      Fluttertoast.showToast(msg: "Login Done");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BarcodeScanner(),
          ));
      return ModelCommonResponse.fromJson(jsonDecode(response.body));
    } else {
      Helpers.hideLoader(loader);
      if (response.statusCode == 401)
      {
        final prefs = await SharedPreferences.getInstance();
         prefs.remove(WebConstants.USERNAME);
         prefs.remove(WebConstants.PASSWORD);
        prefs.setBool(WebConstants.IS_USER_LOGGED_IN, false);
        // global.channel.sink.close();
        Fluttertoast.showToast(
            msg: json.decode(response.body)["message"].toString());
      } else if (response.statusCode == 400)
      {
        Fluttertoast.showToast(msg: "Invalid request!");
      } else if (response.statusCode == 403) {
        Fluttertoast.showToast(
            msg: "You don't have permission to access the requested resource");
      } else if (response.statusCode == 404) {
        Fluttertoast.showToast(msg: "The requested resource does not exist");
      } else if (response.statusCode == 500) {
        Fluttertoast.showToast(msg: "Internal Server Error");
      } else if (response.statusCode == 503) {
        Fluttertoast.showToast(msg: "Service Unavailable");
      } else if (response.statusCode == 111) {
        Fluttertoast.showToast(msg: "Service Connection Refused");
      } else {
        Fluttertoast.showToast(
            msg: json.decode(response.body)["message"].toString());
      }
    }
  } on SocketException {
    Helpers.hideLoader(loader);
    return ModelCommonResponse(message: "No Internet Access");
  } catch (e) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse(
      message: e.toString(),
    );
  }}
  else{
    Helpers.hideLoader(loader);

    Fluttertoast.showToast(msg: "Something went wrong, Failed connection with server.");
    return null;
  }
}


class SentryExemption {
  static sentryExemption(e, stackTrace) async {
    // await Sentry.captureException(
    //   e,
    //   stackTrace: stackTrace,
    // );
  }
}
