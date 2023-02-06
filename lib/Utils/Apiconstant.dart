import 'dart:developer';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class ApiUrls {

  static const String apiBaseUrl = 'https://bbxlite.azurewebsites.net/api/';
  static const String loginUrl = "${apiBaseUrl}login";
  static const String signupUrl = "${apiBaseUrl}registerUser?code=cy0as7vMMt_Mi7bu6OAJOdLeCUCdlhNc3fhPhy8HpKsAzFuA4OAaA==";

}

getAuthHeader() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  log("User Token.....  ${pref.getString("cookie")}");
  return {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader:
    'Bearer ${pref.getString("cookie")!.toString().replaceAll('\"', '')}'
  };
}
