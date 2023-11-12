import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'mine_game_record_controller.dart';

class MineGameRecordPage extends GetView<MineGameRecordController> {
  MineGameRecordPage({Key? key}) : super(key: key);

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
          "游戏交易记录",
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
