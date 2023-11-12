import 'dart:developer';

import 'package:base/app_routes.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:get/get.dart';
import 'package:services/api/mine_msg_apis.dart';
import 'package:services/api/video_apis.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/user/user_detail_model.dart';
import 'package:services/provider/user_provider.dart';

class MineFunctionItem {
  String name = "";
  String icon = "";

  MineFunctionItem({required this.name, required this.icon});
}

class MineController extends GetXBaseController {
  static MineController get to => Get.find<MineController>();

  RxString titleString = "home".obs;
  RxString downloadCount = "0".obs;

  /// 当天下载次数
  RxString limitDownloadCount = "0".obs;

  /// 限制下次次数
  RxString limitWatchCount = "0".obs;

  /// 限制观看次数
  RxString watchCount = "0".obs;

  /// 当天观看次数
  RxString viewingCount = "0".obs;

  /// 观影券

  RxBool hasUnReadMsg = false.obs;

  final functions = <MineFunctionItem>[].obs;
  var userInfo = UserDetailModel().obs;
  var isNeedRefresh = false;
  @override
  void onInit() {
    // functions.add(MineFunctionItem(name:"我的喜欢",icon:Assets.videoPage.vIcon1.path));
    // functions.add(MineFunctionItem(name: "观看记录", icon:  Assets.videoPage.vIcon3.path));
    // functions.add(MineFunctionItem(name: "个性化频道", icon:  Assets.videoPage.vIcon4.path));
    // functions.add(MineFunctionItem(name: "官方交流群",icon:  Assets.videoPage.vIcon5.path));
    // functions.add(MineFunctionItem(name: "手机认证",icon:  Assets.videoPage.vIcon6.path));
    // functions.add(MineFunctionItem(name: "建议与反馈",icon: Assets.videoPage.vIcon7.path));
    // functions.add(MineFunctionItem(name: "邀请好友", icon: Assets.videoPage.vIcon12.path));

    super.onInit();
  }

  @override
  void onReady() {
    isNeedRefresh = true;
    // 调用
    getUserInfo();
    getUnReadMsgNum();
    getInit();
    getInit2();
  }

  getUserInfo() async {
    UserProvider.getUserInfo().then((value) {
      if (value == null) {
        Log.e("用户信息为空！");
        return;
      }
      userInfo.value = value;
      update();
      UserManagerCache.shared.setUserDetail(value);
    });
  }

  void toMsg() async {
    await Get.toNamed(AppRoutes.mineMsg);
    getUnReadMsgNum();
  }

  getUnReadMsgNum() async {
    BaseResponse response = await MineMsgApis.of.getUnReadMsgNum();
    if (GetUtils.isNull(response.data) == true) {
      return;
    }
    final data = response.data as Map<String, dynamic>;
    hasUnReadMsg.value = (data['num'] as int? ?? 0) > 0;
  }

  getInit() async {
    try {
      BaseResponse response =
          await VideoApis.of.call().videoWatchRecordStatistics();
      log('火星黑洞');
      log(response.data.toString());
      downloadCount.value = response.data["downloadCount"].toString() != 'null'
          ? response.data["downloadCount"].toString()
          : '0';
      limitDownloadCount.value =
          response.data["limitDownloadCount"].toString() != 'null'
              ? response.data["limitDownloadCount"].toString()
              : '0';
      limitWatchCount.value =
          response.data["limitWatchCount"].toString() != 'null'
              ? response.data["limitWatchCount"].toString()
              : '0';
      watchCount.value = response.data["watchCount"].toString() != 'null'
          ? response.data["watchCount"].toString()
          : '0';
      update();
    } catch (e) {
      log(e.toString());
    }
  }

  getInit2() async {
    try {
      BaseResponse response =
          await VideoApis.of.call().videoWatchRecordTodayCount();
      log('火星黑洞');
      log(response.data.toString());
      viewingCount.value =
          response.data.toString() != 'null' ? response.data.toString() : '0';
      update();
    } catch (e) {
      log(e.toString());
    }
  }
}
