import 'package:base/datas/base_data_opear.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uni_client/main/live_main_controller.dart';
import 'package:get/get.dart';
import 'package:mine_page/mine_root/mine_root_controller.dart';

import 'base_main_page.dart';

/// 直播主页面
class LiveMainPage extends BaseMainPage<LiveMainController> {
  const LiveMainPage({Key? key}) : super(key: key);

  @override
  void onBottomTap(int index) {
    super.onBottomTap(index);
    if (2 == index) {
      BaseDataOpear.type_charge = false;
    }

    /// 我的页面
    if (index == 3 && controller.selectIndex.value != 3) {
      final myCtrol = Get.find<MineRootPageController>();
      if (myCtrol.isNeedRefresh) {
        myCtrol.onReady();
      }
    }
    controller.selectIndex.value = index;
    controller.pageController.jumpToPage(index);
  }
}
