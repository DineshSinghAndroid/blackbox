import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
 
 
class BarcodeScanners extends StatefulWidget {
  BarcodeScanners({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _BarcodeScannersState createState() => _BarcodeScannersState();
}

class _BarcodeScannersState extends State<BarcodeScanners> {
  String? _qrInfo = 'Scan a QR/Bar code';
  bool _camState = false;

  TextEditingController addNameController = TextEditingController();

  _qrCallback(String? code) {
    setState(() {
      _camState = false;
      _qrInfo = code;
    });
  }

  _scanCode() {
    setState(() {
      _camState = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _scanCode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body:
      // _camState
      //     ?
      Center(
        child: SizedBox(
          height: 1000,
          width: 500,
          child: QRBarScannerCamera(
            onError: (context, error) => Text(
              error.toString(),
              style: TextStyle(color: Colors.red),
            ),
            qrCodeCallback: (code) {
              _qrCallback(code);
            },
          ),
        ),
      )
      //     : Center(
      //   child: Text(_qrInfo!),
      // ),
    );
  }
}