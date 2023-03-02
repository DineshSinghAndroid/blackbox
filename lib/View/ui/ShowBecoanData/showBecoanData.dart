import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowBeconDataScreen extends StatefulWidget {
  const ShowBeconDataScreen({Key? key}) : super(key: key);

  @override
  State<ShowBeconDataScreen> createState() => _ShowBeconDataScreenState();
}

class _ShowBeconDataScreenState extends State<ShowBeconDataScreen> {
  @override
  void dispose() {

    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical:50),
              child:
              Column(crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('BBX' ,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Get.height * 0.05,
                        color: Colors.black,
                      ),
                    ),
                    Text('VISIBLE' ,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Get.height * 0.05,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height: Get.height * 0.04
                ),
                Stack(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: Get.height * 0.46,
                            width: Get.width * 0.46,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blueAccent.withOpacity(.5),
                                border: Border.all(color: Colors.blueAccent)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          Positioned(
                            top: Get.height * 0.09,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: Get.height * 0.28,
                              width: Get.width * 0.28,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueAccent,
                                  border:
                                  Border.all(color: Colors.blueAccent)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: Get.height * 0.18,
                        left: Get.width* 0.08,
                        right: Get.width* 0.06,
                        bottom: 0,
                        child: Stack(
                          children: [
                            Container(
                              height: Get.height * 0.30,
                              width: Get.width * 0.30,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Column(
                                    children: [
                                      Text('-1.25',
                                        style: TextStyle(
                                            fontSize: Get.height * 0.04,
                                            fontWeight:FontWeight.w400,
                                            color: Colors.white
                                        ),
                                      ),
                                      Text('dBm',
                                        style: TextStyle(
                                            fontSize:Get.height * 0.04,
                                            fontWeight:FontWeight.w400,
                                            color: Colors.white
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                            ),
                          ],
                        ),),
                    ]),

                Text('BlackBox' ,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.grey.withOpacity(0.6),
                  ),
                ),
                SizedBox(
                    height: 10
                ),
                Text('Cabin 1' ,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:18,
                      color: Colors.black
                  ),
                ),
                SizedBox(
                    height: 10
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: Get.width * 0.30,
                      height: Get.height * 0.08,
                      color: Colors.grey.shade300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Adv. Interval' ,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                              height: 10
                          ),
                          Text('1.110' ,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize:16,
                                color: Colors.blue
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Container(
                      width: Get.width * 0.30,
                      height: Get.height * 0.08,
                      color: Colors.grey.shade300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Battery Level' ,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                              height: 10
                          ),
                          Text('50%' ,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize:16,
                                color: Colors.blue
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height: 15
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: Get.height * 0.06,
                          width: Get.width* 0.06,
                          child: Image.asset(
                            'assets/temp.png',
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Temperature' ,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                                height: 10
                            ),
                            Text('50%' ,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize:16,
                                  color: Colors.blue
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: Get.height * 0.06,
                          width: Get.width* 0.06,
                          child: Image.asset(
                            'assets/hum.png',
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Humidity' ,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                                height: 10
                            ),
                            Text('50%' ,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize:16,
                                  color: Colors.blue
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              ]
              ),
            ),
          ),
        ));
  }
}