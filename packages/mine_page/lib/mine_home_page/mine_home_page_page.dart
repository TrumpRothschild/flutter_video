import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'mine_home_page_controller.dart';

class MineHomePage extends GetView<MineHomeController> {
  MineHomePage({Key? key}) : super(key: key);

  final TextEditingController zhanghao = TextEditingController();
  final TextEditingController mima = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Get.back();
          },
          icon: Image.asset(
            Assets.basePage.backBlack.path,
             width: 10,
            height: 20,
          ),
        ),
        title: Text(
          "个人主页",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: controller.currentCustomThemeData().colors0x000000,
          ),
        ),
      ),
      body: Text("1212"),
    );
  }
}