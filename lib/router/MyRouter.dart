import 'package:get/get.dart';
import '../View/auth/login_screen.dart';
import '../View/auth/signup_screen.dart';

class MyRouter {
  static var splashScreen = "/splashScreen";
  static var loginScreen = "/loginScreen";
  static var signupScreen = "/signupScreen";
  static var onboarding = "/onboarding";


  static var route = [
    GetPage(name: '/', page: () =>  LoginScreen()),

    GetPage(name: MyRouter.loginScreen, page: () => LoginScreen()),

    GetPage(name: MyRouter.signupScreen, page: () =>  SignupScreen()),

  ];
}
