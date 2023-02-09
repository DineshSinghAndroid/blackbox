import 'package:blackbox/repository/signup_repository.dart';
import 'package:blackbox/repository/verifyotp_repository.dart';
import 'package:get/get.dart';

import '../Model/ModelRegistration.dart';

class GetApiDataController extends GetxController{

  Rx<ModelRegister> SignupModel = ModelRegister().obs;
  Rx<RxStatus> status = RxStatus.empty().obs;

  GetVerification(){
    verifyOtp().then((value) {

    });
  }



}