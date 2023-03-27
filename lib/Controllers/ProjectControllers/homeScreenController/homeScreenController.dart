import 'package:blackbox/Controllers/ApiController/WebConstant.dart';
import 'package:blackbox/Utils/Loader/LoadingScreen.dart';
import 'package:blackbox/Utils/PrintLog/PrintLog.dart';
import 'package:blackbox/Utils/Toast/ToastCustom.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Model/getBeacoanListModel/getBeaconListModel.dart';
import '../../ApiController/ApiController.dart';

class HomeScreenController extends GetxController {
  final ApiController _apiCtrl = ApiController();
  GetBeaconListModel? allBeaconList;

  Future<GetBeaconListModel?> getAllBeaconList({required BuildContext context}) async {
    CustomLoading().show(context, true);
    Map<String, dynamic> dictparam = {"username":"1111444411"};
    PrintLog.printLog(dictparam);
    String url = WebApiConstant.getAllBeaconList;
    await _apiCtrl.getAllBeaconListApi(url: url, context: context, dictParameter: dictparam).then((result) {
      if (result != null) {
        try {
          allBeaconList = result;
          print("All Beacon List Length is ${allBeaconList?.beacon?.length}");
        } catch (e) {
          CustomLoading().show(context, false);
          PrintLog.printLog("Execption at get home screen is $e");
        }
      }
      else {
        CustomLoading().show(context, false);
        ToastCustom.showToast(msg: "No Data Found");
      }
    });
  }
}
