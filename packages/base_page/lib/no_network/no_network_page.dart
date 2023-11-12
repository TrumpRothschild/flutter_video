import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'no_network_controller.dart';
import 'package:base/commons/utils/screen.dart';

class NoNetworkPage extends GetView<NoNetworkcontroller> {
  const NoNetworkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Container(
          padding: EdgeInsets.only(top: width(189*2)),
          child: Center(
            child: Column(
              children: [
                Image(
                  image: AssetImage(
                    Assets.basePage.noNetworkDf.path,
                  ),
                  width: width(300),
                  height: width(300),
                ),
                SizedBox(height: width(30),),
                Text(
                  "哦嚯~网络好像走丢了",
                  style: TextStyle(
                    fontSize: sp(22),
                    color: Color(0xFFBDBDBD),
                  ),
                ),
                SizedBox(height: width(34*2),),
                InkWell(
                  onTap: () {
                    controller.checkInternet();
                  },
                  child: Container(
                    width: width(80*2),
                    height: width(28*2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),

                      border: Border.all(
                          color: Color(0xFFFF4E4E),
                          width: 0.5), // 边色与边宽度
                    ),
                    child: Center(
                      child: Text(
                        "点击刷新",
                        style: TextStyle(
                          color: Color(0xFFFF4E4E),
                          fontSize: sp(28),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
