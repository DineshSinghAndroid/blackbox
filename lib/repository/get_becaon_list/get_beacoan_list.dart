import 'dart:convert';
import 'dart:io';
import 'package:blackbox/Utils/Helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../Model/getBeacoanListModel/getBeaconListModel.dart';

Future<GetBeaconListModel> getBeaconList({username}) async {
  try {
    var auth =
        "https://bbxlite.azurewebsites.net/api/getSensorsList?code=LxkCOnsItt5Xn0xSFdu5Y4MgW1_st6AzNrCmIqK_ftL-AzFumJXnFg==";

    var map = <String, dynamic>{};
    map['username'] = '1111444411';
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };
    http.Response response = await http.post(Uri.parse(auth),
        headers: headers, body: jsonEncode(map));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body.toString());

      return GetBeaconListModel.fromJson(jsonDecode(response.body));
    } else {
      return GetBeaconListModel.fromJson(jsonDecode(response.body));
    }
  } catch (e) {
    return GetBeaconListModel();
  }
}
