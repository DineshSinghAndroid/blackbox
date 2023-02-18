import 'package:blackbox/Utils/Common_textfield.dart';
import 'package:flutter/material.dart';

import '../../Utils/app_theme.dart';

class ForgotPasswordScreen extends StatefulWidget {
  String username;

  ForgotPasswordScreen({Key? key, required this.username}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: 50, vertical: 100), child: Image.asset('assets/images/bbx.jpeg')),
            CommonTextFieldWidget(
              hint: "Email",
            ),
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  decoration: BoxDecoration(color: AppTheme.primaryColorBlue, borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 100,)
            ,
            Text("We will Send a password reset mail ")

          ],
        ),
      ),
    );
  }
}
