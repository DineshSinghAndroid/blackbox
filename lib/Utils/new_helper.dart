// import 'dart:io';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
//
// class NewHelper {
//   Future addFilePicker() async {
//     try {
//       final item = await FilePicker.platform.pickFiles();
//       if (item == null) {
//         return null;
//       } else {
//         return File(item.files.first.path!);
//       }
//     } on PlatformException catch (e) {
//       throw Exception(e);
//     }
//   }
//
//   Future addImagePicker(
//       {ImageSource imageSource = ImageSource.gallery,
//       int imageQuality = 100}) async {
//     try {
//       final item = await ImagePicker()
//           .pickImage(source: imageSource, imageQuality: imageQuality);
//       if (item == null) {
//         return null;
//       } else {
//         return File(item.path);
//       }
//     } on PlatformException catch (e) {
//       throw Exception(e);
//     }
//   }
// }
