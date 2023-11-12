import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'nick_name_controller.dart';

class NickNamePage extends GetView<NickNameController> {
  NickNamePage({Key? key}) : super(key: key);

  final TextEditingController zhanghao = TextEditingController();
  final TextEditingController mima = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: controller.currentCustomThemeData().colors0x000000),
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          "编辑昵称",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: controller.currentCustomThemeData().colors0x000000,
          ),
        ),
        centerTitle: true,
        actions: [
          UnconstrainedBox(
            child: InkWell(
              onTap: controller.onSave,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    '保存',
                    style: TextStyle(
                      color: controller.currentCustomThemeData().colors0x000000,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 18).copyWith(top: 18),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: controller.currentCustomThemeData().colors0x000000_20!,
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.editingController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(8),
                    ],
                    decoration: const InputDecoration(
                      counterText: '',
                      hintText: '昵称',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      isCollapsed: true,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                InkWell(
                  onTap: controller.editingController.clear,
                  child: Icon(
                    Icons.cancel,
                    color: controller.currentCustomThemeData().colors0xC2C2C2,
                    size: 25,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '(长度限制8个中文)',
                  style: TextStyle(
                    color: controller.currentCustomThemeData().colors0x989898,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '可免费改名1次',
                  style: TextStyle(
                    color: controller.currentCustomThemeData().colors0xAAAAAA,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
