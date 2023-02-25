import 'dart:convert';
import 'dart:io';
import 'package:blackbox/Utils/Helper.dart';
import 'package:blackbox/View/auth/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../utils/ApiConstant.dart';
import '../Model/ModelForgtPassword.dart';

Future<ModelForgotPassword> forgotEmail(username, BuildContext context) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);
  try {
    var auth =
        "https://bbxlite.azurewebsites.net/api/forgetPassword?code=gfTNBXUuZJA38itPp4DS38cgv3ngUxu0CDRDNV7oow0nAzFuzVZA4A==";

    var map = <String, dynamic>{};
    map['username'] = username;
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };
    http.Response response = await http.post(Uri.parse(auth), body: jsonEncode(map), headers: headers);
    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      return ModelForgotPassword.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 412) {
      Helpers.hideLoader(loader);
      Fluttertoast.showToast(msg: "User Not Registered");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignupScreen(),
          ));
      return ModelForgotPassword(
       );
    } else {
      Helpers.hideLoader(loader);
      return ModelForgotPassword(
        message: jsonDecode(response.body)["message"],
      );
    }
  } on SocketException {
    return ModelForgotPassword(message: "No Internet Access");
  } catch (e) {
    Helpers.hideLoader(loader);
    return ModelForgotPassword(message: e.toString());
  }
}
