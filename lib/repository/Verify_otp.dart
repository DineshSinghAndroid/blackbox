import 'dart:convert';
import 'dart:io';
import 'package:blackbox/Model/ModelCommonResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../utils/ApiConstant.dart';
import '../Utils/Helper.dart';

Future<ModelCommonResponse> verifyForgotEmail(
    username, password, otp, BuildContext context) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  try {
    var auth = "https://bbxlite.azurewebsites.net/api/updatePassword?code=z3FFNg7xxtvkcMTFmsi3qojZmPiAPLOcGYA4mV7AU85iAzFuIUHBKg==";

    var map = <String, dynamic>{};
    map['username'] = username;
    map['password'] = password;
    map['otp'] = otp;
    print("THIS IS MAP $map");

    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };

    http.Response response = await http.post(
        Uri.parse(auth),
        body: jsonEncode(map),
        headers: headers);

    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      return ModelCommonResponse.fromJson(jsonDecode(response.body));
    } else {
      Helpers.hideLoader(loader);
      return ModelCommonResponse(

          message: jsonDecode(response.body)["message"],
          );
    }
  } on SocketException {
    Helpers.hideLoader(loader);
    return ModelCommonResponse(
        message: "No Internet Access");
  } catch (e) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse(message: e.toString());
  }
}
