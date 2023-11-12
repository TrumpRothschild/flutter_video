import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import 'sign_controller.dart';

class SignPage extends GetView<SignController> {
  SignPage({Key? key}) : super(key: key);

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
          "修改个性签名",
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
      body: Container(
        color: controller.currentCustomThemeData().colors0xF3F3F3,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        padding: const EdgeInsets.only(left: 14, top: 12, bottom: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: controller.editingController,
              maxLength: 40,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                hintText: '请输入签名，上限40字符',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                isCollapsed: true,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                counterText: '',
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: controller.editingController.clear,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  Icons.close,
                  color: controller.currentCustomThemeData().colors0xA9A9A9,
                  size: 26,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Obx(
                () => Text(
                  '${controller.length}/40',
                  style: TextStyle(
                    color: controller.currentCustomThemeData().colors0x979797,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
