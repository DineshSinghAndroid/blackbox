import 'package:blackbox/Controllers/ProjectControllers/SignUpController/sign_up_controller.dart';
import 'package:blackbox/View/auth/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../Utils/Common_textfield.dart';
import '../../Utils/app_theme.dart';
import '../../Utils/button.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with SingleTickerProviderStateMixin {
  TextEditingController passwordController = TextEditingController();
  SignUpController signUpController = Get.put(SignUpController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return GetBuilder(
      init: signUpController,
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: ScrollConfiguration(
            behavior: MyBehavior(),
            child: Form(
              key: formkey,
              child: SingleChildScrollView(
                child: SafeArea(
                  child: SizedBox(
                    height: _height,
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 90),
                              child: Image.asset('assets/images/bbx.jpeg'),
                            ),

                            CommonTextFieldWidget(
                              prefix: Icon(
                                Icons.account_circle_outlined,
                                color: Colors.black54.withOpacity(0.4),
                              ),
                              hint: 'Name',
                              controller: signUpController.usernameController,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              bgColor: Colors.black54.withOpacity(0.4),
                              validator: MultiValidator([
                                RequiredValidator(errorText: 'Please enter name'),
                                //MinLengthValidator(10, errorText: 'Invalid Number'),
                              ]),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CommonTextFieldWidget(
                              prefix: Icon(
                                Icons.account_circle_outlined,
                                color: Colors.black54.withOpacity(0.4),
                              ),
                              hint: 'Phone',
                              controller: signUpController.phoneController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              bgColor: Colors.black54.withOpacity(0.4),
                              validator: MultiValidator([
                                RequiredValidator(errorText: 'Please enter phone number'),
                                MinLengthValidator(10, errorText: 'Invalid Number'),
                              ]),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            //component1(Icons.account_circle_outlined, 'Phone', false, false, phone, TextInputType.number),
                            CommonTextFieldWidget(
                              prefix: Icon(
                                Icons.email_outlined,
                                color: Colors.black54.withOpacity(0.4),
                              ),
                              hint: 'Email',
                              controller: signUpController.emailController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              bgColor: Colors.black54.withOpacity(0.4),
                              validator: MultiValidator([
                                EmailValidator(errorText: 'Please enter valid email'),
                                RequiredValidator(errorText: 'Please enter name'),
                                //MinLengthValidator(10, errorText: 'Invalid Number'),
                              ]),
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            CommonTextFieldWidget(
                              prefix: Icon(
                                Icons.lock_outline,
                                color: Colors.black54.withOpacity(0.4),
                              ),
                              hint: 'Password',
                              obscureText: true,
                              controller: signUpController.passwordController,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              bgColor: Colors.black54.withOpacity(0.4),
                              validator: MultiValidator([
                                PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: "password must be 8 character long and contain \n1 alphabetic, \n1 special character and \n1 number"),
                                RequiredValidator(errorText: 'Please Enter Password'),
                                //MinLengthValidator(10, errorText: 'Invalid Number'),
                              ]),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            //component1(Icons.lock_outline, 'Password', true, false, password, TextInputType.visiblePassword),
                            Align(
                              alignment: Alignment.center,
                              child: CommonButton("SIGN-IN", () {
                                if (formkey.currentState!.validate()) {
                                  signUpController.checkSignUp(context: context);
                                }
                              }),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 35,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'Login to existing Account !',
                                    style: const TextStyle(color: AppTheme.primaryColorBlue),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => LoginScreen(),
                                            ));
                                        HapticFeedback.lightImpact();
                                        Fluttertoast.showToast(
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.TOP,
                                          msg: 'Login to continue',
                                        );
                                      },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget component1(IconData icon, String hintText, bool isPassword, bool isEmail, Controller, type) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      height: Get.height * 0.08,
      width: Get.width * 0.80,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: _width / 30),
      decoration: BoxDecoration(
          // color: AppTheme.gray,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black, width: 1)),
      margin: const EdgeInsets.all(6),
      child: TextFormField(
        style: TextStyle(color: Colors.black.withOpacity(.9)),
        obscureText: isPassword,
        controller: Controller,
        keyboardType: type,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.black.withOpacity(.7),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: AppTheme.black,
          ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
