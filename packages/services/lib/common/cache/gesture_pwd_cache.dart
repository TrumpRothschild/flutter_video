import 'package:base/caches/ol_cache_manager.dart';

class GesturePwdCache {
  static GesturePwdCache get instance {
    _instance ??= GesturePwdCache._();
    return _instance!;
  }

  static GesturePwdCache? _instance;

  GesturePwdCache._();

  final String _localGesPwdKey = 'storage_user_ges_pwd';

  Future<String> getCachedGesPwd() async {
    return OLCacheManager.shared.getString(_localGesPwdKey);
  }

  Future<void> updateCachedGesPwd(String nePwd) async {
    return OLCacheManager.shared.putString(_localGesPwdKey, nePwd);
  }
}
