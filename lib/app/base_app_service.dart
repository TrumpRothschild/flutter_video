import 'package:base/app_config.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:base/commons/utils/sp_utils.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/themes/get_theme_controller.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:services/common/cache/page_cache_manager.dart';
import 'package:services/common/cache/user_manager_cache.dart';

import 'app_init_network.dart';

/// 通用初始化操作
class BaseAppService extends GetxService {
  @override
  Future<void> onInit() async {
    super.onInit();
    // 透明沉淀式状态栏
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

    // 初始化config
    AppConfig.config();
    // 初始化log
    Log.init();
    // 初始化网络
    AppNetWork.shared.initNetWork();

    Get.put(GetThemeController());

    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    AppConfig.deviceInfo = deviceInfo;

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    AppConfig.packageInfo = packageInfo;

    await SpUtils.init();
    // 加载本地页面缓存
    await PageCacheManager.shared.loadData();
    // 加载用户信息
    await UserManagerCache.shared.load();

    OLEasyLoading.config();
    Log.d("当前环境【${AppConfig.env.name}】");
  }
}
