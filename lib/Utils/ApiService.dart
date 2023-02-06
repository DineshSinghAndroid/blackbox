import 'dart:convert';
import 'Apiconstant.dart';
import 'package:http/http.dart' as http;

class ApiService{

  Future<SignupAPI> apiCallsignup(Map<dynamic,dynamic> params ) async  {

    var url = Uri.parse(ApiUrls.signupUrl);
    http.Response response = await http.post(url, body: params);

    print('Response statuscode ${response.statusCode}');
    print('Response body  ${response.body}');

    final data = jsonEncode(response.body);
    return SignupAPI(token: data[int.parse('token')], error: data[int.parse('error')]);
  }
}


class SignupAPI {
  final String? token;
  final String? error;

  SignupAPI({this.token , this.error});
}