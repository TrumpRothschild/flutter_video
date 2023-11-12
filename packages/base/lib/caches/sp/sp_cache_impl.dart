import 'package:base/caches/sp/sp_cache_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kSurToken = 'SUR_TOKEN';
const kSurUser = 'SUR_USER';
const kIsFirst = 'ISFIRST';
const kLastVersionName = 'LASTVERSIONNAME';

/// 缓存api的key
const kApiDomain = 'cache_api_domain_';

class SpCacheImpl extends SpCacheInterface {
  static SpCacheImpl of() => SpCacheImpl();

  @override
  Future<void> clearAllData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  @override
  Future<String> saveToken(String token) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(kSurToken, token);
    return token;
  }

  @override
  Future<String> getToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = sp.getString(kSurToken).toString();
    return token;
  }

  @override
  Future<bool> getIsFirst() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isFirst = sp.getBool(kIsFirst) ?? false;
    return Future.value(isFirst);
  }

  @override
  Future<bool> saveIsFirst(bool isFirst) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool(kIsFirst, isFirst);
    return Future.value(isFirst);
  }

  /// 获取上次保存版本名
  @override
  Future<String> getLastVersionName() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String versionName = sp.getString(kLastVersionName).toString();
    return versionName;
  }

  /// 设置上次保存版本名
  @override
  Future<String> setLastVersionName(String versionName) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(kLastVersionName, versionName);
    return Future.value(versionName);
  }

  @override
  void setApiDomain(String env, String domain) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String key="$kApiDomain$env";
    sp.setString(key, domain);
  }

  @override
  Future<String?> getApiDomain(String env) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String key="$kApiDomain$env";
    return sp.getString(key);
  }
}
