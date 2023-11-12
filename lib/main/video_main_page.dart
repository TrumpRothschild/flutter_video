import 'package:base/datas/base_data_opear.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uni_client/main/base_main_page.dart';
import 'package:flutter_uni_client/main/video_main_controller.dart';
import 'package:get/get.dart';
import 'package:video_page/mine/mine_controller.dart';

/// 视频主页面
class VideoMainPage extends BaseMainPage<VideoMainController> {
  const VideoMainPage({Key? key}) : super(key: key);

  @override
  void onBottomTap(int index) {
    super.onBottomTap(index);
    /// 我的页面
    if (index == 3 && controller.selectIndex.value != 3) {
      final myCtrol = Get.find<MineController>();
      if (myCtrol.isNeedRefresh) {
        myCtrol.onReady();
      }
    }

    ///充值页面
    if (2 == index) {
      BaseDataOpear.type_charge = false;
    }
    controller.pageController.jumpToPage(index);
    controller.selectIndex.value = index;
  }
}
