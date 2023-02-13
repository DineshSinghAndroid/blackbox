import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../Model/ModelCommonResponse.dart';
import '../Utils/Helper.dart';
import '../Utils/WebConstants.dart';

Future<ModelCommonResponse> verifyOtp(
    {username, password, otp, context}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);

  try {
    var auth =
        "https://bbxlite.azurewebsites.net/api/validateOTP?code=2bwrbhw_qcKwLiO7rTAJFAjDNuJqOw1EETSuWb9kvg0tAzFulN8Niw==";
    var map = <String, dynamic>{};
    map['username'] = username;
    map['password'] = password;
    map['otp'] = otp;
    print("This is map ::::::::::::::::::" + map.toString());

    final headers = {
      HttpHeaders.contentTypeHeader: 'text/plain; charset=utf-8',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.accessControlAllowOriginHeader: '*',
    };

    http.Response response = await http.post(Uri.parse(auth),
        body: jsonEncode(map), headers: headers);
    print(response.statusCode.toString());

    if (response.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(WebConstants.IS_USER_LOGGED_IN, true);
      Helpers.hideLoader(loader);
      print('SEREVER RESPONSE::${response.statusCode}');
      return ModelCommonResponse.fromJson(jsonDecode(response.body));
    } else {
      Helpers.hideLoader(loader);
      print('SERVER RESPONSE::${response.body}');
      return ModelCommonResponse.fromJson(jsonDecode(response.body));
    }
  } on SocketException {
    Helpers.hideLoader(loader);
    return ModelCommonResponse(message: "No Internet Access");
  } catch (e) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse(
      message: e.toString(),
    );
  }
}
