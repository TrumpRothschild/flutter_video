import 'package:base/app_config.dart';
import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/extension.dart';
import 'package:base/res/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_page/activity_center/list/game_list_page.dart';
import 'package:mine_page/activity_center/list/live_list_page.dart';

import 'activity_center_controller.dart';

class ActivityCenterPage extends GetView<ActivityCenterController> {
  ActivityCenterPage({Key? key}) : super(key: key);

  final TextEditingController zhanghao = TextEditingController();
  final TextEditingController mima = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: controller.currentCustomThemeData().colors0x8019FE,
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: controller.currentCustomThemeData().colors0x000000),
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Get.back();
          },
          icon: Assets.basePage.backBlack.image(
            width: AppDimens.w_8,
            height: AppDimens.h_15,
            fit: BoxFit.fill,
          ),
        ),
        centerTitle: true,
        title: Text(
          "活动中心",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: controller.currentCustomThemeData().colors0x000000,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (AppConfig.app != EnvApp.video)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                      color:
                          controller.currentCustomThemeData().colors0xD9D9D9),
                ),
              ),
              child: Material(
                // 这里设置tab的背景色：透明不生效
                // color: Colors.transparent,
                color: controller.currentCustomThemeData().colors0x8019FE,
                child: TabBar(
                  indicatorColor:
                      controller.currentCustomThemeData().colors0xFFFFFF,
                  labelColor:
                      controller.currentCustomThemeData().colors0xFFFFFF,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  labelPadding: EdgeInsets.zero,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 15),
                  unselectedLabelColor:
                      controller.currentCustomThemeData().colors0xFFFFFF_50,
                  isScrollable: false,
                  tabs: controller.tabs.mapIndexed(
                    (item, index) {
                      return Tab(
                        child: Text(controller.tabs[index]),
                      );
                    },
                  ).toList(),
                  controller: controller.tabController, // 记得要带上tabController
                ),
              ),
            ),
          Expanded(
            child: Obx(
              () => TabBarView(
                controller: controller.tabController,
                children: [
                  GameListPage(
                    customTheme: controller.currentCustomThemeData(),
                    list: controller.activityBean.gameList ?? [],
                  ),
                  LiveListPage(
                    customTheme: controller.currentCustomThemeData(),
                    list: controller.activityBean.liveList ?? [],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
