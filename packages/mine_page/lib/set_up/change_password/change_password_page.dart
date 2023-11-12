import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'change_password_controller.dart';

/// 修改密码
class ChangePasswordPage extends GetView<ChangePasswordController> {
  ChangePasswordPage({Key? key}) : super(key: key);

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
        centerTitle: true,
        title: Text(
          controller.pageType.pageTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: controller.currentCustomThemeData().colors0x000000,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 5,
            color: controller.currentCustomThemeData().colors0xF7F7F7,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: controller.currentCustomThemeData().colors0xEEEEEE,
                ),
              ),
            ),
            child: Row(
              children: [
                Assets.basePage.pwdBlack.image(
                  width: 12,
                  height: 14,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: TextField(
                    controller: controller.textEditingController1,
                    obscureText: true,
                    obscuringCharacter: '*',
                    style: TextStyle(
                      color: controller.currentCustomThemeData().colors0x000000,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: controller.hintText1,
                      hintStyle: TextStyle(
                        color:
                            controller.currentCustomThemeData().colors0xD6D6D6,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                InkWell(
                  onTap: controller.clearTextField1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Assets.basePage.xx.image(
                      width: 15,
                      height: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: controller.currentCustomThemeData().colors0xEEEEEE,
                ),
              ),
            ),
            child: Row(
              children: [
                Assets.basePage.pwdOs.image(
                  width: 12,
                  height: 14,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: TextField(
                    controller: controller.textEditingController2,
                    style: TextStyle(
                      color: controller.currentCustomThemeData().colors0x000000,
                      fontSize: 14,
                    ),
                    obscureText: true,
                    obscuringCharacter: '*',
                    decoration: InputDecoration(
                      hintText: controller.hintText2,
                      hintStyle: TextStyle(
                        color:
                            controller.currentCustomThemeData().colors0xD6D6D6,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                InkWell(
                  onTap: controller.clearTextField2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Assets.basePage.xx.image(
                      width: 15,
                      height: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (controller.showForgetPwd) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Spacer(),
                InkWell(
                  onTap: controller.toForgetPwd,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      '忘记密码？',
                      style: TextStyle(
                        color:
                            controller.currentCustomThemeData().colors0xD1D1D1,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
          const Spacer(flex: 161),
          ElevatedButton(
            onPressed: controller.onConfirm,
            style: ElevatedButton.styleFrom(
              primary: controller.currentCustomThemeData().colors0x9F44FF,
              padding: const EdgeInsets.symmetric(
                vertical: 6.5,
                horizontal: 81,
              ),
            ),
            child: Text(
              '确 认',
              style: TextStyle(
                color: controller.currentCustomThemeData().colors0xFFFFFF,
                fontSize: 16,
              ),
            ),
          ),
          const Spacer(flex: 406),
        ],
      ),
    );
  }
}
