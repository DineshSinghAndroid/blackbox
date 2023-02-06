// import 'dart:convert';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:http/http.dart' as http;
// import 'dart:io';
//
// import '../Model/ModelRegistration.dart';
// import '../Utils/Apiconstant.dart';
//
// Future<ModelRegister> signupRepo({name, phone, username , email, password }) async {
//
//   try {
//     var auth = "cy0as7vM-Mt_Mi7bu6OAJOdLeCUCdlhNc3fhPhy8HpKsAzFuA4OAaA==";
//
//     var map = <String, dynamic>{};
//     map['name'] = "name";
//     map['phone'] = "phone";
//     map['username'] = "username";
//     map['email'] = "email";
//     map['password'] = "password";
//     print(map);
//
//     final headers = {
//       HttpHeaders.contentTypeHeader: 'text/plain; charset=utf-8',
//       HttpHeaders.acceptHeader: 'application/json',
//       HttpHeaders.authorizationHeader: 'cy0as7vM-Mt_Mi7bu6OAJOdLeCUCdlhNc3fhPhy8HpKsAzFuA4OAaA==',
//     };
//
//     http.Response response = await http.post(Uri.parse("https://bbxlite.azurewebsites.net/api/registerUser?code=cy0as7vMMt_Mi7bu6OAJOdLeCUCdlhNc3fhPhy8HpKsAzFuA4OAaA=="), body: jsonEncode(map), headers: headers);
//     print(response.statusCode.toString());
//
//     if (response.statusCode == 200) {
//       print('SEREVER RESPONSE::' + response.statusCode.toString());
//       return ModelRegister.fromJson(jsonDecode(response.body));
//     } else {
//       print('SEREVER RESPONSE::' + response.body.toString());
//       return ModelRegister.fromJson(jsonDecode(response.body));
//     }
//   } on SocketException {
//     return ModelRegister(message: "No Internet Access");
//   } catch (e) {
//     return ModelRegister(message: e.toString(),);
//   }
// }
