import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import '../Model/ModelRegistration.dart';
import '../Utils/Helper.dart';

Future<ModelRegister> signupRepo({name, phone , email, password ,username,context}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);

  try {
    var auth = 'https://bbxlite.azurewebsites.net/api/registerUser?code=cy0as7vM-Mt_Mi7bu6OAJOdLeCUCdlhNc3fhPhy8HpKsAzFuA4OAaA==';

    var map = <String, dynamic>{};
    map['name'] = name;
    map['phone'] = phone;
    map['email'] = email;
    map['username'] = username;
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
      return ModelRegister.fromJson(jsonDecode(response.body));
    } else {
      Helpers.hideLoader(loader);
      print('SEREVER RESPONSE::' + response.body.toString());
      return ModelRegister.fromJson(jsonDecode(response.body));
    }
  } on SocketException {
    Helpers.hideLoader(loader);
    return ModelRegister(message: "No Internet Access");
  } catch (e) {
    Helpers.hideLoader(loader);
    return ModelRegister(message: e.toString(),);
  }
}
