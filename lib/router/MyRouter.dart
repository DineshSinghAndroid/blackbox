import 'package:get/get.dart';
import '../View/auth/ForgotPassword_otp.dart';
import '../View/auth/login_screen.dart';
import '../View/auth/signup_screen.dart';
import '../View/auth/splash_screen.dart';
import '../View/auth/verifyOTPScreen.dart';
 import '../View/ui/HomeScreen/home_barcode_scanner.dart';
import '../View/ui/Listed Barcodes List Screen/listed_barcodes.dart';

class MyRouter {
  static var splashScreen = "/splashScreen";
  static var loginScreen = "/loginScreen";
  static var signupScreen = "/signupScreen";
  // static var verifyOtp = "/verifyOtp";
  static var barcodeScreen = "/barcodeScreen";
  static var barcodelist = "/barcodelist";
  static var verifyOtp = "/verifyOtp";


  static var route = [
    GetPage(name: '/', page: () =>  SplashScreen()),
    GetPage(name: MyRouter.splashScreen, page: () => SplashScreen()),
    GetPage(name: MyRouter.loginScreen, page: () => LoginScreen()),
    GetPage(name: MyRouter.signupScreen, page: () =>  SignupScreen()),
    // GetPage(name: MyRouter.verifyOtp, page: () =>   VerifyOTPScreen()),
    GetPage(name: MyRouter.barcodeScreen, page: () =>   BarcodeScanner()),
    GetPage(name: MyRouter.barcodelist, page: () =>   ListedBarcodes()),
    GetPage(name: MyRouter.verifyOtp, page: () =>   VerifyOtp()),
  ];
}
