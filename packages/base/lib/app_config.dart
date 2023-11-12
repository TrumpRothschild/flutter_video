import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info/package_info.dart';

String iphoneName(String machine) {
  //iPhone 系列
  if (machine == "iPhone1,1") return "iPhone 1G";
  if (machine == "iPhone1,2") return "iPhone 3G";
  if (machine == "iPhone2,1") return "iPhone 3GS";
  if (machine == "iPhone3,1") return "iPhone 4";
  if (machine == "iPhone3,2") return "Verizon iPhone 4";
  if (machine == "iPhone4,1") return "iPhone 4S";
  if (machine == "iPhone5,1") return "iPhone 5";
  if (machine == "iPhone5,2") return "iPhone 5";
  if (machine == "iPhone5,3") return "iPhone 5C";
  if (machine == "iPhone5,4") return "iPhone 5C";
  if (machine == "iPhone6,1") return "iPhone 5S";
  if (machine == "iPhone6,2") return "iPhone 5S";
  if (machine == "iPhone7,1") return "iPhone 6 Plus";
  if (machine == "iPhone7,2") return "iPhone 6";
  if (machine == "iPhone8,1") return "iPhone 6s";
  if (machine == "iPhone8,2") return "iPhone 6s Plus";
  if (machine == "iPhone9,1") return "iPhone 7 (CDMA)";
  if (machine == "iPhone9,3") return "iPhone 7 (GSM)";
  if (machine == "iPhone9,2") return "iPhone 7 Plus (CDMA)";
  if (machine == "iPhone9,4") return "iPhone 7 Plus (GSM)";

  if (machine == "iPhone10,1") return "iPhone 8";
  if (machine == "iPhone10,4") return "iPhone 8";
  if (machine == "iPhone10,2") return "Phone 8 Plus";
  if (machine == "iPhone10,5") return "iPhone 8 Plus";

  if (machine == "iPhone10,3") return "iPhone X";
  if (machine == "Phone10,6") return "iPhone X";

  if (machine == "iPhone11,8") return "iPhone XR";
  if (machine == "iPhone11,2") return "iPhone XS";

  if (machine == "iPhone11,6") return "iPhone XS Max";
  if (machine == "iPhone12,1") return "iPhone 11";
  if (machine == "iPhone12,3") return "iPhone 11 Pro";

  if (machine == "iPhone12,5") return "iPhone 11 Pro Max";
  if (machine == "iPhone12,8") return "iPhone12,8";

  if (machine == "iPhone13,1") return "iPhone 12 mini";

  if (machine == "iPhone13,2") return "iPhone 12";

  if (machine == "iPhone13,3") return "iPhone 12 Pro";
  if (machine == "iPhone13,4") return "iPhone 12 Pro Max";

  if (machine == "iPhone14,4") return "iPhone 13 mini";
  if (machine == "iPhone14,5") return "iPhone 13";

  if (machine == "iPhone14,2") return "iPhone 13 Pro";
  if (machine == "iPhone14,3") return "iPhone 13 Pro Max";

  if (machine == "iPhone14,7") return "iPhone 14";
  if (machine == "iPhone14,8") return "iPhone 14 Plus";
  if (machine == "iPhone15,2") return "iPhone 14 Pro";
  if (machine == "iPhone15,3") return "iPhone 14 Pro Max";

  //iPod 系列
  if (machine == "iPod1,1") return "iPod Touch 1G";
  if (machine == "iPod2,1") return "iPod Touch 2G";
  if (machine == "iPod3,1") return "iPod Touch 3G";
  if (machine == "iPod4,1") return "iPod Touch 4G";
  if (machine == "iPod5,1") return "iPod Touch 5G";

  //iPad 系列
  if (machine == "iPad1,1") return "iPad";
  if (machine == "iPad2,1") return "iPad 2 (WiFi)";
  if (machine == "iPad2,2") return "iPad 2 (GSM)";
  if (machine == "iPad2,3") return "iPad 2 (CDMA)";
  if (machine == "iPad2,4") return "iPad 2 (32nm)";
  if (machine == "iPad2,5") return "iPad mini (WiFi)";
  if (machine == "iPad2,6") return "iPad mini (GSM)";
  if (machine == "iPad2,7") return "iPad mini (CDMA)";

  if (machine == "iPad3,1") return "iPad 3(WiFi)";
  if (machine == "iPad3,2") return "iPad 3(CDMA)";
  if (machine == "iPad3,3") return "iPad 3(4G)";
  if (machine == "iPad3,4") return "iPad 4 (WiFi)";
  if (machine == "iPad3,5") return "iPad 4 (4G)";
  if (machine == "iPad3,6") return "iPad 4 (CDMA)";

  if (machine == "iPad4,1") return "iPad Air";
  if (machine == "iPad4,2") return "iPad Air";
  if (machine == "iPad4,3") return "iPad Air";
  if (machine == "iPad5,3") return "iPad Air 2";
  if (machine == "iPad5,4") return "iPad Air 2";
  if (machine == "i386") return "Simulator";
  if (machine == "x86_64") return "Simulator";

  if (machine == "iPad4,4" || machine == "iPad4,5" || machine == "iPad4,6") {
    return "iPad mini 2";
  }

  if (machine == "iPad4,7" || machine == "iPad4,8" || machine == "iPad4,9") {
    return "iPad mini 3";
  }
  if (machine == "iPad6,3" || machine == "iPad6,4") {
    return "iPad PRO";
  }
  return machine;
}

