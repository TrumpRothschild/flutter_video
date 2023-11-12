import 'package:base/app_event_bus.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_normal_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:services/models/event/balance_refresh.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/game/game_transaction_list.dart';
import 'package:services/provider/common_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../game_record/game_record_provider.dart';
import 'game_web_provider.dart';

class GameWebController extends GetXBaseController
    with StateMixin<BaseResponse?> {
  String? gameType;
  int? categoryId;
  var extara = "";

  static GameWebController get to => Get.find();

  final RxDouble _posLeft = 0.0.obs;

  double get posLeft => _posLeft.value;

  set posLeft(val) => _posLeft.value = val;

  final RxDouble _posTop = 0.0.obs;

  double get posTop => _posTop.value;

  set posTop(val) => _posTop.value = val;

  final RxBool _showSubView = false.obs;

  bool get showSubView => _showSubView.value;

  set showSubView(value) => _showSubView.value = value;

  final RxInt loadingProgress = 0.obs;

  late WebViewController webViewController;

  @override
  void onInit() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    gameType = Get.arguments['gameType'] as String?;
    categoryId = Get.arguments['categoryId'] as int?;
    extara = Get.arguments["extra"] as String;

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    gameLogin();
  }

  @override
  void onClose() {
    super.onClose();
  }

  gameLogin() async {
    if (categoryId == null) {
      return;
    }

    GameWebProvider.gameLogin(gameType ?? '', categoryId ?? 0, extra: extara)
        .then(
      (value) => {
        change(value, status: RxStatus.success()),
      },
      onError: (err) => {
        change(null, status: RxStatus.error(err.toString())),
      },
    );
  }

  void onProgress(int progress) {
    if (loadingProgress.value != 100) {
      loadingProgress.value = progress;
    }
  }

  void quitGame() async {
    Get.dialog(NormalDialogWidgetAlert(
        controller: this,
        content: "是否退出游戏？",
        sureTitle: "确定",
        callBack: (type) async {
          if (1 == type) {
            // 发送通知
            CommonProvider.oneKeyRecovery().whenComplete(
                () => {eventBus.fire(BalanceEvent()), Get.back()});
          }
        }));
  }
}
