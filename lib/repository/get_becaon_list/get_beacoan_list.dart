import 'dart:convert';
import 'dart:io';
import 'package:blackbox/Utils/Helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../Model/getBeacoanListModel/getBeaconListModel.dart';

Future<GetBeaconListModel> getBeaconListrepo(username, BuildContext context) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);
  try {
    var auth =
        "https://bbxlite.azurewebsites.net/api/getSensorsList?code=LxkCOnsItt5Xn0xSFdu5Y4MgW1_st6AzNrCmIqK_ftL-AzFumJXnFg==";

    var map = <String, dynamic>{};
    map['username'] = username;
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };
    http.Response response = await http.post(Uri.parse(auth), body: jsonEncode(map), headers: headers);
    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      return GetBeaconListModel.fromJson(jsonDecode(response.body));
    }  else {
      Helpers.hideLoader(loader);
      return GetBeaconListModel();
    }
  } on SocketException {
    return GetBeaconListModel();
  } catch (e) {
    Helpers.hideLoader(loader);
    return GetBeaconListModel();
  }
}
