import 'dart:developer';

import 'package:blackbox/DATABASE/db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

import '../listed_barcodes.dart';
import 'ScannerListConstructor.dart';

class BarcodeScanner extends StatefulWidget {
  const BarcodeScanner({Key? key}) : super(key: key);

  @override
  State<BarcodeScanner> createState() => _BarcodeScannerState();
}

String barcodeScanRes = '';

class _BarcodeScannerState extends State<BarcodeScanner> {
  String _scanBarcode = 'Unknown';

  TextEditingController deviceNameController = TextEditingController();

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    log(studentsdata!.length.toString());

    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 35.w),
          child: Column(
            children: [
              SizedBox(height: 40,)
              ,
              Text(
                "BBX VISIBLE",
                style: TextStyle(
                    fontSize: 43.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              SizedBox(
                height: _height / 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 150.h,
                    width: 130.w,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.blue),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () => scanQR().then((value) {
                            if (_scanBarcode != '') {
                              AddBarcodeName(context);
                            }
                          }),
                          child: Container(
                              height: 100.h,
                              // width: 100,
                              child: Lottie.network(
                                  'https://assets7.lottiefiles.com/packages/lf20_2sapbqfh.json')),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        const Text(
                          "Device Add \n& Naming",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListedBarcodes(),
                          ));
                    },
                    child: Container(
                      height: 150.h,
                      width: 130.w,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.blue),
                      child: Column(
                        children: [
                          Container(
                              height: 100.h,
                              // width: 100,
                              child: Lottie.network(
                                  'https://assets9.lottiefiles.com/packages/lf20_49rdyysj.json')),
                          Spacer(),
                          const Text(
                            "View Data",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),



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
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          content: Text("Please Enter Device Details"),
          actions: [
            TextFormField(
                controller: deviceNameController,
                decoration: (InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.black)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.black)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.black)),
                    hintText: "Enter Device Name ",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.black))))),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                readOnly: true,
                decoration: (InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.black)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.black)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.black)),
                    hintText: _scanBarcode.toString(),
                    hintStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.black))))),
            SizedBox(
              height: 20,
            ),
            Center(
              child: MaterialButton(
                color: Colors.blue,
                child: Text("ADD"),
                onPressed: () {
                  print(barcodeScanRes.toString());
                  setState(() {});
                  if (_scanBarcode != '' && deviceNameController.text != '') {
                    studentsdata.add(Student(
                        macID: _scanBarcode,
                        name: deviceNameController.text.toString()));
                    Navigator.pop(context);
                    deviceNameController.clear();
                  } else {
                    Fluttertoast.showToast(msg: "Please Enter Device Name");
                  }
                },
              ),
            )
          ],
        );
      },
    );
  }
}
