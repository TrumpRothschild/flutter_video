import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_page/my_grade/widgets/level_up_container.dart';

import 'my_grade_controller.dart';
import 'widgets/level_progress.dart';
import 'widgets/user_cur_level.dart';

class MyGradePage extends GetView<MyGradeController> {
  MyGradePage({Key? key}) : super(key: key);

  final TextEditingController zhanghao = TextEditingController();
  final TextEditingController mima = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: controller.currentCustomThemeData().colors0x8019FE,
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
          "我的等级",
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
          AspectRatio(
            aspectRatio: 375 / 230,
            child: Assets.minePage.myLevelLogo.image(
              fit: BoxFit.cover,
            ),
          ),
          Obx(
            () => controller.userLevelBean.levelWeight != -1
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        UserCurLevel(
                          customTheme: controller.currentCustomThemeData(),
                          userLevelBean: controller.userLevelBean,
                        ),
                        const SizedBox(height: 24),
                        LevelProgress(
                          customTheme: controller.currentCustomThemeData(),
                          userLevelBean: controller.userLevelBean,
                        ),
                        if (!controller.userLevelBean.isFullLevel) ...[
                          const SizedBox(height: 37),
                          LevelUpContained(
                            customTheme: controller.currentCustomThemeData(),
                          ),
                        ],
                      ],
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
