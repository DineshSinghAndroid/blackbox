import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../Model/getBeacoanListModel/getBeaconListModel.dart';
import '../../Utils/PrintLog/PrintLog.dart';
import '../../Utils/Toast/ToastCustom.dart';
import '../../Utils/connection_validater.dart';
import 'WebConstant.dart';

class ApiController {
  final Dio _dio = Dio();

  ///Sign up api
  Future<Object?> signUpApi({context, required String url, dictParameter, String? token}) async {
    var result;
    if (await ConnectionValidator().check()) {
      try {
        final response = await requestPostForApi(context: context, url: url, dictParameter: dictParameter, token: token ?? '');
        if (response != null) {
          result = response.statusCode;
          // PrintLog.printLog(result.message);
          return result;
        } else {
          PrintLog.printLog(response?.statusCode);
        }
      } catch (e) {
        PrintLog.printLog("Exception_main1: $e");

        return result;
      }
    } else {
      ToastCustom.showToast(msg: "Network Error");
    }
    return null;
  }



  ///get all beacon list api
  Future<GetBeaconListModel?> getAllBeaconListApi({context, required String url, dictParameter, String? token}) async {
    GetBeaconListModel? result;
    if (await ConnectionValidator().check()) {
      try {
        final response = await requestPostForApi(context: context, url: url,dictParameter: dictParameter,token: "");
        if (response?.data != null && response?.statusCode == 200) {
          result = GetBeaconListModel.fromJson(response?.data);
          return result;
        } else {
          return result;
        }
      } catch (e) {
        PrintLog.printLog("Exception_main1: $e");
        return result;
      }
    } else {
      ToastCustom.showToast( msg: "networkToastString");
    }
    return null;
  }


  ///Api methods *****************************
  // Future<Response?> requestGetForApi(
  //     {required context,String? url,Map<String, dynamic>? dictParameter, String? token}) async {
  //   try {
  //     Map<String, String> headers = {
  //       "Content-type": "application/json",
  //       // "Authkey": WebApiConstant.AUTH_KEY,
  //       "Authorization": "Bearer $token",
  //       "Connection": "Keep-Alive",
  //       "Keep-Alive": "timeout=5, max=1000",
  //       // "x-localization":"en",
  //     };
  //
  //     //  final prefs = await SharedPreferences.getInstance();
  //     // String userId = prefs.getString(AppSharedPreferences.userId) ?? "";
  //     //  String sessionId = prefs.getString(AppSharedPreferences.sessionId) ?? "";
  //
  //     PrintLog.printLog("Headers: $headers");
  //     PrintLog.printLog("Url:  $url");
  //     PrintLog.printLog("Token:  $token");
  //     PrintLog.printLog("DictParameter: $dictParameter");
  //
  //     BaseOptions options = BaseOptions(
  //         // baseUrl: WebApiConstant.BASE_URL,
  //         receiveTimeout: const Duration(minutes: 1),
  //         connectTimeout: const Duration(minutes: 1),
  //         headers: headers,
  //         validateStatus: (_) => true
  //     );
  //
  //     _dio.options = options;
  //     Response response = await _dio.get(url!, queryParameters: dictParameter);
  //     PrintLog.printLog("Response_headers: ${response.headers}");
  //     PrintLog.printLog("Response_data: ${response.data}");
  //
  //     if(response.data["authenticated"] == false){
  //       // PopupCustom.logoutPopUP(context: context);
  //     }
  //     return response;
  //
  //   } catch (error) {
  //     PrintLog.printLog("Exception_Main: $error");
  //     return null;
  //   }
  // }

  Future<Response?> requestPostForApi(
      {required context, required String url,required Map<String, dynamic> dictParameter,required String token}) async {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        // "Authkey": WebApiConstant.AUTH_KEY,
        "Authorization": "Bearer $token",
        "Connection": "Keep-Alive",
        "Keep-Alive": "timeout=5, max=1000"
      };

      PrintLog.printLog("Headers: $headers");
      PrintLog.printLog("Url:  $url");
      PrintLog.printLog("Token:  $token");
      PrintLog.printLog("DictParameter: $dictParameter");

      BaseOptions options = BaseOptions(
          // baseUrl: WebApiConstant.BASE_URL,
          receiveTimeout: const Duration(minutes: 1),
          connectTimeout: const Duration(minutes: 1),
          headers: headers);
      _dio.options = options;
      Response response = await _dio.post(url,
          data: dictParameter,
          options: Options(
              followRedirects: false,
              validateStatus: (status) => true,
              headers: headers));
      // if(response.data["authenticated"] == false){
      //   // PopupCustom.logoutPopUP(context: context);
      // }
      PrintLog.printLog("Response: $response");
      PrintLog.printLog("Response_headers: ${response.headers}");
      PrintLog.printLog("Response_realuri: ${response.realUri}");
      return response;
    } catch (error) {
      PrintLog.printLog("Exception_Main: $error");
      return null;
    }
  }


}
