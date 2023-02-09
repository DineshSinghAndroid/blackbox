import 'dart:convert';
import 'package:blackbox/Model/ModelCommonResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import '../Model/ModelRegistration.dart';
import '../Utils/Helper.dart';

Future<ModelCommonResponse> loginRepo({phone , password, context }) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);


  try {
    var auth = 'https://bbxlite.azurewebsites.net/api/userLogin?code=L3nlW6WNdjZT8BJJ4_CR1u3F8WL60s2jdfJCGND1pLGFAzFunHfX-w==';

    var map = <String, dynamic>{};
    map['username'] = phone;
    map['password'] = password;
    print(map);

    final headers = {
      HttpHeaders.contentTypeHeader: 'text/plain; charset=utf-8',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.accessControlAllowOriginHeader: '*'
    };

    http.Response response = await http.post(Uri.parse(auth), body: jsonEncode(map), headers: headers);
    print(response.statusCode.toString());

    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      print('SEREVER RESPONSE::' + response.statusCode.toString());
      return ModelCommonResponse.fromJson(jsonDecode(response.body));
    } else {
      Helpers.hideLoader(loader);
      print('SEREVER RESPONSE::' + response.body.toString());
      return ModelCommonResponse.fromJson(jsonDecode(response.body));
    }
  } on SocketException {
    Helpers.hideLoader(loader);
    return ModelCommonResponse(message: "No Internet Access");
  } catch (e) {
    Helpers.hideLoader(loader);
    return ModelCommonResponse(message: e.toString(),);
  }
}
