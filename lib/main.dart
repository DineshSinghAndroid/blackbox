
import 'package:blackbox/View/auth/login_screen.dart';
import 'package:blackbox/View/ui/home_barcode_scanner.dart';
import 'package:drift/native.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'DATABASE/db.dart';

Future <void> main()async {
  final db = Database(NativeDatabase.memory());

  (await db.select(db.scannerResult).get()).forEach((print));
  // await db.into(db.scannerResult).insert(const
  // ScannerResultCompanion(title: 'Singh', description: "Sir"));
   runApp(   const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Alert Ware',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child: LoginScreen(),
    );
  }
}