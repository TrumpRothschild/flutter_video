import 'package:base/bases/get_base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/models/res/game/game_banner_bean.dart';
import 'package:services/models/res/game/game_bean.dart';
import 'package:services/models/res/game/game_record_list.dart';

import 'game_record_provider.dart';

class GameRecordController extends GetXBaseController
    with StateMixin<GameRecordListModel?>, GetTickerProviderStateMixin {
  static GameRecordController get to => Get.find();

  TabController? tabController;
  List<String> tabs = ['今日', '昨日'];

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: tabs.length)
      ..addListener(() {
        if (tabController!.indexIsChanging) return;
        change(GameRecordListModel(), status: RxStatus.success());
        onChangeTap(tabController!.index);
      });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getRecordData();
  }

  void onChangeTap(int index) {
    getRecordData(isToday: index == 0);
  }

  getRecordData({
    bool isToday = true,
  }) async {
    GameRecordProvider.getRecordData(isToday).then(
      (value) => {
        change(value, status: RxStatus.success()),
      },
      onError: (err) => {
        change(null, status: RxStatus.error(err.toString())),
      },
    );
  }

  @override
  void onClose() {
    tabController?.dispose();
    super.onClose();
  }
}
