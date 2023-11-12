// import 'package:device_info_plus/device_info_plus.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardItemController extends GetXBaseController {
  RxString titleString = "只能出现最多八个字".obs;
  RxBool moreFlag = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    // 调用
  }

  String formatDuration(int seconds) {
    int hour = seconds ~/ 3600;
    int minute = (seconds % 3600) ~/ 60;
    int second = seconds % 60;

    String hourStr = (hour < 10) ? '0$hour' : '$hour';
    String minuteStr = (minute < 10) ? '0$minute' : '$minute';
    String secondStr = (second < 10) ? '0$second' : '$second';

    if (hour == 0) {
      return '00:$minuteStr:$secondStr';
    } else {
      return '$hourStr:$minuteStr:$secondStr';
    }
  }

  showMore() {
    moreFlag.value = true;
  }

}
