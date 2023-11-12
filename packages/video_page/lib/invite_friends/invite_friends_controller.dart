import 'package:base/bases/get_base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/api/video_apis.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/models/res/base_response.dart';

class InviteFriendscontroller extends GetXBaseController {
  final qrUrlStr = "".obs;

  //全局key-截图key
  GlobalKey boundaryKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    getShareCode();
  }

  void getShareCode() async {
    try {
      BaseResponse response = await VideoApis.of.call().getShareData();
      Map map = response.data as Map;
      qrUrlStr.value =
          "${UserManagerCache.shared.config?.shareLink ?? ''}${UserManagerCache.shared.config?.shareLinkParamName}=${map["inviteCode"]}";
      print("test:${qrUrlStr}");
    } catch (e) {}
  }
}
