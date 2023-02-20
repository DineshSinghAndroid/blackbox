import 'dart:convert';
import 'dart:io';
import 'package:blackbox/Model/ModelCommonResponse.dart';
import 'package:blackbox/Utils/Helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<ModelCommonResponse> updateAssets(qrcode, asset_name ,BuildContext context) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  try {

    var auth =  "https://bbxlite.azurewebsites.net/api/updateBeaconName?code=HRrPrQIuiFjFxWF4VhAM5SlcDplTnw1lJpNEds28bSMXAzFuG7-u5g==";

    var map = <String, dynamic>{};
    map['qrcode'] = qrcode;
    map['asset_name'] = asset_name;
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };
    http.Response response = await http.post(Uri.parse(auth),
        body: jsonEncode(map), headers: headers);
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
    return ModelCommonResponse(
        message: "No Internet Access");
  } catch (e) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse(message: e.toString());
  }
}
