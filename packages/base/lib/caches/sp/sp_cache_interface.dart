abstract class SpCacheInterface {
  Future<String> saveToken(String token);

  Future<String> getToken();

  Future<bool> saveIsFirst(bool isFirst);

  Future<bool> getIsFirst();

  Future<void> clearAllData();

  ///设置上次保存版本名
  Future<String> setLastVersionName(String versionName);

  ///获取上次保存版本名
  Future<String> getLastVersionName();

  /// 缓存域名
  void setApiDomain(String env,String domain);

  /// 获取域名
  Future<String?> getApiDomain(String env);
}
