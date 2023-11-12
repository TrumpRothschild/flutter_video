import 'package:base/bases/get_base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/api/common_apis.dart';
import 'package:services/api/live_apis.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/live/live_action_list_bean.dart';

class ActivityCenterController extends GetXBaseController
    with GetTickerProviderStateMixin {
  TabController? tabController;
  List<String> tabs = ['游戏活动', '直播活动'];

  LiveActionListBean get activityBean => _activityBean.value;
  final _activityBean = LiveActionListBean().obs;

  @override
  void onInit() {
    tabController = TabController(
      vsync: this,
      length: tabs.length,
    );
    _getActivityList();
    super.onInit();
  }

  _getActivityList() async {
    BaseResponse response = await LiveApis.of().getRoomActList();
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    _activityBean.value = LiveActionListBean.fromJson(response.data);
  }

  @override
  void onClose() {
    tabController?.dispose();
    super.onClose();
  }

}
