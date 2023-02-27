import 'dart:developer';

import 'package:blackbox/Model/getBeacoanListModel/getBeaconListModel.dart';
import 'package:blackbox/View/ui/Home/home_barcode_scanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import '../../../repository/get_becaon_list/get_beacoan_list.dart';
import '../Home/ScannerListConstructor.dart';
import '../ShowBecoanData/showBecoanData.dart';

class ListedBarcodes extends StatefulWidget {
  const ListedBarcodes({Key? key}) : super(key: key);

  @override
  State<ListedBarcodes> createState() => _ListedBarcodesState();
}


List<Student> studentsdata = [];
List<GetBeaconListModel> dk = [];

class _ListedBarcodesState extends State<ListedBarcodes> {

  @override
  void initState() {
    init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    log(dk.length.toString());
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          title: const Text("Your Devices"),
          centerTitle: true,
          brightness: Brightness.dark),
      body: Column(
        children: [
          Container(
            height: 500,
            child: AnimationLimiter(
              child: ListView.builder(
                padding: EdgeInsets.all(_w / 30),
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: dk.length,
                itemBuilder: (BuildContext c, int i) {
                  return AnimationConfiguration.staggeredList(
                    position: i,
                    delay: const Duration(milliseconds: 100),
                    child: SlideAnimation(
                      duration: const Duration(milliseconds: 2500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      horizontalOffset: 30,
                      verticalOffset: 300.0,
                      child: FlipAnimation(
                        duration: const Duration(milliseconds: 3000),
                        curve: Curves.fastLinearToSlowEaseIn,
                        flipAxis: FlipAxis.y,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShowBeconDataScreen(),
                                ));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            margin: EdgeInsets.only(bottom: _w / 20),
                            height: _w / 4,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 40,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Lottie.network(
                                    'https://assets8.lottiefiles.com/packages/lf20_m8V12i.json'),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Device name is :",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          dk[i].assetName.toString(),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                       ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Mac id:",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          dk[i].beacon.toString(),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        )
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
                  );
                },
              ),
            ),
            
          ),
          MaterialButton(onPressed: GetBeaconsListFromAPI,child: Text("hii"),),



        ],
      ),
    );
  }

  Future<void> GetBeaconsListFromAPI() async {

    await getBeaconList( ).then((value)  {
     });

  }

  void init() {}
}
