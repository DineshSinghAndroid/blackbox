import 'package:blackbox/router/MyRouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sqflite/sqflite.dart';


class BarcodeScanner extends StatefulWidget {
  @override
  _BarcodeScannerState createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String _scanBarcode = 'Unknown';


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: .7, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    )
      ..addListener(
        () {
          setState(() {});
        },
      )
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            _controller.reverse();
          } else if (status == AnimationStatus.dismissed) {
            _controller.forward();
          }
        },
      );

    _controller.forward();
  }



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 35.w),
            child: Column(
              children: [
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
                            onTap: () => barcodeScan(),
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
                    Container(
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

                  ],
                ),
                SizedBox(height: 30,)
                ,
                InkWell(
                  onTap: (){
                    //AddBarcodeName(context);
                  },
                  child: Text('Scan result : $_scanBarcode\n',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> barcodeScan() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR).then((value) {
            return _displayTextInputDialog(context);
      });

      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }
}

 _displayTextInputDialog(BuildContext context) async {
 TextEditingController qrcode = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('TextField in Dialog'),
          content: TextField(
            onChanged: (value) {
              qrcode.text = _scanBarcode.toString();
              qrcode.text = value.toString();
            },
            controller: qrcode,
            decoration: InputDecoration(hintText: "Add Name"),
          ),
          actions: [
            TextButton(onPressed: (){
              Get.toNamed(MyRouter.barcodelist);
            }, child: Text('Submit'))
          ],
        );
      });
}


Future<Database?> openDB() {
  _database
}


class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }



}
