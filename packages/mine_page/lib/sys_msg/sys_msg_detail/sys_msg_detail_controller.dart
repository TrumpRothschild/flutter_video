import 'dart:developer';

import 'package:get/get.dart';
import 'package:base/app_routes.dart';
import 'package:base/bases/get_base_controller.dart';

class SysMsgDetailController extends GetXBaseController {
  var tab = 1.obs;

  // login(String username, String password) async {
  //   try {
  //     // OLEasyLoading.showLoading("登陆中...");
  //     OLUserInfoModel res = await Login.of
  //         .call()
  //         .userVisitorLogin("1", username, "+86", "zh_CN", password: password);
  //     log(res.accessToken ?? "");
  //     OLUserManager.shared.save(res);
  //     // OLEasyLoading.dismiss();
  //     //  进入主页
  //     Get.toNamed(AppRoutes.mainPage);
  //   } catch (e) {
  //     // Toast.show("请重试");
  //   }
  // }
}
