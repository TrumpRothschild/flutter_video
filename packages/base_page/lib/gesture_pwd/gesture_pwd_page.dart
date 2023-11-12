import 'dart:math';

import 'package:base/app_routes.dart';
import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base_page/gesture_pwd/widgets/ges_select_item.dart';
import 'package:flutter/material.dart';
import 'package:gesture_password_widget/gesture_password_widget.dart';
import 'package:get/get.dart';
import 'package:services/common/cache/gesture_pwd_cache.dart';

part 'gesture_pwd_binding.dart';

part 'gesture_pwd_controller.dart';

class GesturePwdPage extends GetView<GesturePwdController> {
  const GesturePwdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 91),
            Obx(
              () => controller.isWrongPwd
                  ? _errorImgWidget()
                  : Assets.basePage.gesturePwdNor.image(
                      width: 58,
                      height: 60,
                    ),
            ),
            const SizedBox(height: 15),
            Obx(
              () => Text(
                controller.pwdTipText,
                style: TextStyle(
                  color: controller.isWrongPwd
                      ? controller.currentCustomThemeData().colors0xFF0000
                      : controller.currentCustomThemeData().colors0x000000,
                  fontSize: 16,
                ),
              ),
            ),
            const Spacer(flex: 102),
            Center(
              child: GesturePasswordWidget(
                lineColor: const Color(0x4D8960FF),
                lineWidth: 14,
                singleLineCount: 3,
                identifySize: 80.0,
                minLength: 4,
                normalItem: Container(
                  margin: const EdgeInsets.all(10),
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: controller.currentCustomThemeData().colors0xD8D8D8,
                    shape: BoxShape.circle,
                  ),
                ),
                selectedItem: const GesSelectItem(),
                color: controller.currentCustomThemeData().colors0xFFFFFF,
                onComplete: controller.onGesPwdComplete,
              ),
            ),
            const SizedBox(height: 31),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: controller.toForgetPwd,
                  child: Text(
                    '忘记密码？',
                    style: TextStyle(
                      color: controller.currentCustomThemeData().colors0xD1D1D1,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 65),
                InkWell(
                  onTap: controller.toUpdatePwd,
                  child: Text(
                    '修改密码',
                    style: TextStyle(
                      color: controller.currentCustomThemeData().colors0xD1D1D1,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(flex: 249),
          ],
        ),
      ),
    );
  }

  /// 密码错误图标
  Widget _errorImgWidget() {
    return AnimatedBuilder(
        animation: controller.shakeController,
        builder: (context, child) {
          final sineValue = sin(4 * pi * controller.shakeController.value);
          return Transform.translate(
            offset: Offset(sineValue * 10, 0),
            child: child,
          );
        },
        child: Assets.basePage.gesturePwdErr.image(
          width: 58,
          height: 60,
        ));
  }
}