/// 环境类型
enum EnvType {
  pro,
  dev,
  uat,
  pre,
}

/// live 直播 video 视频
enum EnvApp { live, video }

/// 租户类型 bball 直播 cfox 视频
enum TenantType { bball, cfox }

enum ThemeType {
  dark,
  day,
}

// 存放应用需要配置的地方 公共配置
class AppConfig {
  static void config() {
    try {
      /// 是否是debug模式
      debug = const bool.fromEnvironment("PACKAGE_DEBUG", defaultValue: false);

      /// 环境
      String envValue = const String.fromEnvironment("PACKAGE_ENV");
      //根据启动命令的参数选择环境
      AppConfig.env = EnvType.values.byName(envValue);
    } catch (e) {
      //参数有误情况下 默认环境
      AppConfig.env = EnvType.uat;
    } finally {
      _initLiveAppId();
    }
  }

  /// 设置app类型
  static void setAppType(EnvApp appType) {
    app = appType;
    if (appType == EnvApp.video) {
      AppConfig.tenantType = TenantType.cfox.name;
    } else {
      AppConfig.tenantType = TenantType.bball.name;
    }
  }

  static EnvApp app = EnvApp.live;
  static BaseDeviceInfo? deviceInfo;
  static PackageInfo? packageInfo;
  static EnvType env = EnvType.dev;

  /// 租户类型,直播 bball，视频 cfox
  static String tenantType = TenantType.bball.name;

  ///当前版本号和版本名称，由于ios打tf包只能用1.0版本，所以升级判断要用自己的配置文件
  static int andVersionCode = 100;
  static String andVersionName = '100';
  static int iosVersionCode = 100;
  static String iosVersionName = '100';

  /// 是否是debug模式
  static bool debug = false;

  static String deviceType = Platform.isIOS ? 'ios' : 'android';

  /// 响应 1 不加密 0 加密
  static String isTest = isPro ? '0' : '1';

  /// 声网appId
  static String appId = "";

  /// 初始化声网appId
  static void _initLiveAppId() {
    switch (env) {
      case EnvType.pro:
        appId = "22f4eb5c247a462d9df410743125f0db";
        break;
      case EnvType.pre:
        appId = "246f2c236bf7457bac630b3fa2aeb8a4";
        break;
      case EnvType.dev:
        appId = "c30b10fa91e949b0b47800dd87def391";
        break;
      case EnvType.uat:
        appId = "1dd9c1416e754ea9b7651d47eac10590";
        break;
      default:
        appId = "22f4eb5c247a462d9df410743125f0db";
        break;
    }
  }

  static String networkType = "wifi";

  static bool isConnectNet = true; // 默认网络已经连接
  static int releaseCount = 0; // 网路连接计数

  /// 是否是视频
  static bool get isVideo => app == EnvApp.video;

  /// 是否生产环境
  static bool get isPro => env == EnvType.pro;
//static bool get isPro => true;
}
