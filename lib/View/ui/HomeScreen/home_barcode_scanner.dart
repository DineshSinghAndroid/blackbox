import 'dart:convert';
import 'dart:io';

import 'package:blackbox/Controllers/ProjectControllers/homeScreenController/homeScreenController.dart';
import 'package:blackbox/Utils/app_theme.dart';
import 'package:blackbox/View/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:progress_state_button/progress_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Model/getBeacoanListModel/getBeaconListModel.dart';
import '../../../Utils/Helper.dart';
import '../../../Utils/WebConstants.dart';
import '../../../main.dart';
import '../../../repository/device_register_repository.dart';
import '../../../repository/update_assetname_repo.dart';
import '../Listed Barcodes List Screen/listed_barcodes.dart';
import '../Webview/webview.dart';

class BarcodeScanner extends StatefulWidget {
  const BarcodeScanner({Key? key}) : super(key: key);

  @override
  State<BarcodeScanner> createState() => _BarcodeScannerState();
}

ButtonState stateOnlyText = ButtonState.idle;
ButtonState stateTextWithIcon = ButtonState.idle;
String barcodeScanRes = '';
String username = '';
String password = '';
HomeScreenController homeCtrl = Get.put(HomeScreenController());

class _BarcodeScannerState extends State<BarcodeScanner> {
  bool becanAdded = false;

  void initState() {
    init();
  }

  // void dispose() {
  //   deviceNameController.dispose();
  // }
  String _scanBarcode = '';

