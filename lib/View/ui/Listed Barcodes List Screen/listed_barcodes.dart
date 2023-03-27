import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:blackbox/Model/getBeacoanListModel/getBeaconListModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utils/Helper.dart';
import '../../../Utils/WebConstants.dart';
import '../../../main.dart';
import '../HomeScreen/home_barcode_scanner.dart';
import '../ShowBecoanData/showBecoanData.dart';

class ListedBarcodes extends StatefulWidget {
  const ListedBarcodes({Key? key}) : super(key: key);

  @override
  State<ListedBarcodes> createState() => _ListedBarcodesState();
}

// List<Student> studentsdata = [];
Future<List<GetBeaconListModel>> getDKbeacons(context) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);
  var auth = "https://bbxlite.azurewebsites.net/api/getSensorsList?code=LxkCOnsItt5Xn0xSFdu5Y4MgW1_st6AzNrCmIqK_ftL-AzFumJXnFg==";

  var map = <String, dynamic>{};
  map['username'] = username;
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  http.Response response = await http.post(Uri.parse(auth), headers: headers, body: jsonEncode(map));
  print("${response.statusCode} steadfastness");
  Helpers.hideLoader(loader);
  if (response.statusCode == 200) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ListedBarcodes(),
        ));
    Helpers.hideLoader(loader);
  }
  var data = jsonDecode(response.body.toString());
  for (Map i in data) {
    // dk.add(GetBeaconListModel.fromJson(i));
  }
  return dk;
}

class _ListedBarcodesState extends State<ListedBarcodes> {
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    dk.clear();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log(dk.length.toString());
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          // leading: IconButton(onPressed: (){Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => BarcodeScanner(),));}, icon: Icon(Icons.arrow_back),),
          title: const Text("Your Devices"),
          centerTitle: true,
          brightness: Brightness.dark),
      body: Container(
        child: AnimationLimiter(
          child: ListView.builder(
            padding: EdgeInsets.all(_w / 30),
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: dk.length,
            itemBuilder: (BuildContext c, int i) {
              return AnimationConfiguration.staggeredList(
                position: i,
                delay: const Duration(milliseconds: 100),
                child: SlideAnimation(
                  duration: const Duration(milliseconds: 2500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  horizontalOffset: 30,
                  verticalOffset: 300.0,
                  child: FlipAnimation(
                    duration: const Duration(milliseconds: 3000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    flipAxis: FlipAxis.y,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowBeconDataScreen(),
                            ));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        margin: EdgeInsets.only(bottom: _w / 20),
                        height: _w / 4,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Lottie.network('https://assets8.lottiefiles.com/packages/lf20_m8V12i.json'),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Device name is :",
                                      style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    FittedBox(
                                      child: Text(
                                        dk[i].assetName.toString(),
                                        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Mac id:",
                                      style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      dk[i].beacon.toString(),
                                      style: const TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString(
      WebConstants.USERNAME,
    );
    setState(() {
      username = prefs.getString(
        WebConstants.USERNAME,
      )!;
      print("usernamesssssssssssssssss is " + username.toString());
    });
  }
}
