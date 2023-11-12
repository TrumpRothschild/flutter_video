import 'package:dio/dio.dart';

import 'app_config.dart';
import 'caches/sp/sp_cache_impl.dart';
import 'commons/utils/log_utils.dart';

/// app域名管理
class AppDomain {
  ///找回域名保存的路径, 配置两个起到双保险的作用
  static var domainImgUrls = <String>[
    "https://bball-1.s3.ap-northeast-1.amazonaws.com",
    "https://apollo11.oss-cn-hongkong.aliyuncs.com"
  ];

  static const String _checkUrlPing = "/api/ping";

  /// pro环境默认域名
  static const String defProLive = "https://api.shopkarterj.com";
  static const String defProVideo = "http://api.aednlju8nt.top";

  /// pre环境默认域名
  static const String defPreLive = "https://api.pre.radiotimucin.com";

  /// uat环境默认域名
  static const String defUatLive = "http://api.uat.91momo50.vip";

  /// dev环境默认域名
  static const String defDevLive = "https://api.91momo50.vip";

  /// 当前可用域名
  static String baseUrl = "";

  /// 获取默认域名
  static String get _defDomain {
    switch (AppConfig.env) {
      case EnvType.pro:
        String defDomain = AppConfig.isVideo ? defProVideo : defProLive;
        return defDomain;
      case EnvType.pre:
        return defPreLive;
      case EnvType.dev:
        return defDevLive;
      case EnvType.uat:
      default:
        return defUatLive;
    }
  }

  /// 检测可用域名
  static Future<bool> checkDomain() async {
    // 先检测当前缓存中的域名是否可用
    String curUrl = await _getCurDomain();
    bool available = await _isAvailable(curUrl);
    if (available) {
      Log.d("当前可用地址：【$curUrl】");
      return true;
    }
    var tenant = AppConfig.tenantType;
    var env = AppConfig.env.name;
    bool tmp = false;
    for (var value in domainImgUrls) {
      var url = "$value/$tenant/a.$env.jpg";
      Log.d("检测可用地址：【$url】");
      tmp = await _getAvailableUrl(env, url);
      if (tmp) {
        break;
      }
    }
    return tmp;
  }

  /// 获取当前域名
  static Future<String> _getCurDomain() async {
    var env = AppConfig.env.name;
    //如果内存有域名 直接从内存返回, 速度是最快的
    if (baseUrl.isEmpty) {
      //如果内存的值还没有初始化, 从 LocalStorage 获取并设回内存, 下次从内存获取
      String? cacheDomain = await SpCacheImpl.of().getApiDomain(env);
      if (cacheDomain != null && cacheDomain.isNotEmpty) {
        baseUrl = cacheDomain;
      } else {
        //设置默认域名，并缓存
        _cacheCurDomain(env, _defDomain);
      }
    }
    return baseUrl;
  }

  /// 缓存并设置当前域名
  static void _cacheCurDomain(String env, String domain) {
    //设置默认域名，并缓存
    baseUrl = domain;
    SpCacheImpl.of().setApiDomain(env, domain);
  }

  /// 获取可用url
  static Future<bool> _getAvailableUrl(String env, String path) async {
    try {
      var result = await Dio().get(path);
      String urls = result.data;
      List<String> items = urls.split("\r\n");
      if (items.isEmpty) {
        return false;
      }
      bool tmp = false;
      for (String item in items) {
        // 循环请求路径
        tmp = await _isAvailable(item); // 获取有用的地址
        if (tmp) {
          Log.d("当前可用地址：【$item】");
          _cacheCurDomain(env, item);
          break;
        }
      }
      return tmp;
    } catch (e) {
      Log.e("获取域名地址不可用：【${e.toString()}】");
      return false;
    }
  }

  /// 检测url是否可用
  static Future<bool> _isAvailable(String url) async {
    try {
      /// 需要这样处理 默认是要解析成json
      await Dio().getUri(Uri.parse(url + _checkUrlPing),
          options: Options(responseType: ResponseType.plain));
      return true;
    } catch (e) {
      Log.e("不可用域名：【$url】");
      Log.e("不可用域名：【${e.toString()}】");
      return false;
    }
  }
}
