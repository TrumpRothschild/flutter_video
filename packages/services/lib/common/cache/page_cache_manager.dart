import 'package:base/caches/ol_cache_manager.dart';
import 'package:services/api/apis.dart';
import 'page_cache_data.dart';

class PageCacheManager {
  // 用于存储到本地的cacheKey
  static const pageCacheKey = "OLCacheListKey";
  // 记录缓存的版本
  static const keyVersion = "version";
  static final shared = PageCacheManager();
  static final cacheData = PageCacheList();

  Future<void>  loadData() async {
    final data = await cacheVersions;
    currentCacheVersion = data;
  }

  Map<String, dynamic> currentCacheVersion = {};

  storeCacheVersion(Map<String, dynamic> data) {
    String key = "${Apis.verApi}$pageCacheKey";
    OLCacheManager.shared.putData(key, data);
    currentCacheVersion = data;
  }

  Future<Map<String, dynamic>> get cacheVersions async {
    String key = "${Apis.verApi}$pageCacheKey";
    final data = await OLCacheManager.shared.getData(key);
    return data;
  }

  // 根据key获取到当前的版本号
  String getVersion(String groupKey) {
    for (final key in currentCacheVersion.keys) {
      if (groupKey == key) {
        return currentCacheVersion[key].toString();
      }
    }
    return "";
  }

  // 判断是否需要缓存
  Future<bool> isNeedLoadCacheData(String key) async {
    String tmpKeyVersion = "$key/$keyVersion";
    final version = await OLCacheManager.shared.getString(tmpKeyVersion);
    final lastKey = cacheData.getKey(key).toString();
    final lastVersion = getVersion(lastKey).toString();

    bool isNeed = false;
    if (version.toString() != lastVersion.toString()) {
      isNeed = true;
    }

    if (version.toString() == "" || lastVersion.toString() == "") {
      isNeed = true;
    }
    return isNeed;
  }

  Future<void> putCache(String path, Map<String, dynamic> data) async {
    final lastKey = cacheData.getKey(path);
    final lastVersion = getVersion(lastKey);
    String key = "$path/$keyVersion";
    OLCacheManager.shared.putData(path, data);
    OLCacheManager.shared.putString(key, lastVersion.toString());
  }
}
