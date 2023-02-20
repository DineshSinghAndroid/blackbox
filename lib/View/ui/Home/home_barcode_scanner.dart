import 'dart:convert';
import 'dart:developer';

import 'package:blackbox/DATABASE/db.dart';
import 'package:blackbox/DB/DB_helper.dart';
import 'package:blackbox/Utils/app_theme.dart';
import 'package:blackbox/View/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utils/WebConstants.dart';
import '../../../repository/device_register_repository.dart';
import '../../../router/MyRouter.dart';
import '../Listed Barcodes List Screen/listed_barcodes.dart';
import 'ScannerListConstructor.dart';

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

class _BarcodeScannerState extends State<BarcodeScanner> {
  bool becanAdded = false;

  void initState() {
    setState(() {
      ButtonState.idle;
      stateTextWithIcon = ButtonState.idle;
    });
    init();
  }

  void dispose() {}
  String _scanBarcode = 'Unknown';

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
    log(studentsdata.length.toString());

    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
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
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: AppTheme.viewdata),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () => scanQR().then((value) {
                                if (_scanBarcode != '-1') {
                                  AddBarcodeName(context);
                                } else {
                                  Fluttertoast.showToast(msg: "Please Scan Correct Barcode");
                                }
                              }),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ListedBarcodes(),
                              ));
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
              // ProgressButton.icon(iconedButtons: {
              //   ButtonState.idle: IconedButton(text: 'Logout', icon: const Icon(Icons.logout, color: Colors.white), color: Colors.deepPurple.shade500),
              //   ButtonState.loading: IconedButton(text: 'Loading', color: Colors.deepPurple.shade700),
              //   ButtonState.fail: IconedButton(text: 'Failed', icon: const Icon(Icons.cancel, color: Colors.white), color: Colors.red.shade300),
              //   ButtonState.success: IconedButton(
              //       text: 'Success',
              //       icon: const Icon(
              //         Icons.check_circle,
              //         color: Colors.white,
              //       ),
              //       color: Colors.green.shade400)
              // }, onPressed: onPressedIconWithText, state: stateTextWithIcon),
              // MaterialButton(onPressed: () async {
              //   var dbquery = await DatabaseHelper.instance.queryDatabase();
              //   print(dbquery);
              // },child: Text("print"),)
              InkWell(
                onTap:onPressedIconWithText,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 60,vertical: 15),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColorBlue,
borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: Text("Logout",style: TextStyle(
                    color: Colors.white
                  ),),
                ),
              )
            ],
          ),
        ),
      ),
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
            content: const Text("Please Enter Device Details",style: TextStyle(
              color: AppTheme.primaryColorBlue,fontWeight: FontWeight.w500
            ),),
            actions: [
               Align(
                alignment: Alignment.topLeft,
                child:Text("Enter Device Name"),
              ),
          SizedBox(height: 5,)
              ,

          TextFormField(

                  controller: deviceNameController,
                  decoration: (

                        InputDecoration(
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
              Align(
                  alignment: Alignment.topLeft,
                  child: const Text("MAC ID")),

              TextFormField(
                  readOnly: true,
                  decoration: (InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.3),


                      enabledBorder:  InputBorder.none,
                      disabledBorder:  InputBorder.none,
                      errorBorder:  InputBorder.none,
                      focusedBorder:  InputBorder.none,
                      hintText: _scanBarcode.toString(),
                      hintStyle:  TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16),
                      border:  InputBorder.none))),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: MaterialButton(
                  color: AppTheme.primaryColorBlue,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Add Details",style: TextStyle(color: Colors.white),),
                  ),
                  onPressed: () {
                    print(barcodeScanRes.toString());
                    setState(() {});

                    if (_scanBarcode != '-1' && deviceNameController.text != '') {
                      // Fluttertoast.showToast(msg: "Device added sucessfull");
                      deviceRegister(
                        phone: username,
                        password: password,
                        qrcode: _scanBarcode,
                        assetsName: deviceNameController.text,
                        context: context,
                      ).then((value) async {
                        if (value.message != 'Successfully registered device with your account') {
                          print(value.message);
                          //insert data to database
                          await DatabaseHelper.instance.insertRecord(
                              {DatabaseHelper.deviceName: deviceNameController.text,
                                 });

                          studentsdata.add(Student(macID: _scanBarcode, name: deviceNameController.text));
                          print(deviceNameController.text.toString());
                          // Get.back();
                        }
                      });

                      Navigator.pop(context);
                    } else if (_scanBarcode == '-1') {
                      Fluttertoast.showToast(msg: "Please Scan Again");
                    } else if (deviceNameController.text == '') {
                      Fluttertoast.showToast(msg: "Please Enter Device Name");
                    } else {
                      Fluttertoast.showToast(msg: "Please Scan Correct Barcode");
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString(WebConstants.USERNAME).toString();
      password = prefs.getString(WebConstants.PASSWORD).toString();
      print("USERNAME AND PASSWORD IS " + username.toString() + password.toString());
    });
  }
}
