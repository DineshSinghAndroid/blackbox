import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import '../Model/ModelDeviceRegster.dart';
import '../Utils/Helper.dart';

Future<ModelDeviceRegister> deviceRegister(
    {phone, password, qrcode, assetsName, context}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);

  try {
    var auth =
        'https://bbxlite.azurewebsites.net/api/registerBeacons?code=jq-NS8VB3PxumeGynmdlA1jYWZrvywXklb2FQz06uzGPAzFuq3jRPA==';

    var map = <String, dynamic>{};
    map['username'] = phone;
    map['password'] = password;
    map['qrcode'] = qrcode;
    // map['qrcode'] = qrcode;
    map['asset_name'] = assetsName;
    print("This is map ::::::::::::::::::>>>>>" + map.toString());

    final headers = {
      HttpHeaders.contentTypeHeader: 'text/plain; charset=utf-8',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.accessControlAllowOriginHeader: '*'
    };

    http.Response response = await http.post(Uri.parse(auth),
        body: jsonEncode(map), headers: headers);
    print(response.statusCode.toString());

    if (response.statusCode == 200) {
      String mess = json.decode(response.body)["message"].toString();

      Fluttertoast.showToast(msg: mess.toString());
      Helpers.hideLoader(loader);
      print('SERVER RESPONSE::${response.statusCode}');
      return ModelDeviceRegister.fromJson(jsonDecode(response.body));
    } else {

      String mess = json.decode(response.body)["message"].toString();

      Fluttertoast.showToast(msg: mess.toString());
      Helpers.hideLoader(loader);
      print('SEREVER RESPONSE::${response.body}');
      return ModelDeviceRegister.fromJson(jsonDecode(response.body));
    }
  } on SocketException {
    Helpers.hideLoader(loader);
    return ModelDeviceRegister(message: "No Internet Access");
  } catch (e) {
    Helpers.hideLoader(loader);
    return ModelDeviceRegister(
      message: e.toString(),
    );
  }
}
