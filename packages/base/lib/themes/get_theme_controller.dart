import 'dart:developer';
import 'package:base/app_config.dart';
import 'package:get/get.dart';


typedef ThemeCallback = void Function();

// 直播的入口参数
class GetThemeController extends GetxController {
  final themeType = ThemeType.day.obs;
  @override
  void onInit() {
    super.onInit();
    log("onInit init");
  }

  @override
  void onReady() {
    super.onReady();
    log("onReady");
  }

  @override
  void onClose() {}

  @override
  void update([List<Object>? ids, bool condition = true]) {
    log("GetThemeController isChange");
  }
}
