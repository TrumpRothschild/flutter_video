import 'package:base/caches/sp/sp_cache_impl.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// APP版本工具类
class AppVersionUtil {


  /// 是否升级，1为非强制更新，2为强制更新，其它为不升级
  static Future<int> isUpdate(String? versionName, {bool isClick = false}) async {
    int result = 0;
    var last = await SpCacheImpl.of().getLastVersionName();
    if (null != versionName && (isClick || versionName != last)) {
      var version1 = versionName.split(".");
      if (version1.isNotEmpty && version1.length == 3) {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        var version2 = packageInfo.version.split(".");
        if (version2.isNotEmpty && version2.length == 3) {
          if (int.parse(version1[0]) > int.parse(version2[0]) ||
              int.parse(version1[1]) > int.parse(version2[1])) {
            result = 2; //强制升级
          } else if (int.parse(version1[2]) > int.parse(version2[2])) {
            result = 1; // 非强制更新
          }
        }
      }
    }

    return result;
  }
}
