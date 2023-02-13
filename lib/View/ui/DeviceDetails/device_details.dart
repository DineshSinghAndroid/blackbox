import 'package:flutter/material.dart';

class DeviceDetailsScreen extends StatefulWidget {
  const DeviceDetailsScreen({Key? key}) : super(key: key);

  @override
  State<DeviceDetailsScreen> createState() => _DeviceDetailsScreenState();
}

class _DeviceDetailsScreenState extends State<DeviceDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.white),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    height: 500,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            decoration: BoxDecoration(color: Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Raw Data"),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    "0x02150000000000000000000000000C48640027100000C5"),
                              ],
                            ))
                        // Container(
                        //   decoration: BoxDecoration(color: Colors.white),
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: 20, vertical: 20),
                        //   height: 120,
                        //   width: 422,
                        //   child: Row(
                        //     children: [
                        //       Column(
                        //         children: [
                        //           IconButton(
                        //               onPressed: () {}, icon: Icon(Icons.wifi)),
                        //           Text("-35 d8m")
                        //         ],
                        //       ),
                        //       SizedBox(
                        //         width: 5,
                        //       ),
                        //       Column(
                        //         children: [
                        //           IconButton(
                        //               onPressed: () {},
                        //               icon: Icon(Icons.watch)),
                        //           Text("1000 ms")
                        //         ],
                        //       ),
                        //       SizedBox(
                        //         width: 5,
                        //       ),
                        //       Column(
                        //         children: [
                        //           IconButton(
                        //               onPressed: () {},
                        //               icon: Icon(Icons.lock_clock)),
                        //           Text("IBeacon")
                        //         ],
                        //       ),
                        //       SizedBox(
                        //         width: 5,
                        //       ),
                        //       Column(
                        //         children: [
                        //           IconButton(
                        //               onPressed: () {},
                        //               icon: Icon(Icons.bluetooth)),
                        //           Text("Non-Coonected"),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