  TextEditingController deviceNameController = TextEditingController();

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return GetBuilder(
      init: homeCtrl,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                controller.getAllBeaconList(context: context);
              },
            ),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 35.w),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Image.asset('assets/images/bbx.jpeg'),
                  SizedBox(
                    height: _height / 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 120.h,
                            width: 130.w,
                            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: AppTheme.viewdata),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    await getDKSbeacons(context);
                                    if (dks.isNotEmpty) {
                                      scanQR().then((value) {
                                        // print(dks.elementAt(1).beacon?.length);
                                        // print(_scanBarcode);
                                        var sdk = dks.where((element) => element.beacon == _scanBarcode.substring(0, 17));
                                        if (sdk.isNotEmpty) {
                                          if (_scanBarcode != '-1') {
                                            askConfermationForRename(context);
                                          } else {
                                            Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.TOP, msg: "Please Scan Correct Barcode");
                                          }
                                        } else {
                                          if (_scanBarcode != '-1') {
                                            AddBarcodeName(context);
                                          } else {
                                            Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.TOP, msg: "Please Scan Correct Barcode");
                                          }
                                        }
                                      });
                                    } else {
                                      if (_scanBarcode != '-1') {
                                        scanQR().then((value) {
                                          // print(dks.elementAt(1).beacon?.length);
                                          // print(_scanBarcode);
                                          AddBarcodeName(context);
                                        });
                                      } else {
                                        // Navigator.pop(context);
                                        setState(() {
                                          _scanBarcode = '';
                                        });
                                        Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.TOP, msg: "Please Scan Correct Barcode");
                                      }
                                    }
                                  },
                                  child: Container(
                                      height: 100.h,
                                      // width: 100,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Image.asset('assets/images/viewdata.jpg'),
                                      )),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          const Text(
                            "Device Add & Naming",
                            style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              getDKbeacons(context);
                              // MaterialPageRoute(
                              //   builder: (context) => ListedBarcodes(),
                              // ),
                              // (route) => false));
                            },
                            child: Container(
                              height: 120.h,
                              width: 130.w,
                              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: AppTheme.viewdata),
                              child: Column(
                                children: [
                                  Container(
                                      height: 100.h,
                                      // width: 100,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Image.asset('assets/images/qrCode.jpg'),
                                      )),
                                  const Spacer(),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          const Text(
                            "View Data",
                            style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebViewApp(),
                          ));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      decoration: const BoxDecoration(color: AppTheme.primaryColorBlue, borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: const Text(
                        "BBX Visible",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: onPressedIconWithText,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                      decoration: const BoxDecoration(color: AppTheme.primaryColorBlue, borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  AddBarcodeName(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          height: double.minPositive,
          child: AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            actions: [
              const Center(
                child: Text(
                  "Please Enter Device Details",
                  style: TextStyle(color: AppTheme.viewdata, fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                height: 1.0,
                color: Colors.grey,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text("Enter Device Name"),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                  controller: deviceNameController,
                  decoration: (InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.3),
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: "Device 001 ",
                  ))),
              const SizedBox(
                height: 10,
              ),
              const Align(alignment: Alignment.topLeft, child: Text("MAC ID")),
              TextFormField(
                  readOnly: true,
                  decoration: (InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.3),
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: _scanBarcode.toString(),
                      hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),
                      border: InputBorder.none))),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: MaterialButton(
                  color: AppTheme.primaryColorBlue,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Add Details",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () {
                    print(barcodeScanRes.toString());
                    if (_scanBarcode != '-1' && deviceNameController.text != '') {
                      deviceRegister(
                        phone: username,
                        password: password,
                        qrcode: _scanBarcode,
                        assetsName: deviceNameController.text,
                        context: context,
                      ).then((value) async {
                        if (value.message == 'Successfully registered device with your account') {
                          print(value.message);

                          // studentsdata.add(Student(macID: _scanBarcode, name: deviceNameController.text));
                          print(deviceNameController.text.toString());
                          Navigator.pop(context);
                          deviceNameController.clear();
                        } else {
                          Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.TOP, msg: value.message.toString());
                          Navigator.pop(context);
                          deviceNameController.clear();
                        }
                      });
                    } else if (_scanBarcode == '-1') {
                      Navigator.pop(context);

                      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.TOP, msg: "Please Scan Again");
                    } else if (deviceNameController.text == '') {
                      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.TOP, msg: "Please Enter Device Name");
                    } else {
                      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.TOP, msg: "Please Scan Correct Barcode");
                    }
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  askConfermationForRename(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return SizedBox(
          height: double.minPositive,
          child: AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            actions: [
              const Center(
                child: Text(
                  "Device Already Registered!",
                  style: TextStyle(color: AppTheme.viewdata, fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                height: 1.0,
                color: Colors.grey,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text("Do you want to Rename?"),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    color: AppTheme.primaryColorBlue,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "No",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  MaterialButton(
                    color: AppTheme.primaryColorBlue,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Rename",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      updateBarCodeName(context);
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  updateBarCodeName(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return SizedBox(
          height: double.minPositive,
          child: AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            actions: [
              const Center(
                child: Text(
                  "Rename Device",
                  style: TextStyle(color: AppTheme.viewdata, fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                height: 1.0,
                color: Colors.grey,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text("Enter Device Name"),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                  controller: deviceNameController,
                  decoration: (InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.3),
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: "Device 001",
                  ))),
              const SizedBox(
                height: 10,
              ),
              const Align(alignment: Alignment.topLeft, child: Text("MAC ID")),
              TextFormField(
                  readOnly: true,
                  decoration: (InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.3),
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: _scanBarcode.toString(),
                      hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),
                      border: InputBorder.none))),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: MaterialButton(
                  color: AppTheme.primaryColorBlue,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Rename Device",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () {
                    print(barcodeScanRes.toString());
                    setState(() {});
                    if (_scanBarcode != '-1' && deviceNameController.text != '') {
                      updateAssets(qrCode: _scanBarcode.toString(), asset_name: deviceNameController.text.toString(), context: context).then((value) async {
                        // studentsdata[studentsdata.indexWhere((element) => element.macID == _scanBarcode.toString())] =
                        //     Student(macID: _scanBarcode, name: deviceNameController.text.toString());

                        Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.TOP, msg: value.message.toString());
                        Navigator.pop(context);
                        deviceNameController.clear();
                      });
                      // studentsdata.add(Student(macID: _scanBarcode, name: deviceNameController.text));
                      deviceNameController.clear();

                      Navigator.pop(context);
                    } else if (_scanBarcode == '-1') {
                      Navigator.pop(context);
                      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.TOP, msg: "Please Scan Again");
                    } else if (deviceNameController.text == '') {
                      Navigator.pop(context);
                      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.TOP, msg: "Please Enter Device Name");
                    } else {
                      Navigator.pop(context);
                      Fluttertoast.showToast(toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.TOP, msg: "Please Scan Correct Barcode");
                    }
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> onPressedIconWithText() async {
    dk.clear();
    dks.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(WebConstants.USERNAME);
    prefs.remove(WebConstants.PASSWORD);
    prefs.setBool(WebConstants.IS_USER_LOGGED_IN, false);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
  }

  init() async {
    // getDKSbeacons();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString(WebConstants.USERNAME).toString();
      password = prefs.getString(WebConstants.PASSWORD).toString();
      print("USERNAME AND PASSWORD IS $username$password");
    });
  }
}

Future<List<GetBeaconListModel>> getDKSbeacons(context) async {
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
  Helpers.hideLoader(loader);
  if (response.statusCode == 200) {}
  print("${response.statusCode} steadfastness");
  var data = jsonDecode(response.body.toString());
  for (Map i in data) {
    // dks.add(GetBeaconListModel.fromJson(i));
  }
  return dks;
}
