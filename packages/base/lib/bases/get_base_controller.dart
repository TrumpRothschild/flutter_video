import 'dart:developer';
import 'dart:io';
import 'package:base/app_config.dart';
import 'package:base/app_routes.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:base/translations/app_translations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../themes/get_theme_controller.dart';
import 'package:base/themes/app_theme.dart';

// 基础GetX状态控制器 主要处理一些公共的状态控制
// 比如 主题， 网络， 全局应用状态
abstract class GetXBaseController extends GetxController {

  VoidCallback? themeCallback;

  // 主题控制
  final GetThemeController themeController = Get.find<GetThemeController>();
  var isLogin = false.obs;

  @override
  void onInit() {
    super.onInit();
    log("onInit init");
    checkInternet();
  }

  @override
  void onReady() {
    super.onReady();
    log("onReady");
  }

  @override
  void onClose() {}

  // 主题相关
  ThemeType get currentThemeType => themeController.themeType.value;
  set currentThemeType(ThemeType type) {
    if (themeCallback != null) {
      themeCallback!();
    }
    themeController.themeType.value = type;
  }

  /// 获取自定义的主题
  CustomTheme currentCustomThemeData() {
    return AppTheme.currentCustomData(this);
  }

  ThemeData currentThemeData() {
    return AppTheme.currentThemeData(this);
  }

  /// 获取本地化字符串方法
  ///
  /// 基础页面
  String basePageString(String key) {
    return AppTranslation.basePageString(key) ?? key;
  }

  /// 首页
  String homePageString(String key) {
    return AppTranslation.homePageString(key) ?? key;
  }

  /// 游戏
  String gamePageString(String key) {
    return AppTranslation.gamePageString(key) ?? key;
  }

  /// 支付
  String walletPageString(String key) {
    return AppTranslation.walletPageString(key) ?? key;
  }

  /// 我的
  String minePageString(String key) {
    return AppTranslation.minePageString(key) ?? key;
  }

  /// 视频
  String videoPageString(String key) {
    return AppTranslation.videoPageString(key) ?? key;
  }

  /// 监测当前页面是否有网络连接
  void checkInternet() async {
    try {
      String host = "baidu.com"; //判断国内外，谷歌还是百度
      final result = await InternetAddress.lookup(host);
      Log.d("result-- $result");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        AppConfig.isConnectNet = true;
      }
    } on SocketException catch (_) {
      AppConfig.isConnectNet = false;
    } finally {
      if (AppConfig.isConnectNet == true) {
        if (Get.currentRoute == AppRoutes.noNetworks) {
          AppConfig.releaseCount -= 1;
          Log.d("releaseCount:${AppConfig.releaseCount}");
          if (AppConfig.releaseCount == 0) {
            Get.back();
          }
        }
      } else {
        if (Get.currentRoute != AppRoutes.noNetworks) {
          AppConfig.releaseCount += 1;
          Log.d("releaseCount:${AppConfig.releaseCount}");
          if (AppConfig.releaseCount == 1) {
            Get.toNamed(AppRoutes.noNetworks);
          }
        }
      }
    }
  }
}
