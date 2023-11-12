import 'dart:math';

import 'package:base/app_routes.dart';
import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:gesture_password_widget/gesture_password_widget.dart';
import 'package:get/get.dart';
import 'package:services/common/cache/gesture_pwd_cache.dart';
import 'package:services/common/cache/user_manager_cache.dart';

import '../widgets/ges_select_item.dart';

part 'update_ges_pwd_binding.dart';

part 'update_ges_pwd_controller.dart';

class UpdateGesPwdPage extends GetView<UpdateGesPwdController> {
  const UpdateGesPwdPage({Key? key}) : super(key: key);

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
        elevation: 0.5,
        title: Text(
          "设置APP应用锁",
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
          const Spacer(flex: 64),
          Obx(
            () => controller.updateGesPwdStep.isErrorTipText
                ? _errorImgWidget()
                : Assets.basePage.gesturePwdNor.image(
                    width: 58,
                    height: 60,
                  ),
          ),
          const SizedBox(height: 15),
          Obx(
            () => Text(
              controller.updateGesPwdStep.tipText,
              style: TextStyle(
                color: controller.updateGesPwdStep.isErrorTipText
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
          const Spacer(flex: 286),
        ],
      ),
    );
  }

  /// 密码错误图标
  Widget _errorImgWidget() {
    return AnimatedBuilder(
        animation: controller.shakeController,
        builder: (context, child) {
          final sineValue = sin(controller.errorCount.value *
              2 *
              pi *
              controller.shakeController.value);
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
