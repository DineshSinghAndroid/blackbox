
import 'package:blackbox/Utils/WebConstants.dart';
 import 'package:blackbox/router/MyRouter.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
 import 'package:shared_preferences/shared_preferences.dart';
import 'Model/getBeacoanListModel/getBeaconListModel.dart';
import 'View/ui/HomeScreen/home_barcode_scanner.dart';

void main() {

   runApp(MyApp());
   getSharePrefs();
}

Future<void> getSharePrefs() async {
      final prefs = await SharedPreferences.getInstance().then((value) {
        SharedPreferences.getInstance().then((value) {

           username = value.getString(WebConstants.USERNAME)??'';
        });
   });
}

 List<GetBeaconListModel> dks = [];
List<GetBeaconListModel> dk = [];


class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          darkTheme: ThemeData.light(),
          defaultTransition: Transition.rightToLeft,
          debugShowCheckedModeBanner: false,
          initialRoute: "/splash",
          getPages: MyRouter.route,
          // home: IndexPage(),
          theme: ThemeData(
              fontFamily: 'Raleway',
              primaryColor: Colors.black,
              // highlightColor: AppTheme.primaryColor,
              scrollbarTheme: const ScrollbarThemeData().copyWith(
                thumbColor: MaterialStateProperty.all(Colors.white),
              ),
              colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white)),
        );
      },
    );
  }
}
