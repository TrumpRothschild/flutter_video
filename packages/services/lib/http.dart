import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:base/app_config.dart';
import 'package:base/app_doamin.dart';
import 'package:base/app_routes.dart';
import 'package:base/caches/ol_cache_manager.dart';
import 'package:base/commons/utils/aes_utils.dart';
import 'package:base/commons/utils/device_utils.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_keychain/flutter_keychain.dart';

import 'package:get/get.dart';
import 'package:services/common/cache/page_cache_manager.dart';

import 'common/cache/user_manager_cache.dart';
import 'models/res/base_response.dart';

class HttpUtil {
  // 单例模式
  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() => _instance;

  HttpUtil._internal() {
    init();
  }

  /// 重新设置请求路径
  setOptions() async {
    _instance._dio?.options = getBaseOptions();
  }

  Dio? _dio;

  /// 获取请求路径
  BaseOptions getBaseOptions() {
    return BaseOptions(
      // 请求基地址,可以包含子路径
      baseUrl: AppDomain.baseUrl,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 30000,

      // 响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: 5000,
      // Http请求头.
      headers: {},
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );
  }

  /// 初始化请求
  init() {
    _dio = Dio(getBaseOptions());

    /// 抓包配置
    (_dio?.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      //设置代理
      //client.findProxy = (uri) {
        // walter 代理
      //  return "PROXY 192.168.1.6:8888";
       // return "PROXY 192.168.0.100:8888";
      //};
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };

    // Cookie管理
    CookieJar cookieJar = CookieJar();
    _dio?.interceptors.add(CookieManager(cookieJar));
    _dio?.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      String timep = DateTime.now().millisecondsSinceEpoch.toString();
      String randomNum = Random().nextInt(100).toString();
      String url = options.path.split("/").last;

      /// 获取用户token
      String token = UserManagerCache.shared.getToken();
      options.headers["lang"] = "zh_CN";
      options.headers["unilive-appleType"] = "1";

      String deviceId = "";
      if (AppConfig.deviceInfo is IosDeviceInfo) {
        final userKey = AppConfig.tenantType + "userIdKey";
        // Get value
        var value = await FlutterKeychain.get(key: userKey);
        deviceId = value ?? "";

        if (deviceId.isEmpty) {
          final iosId = await Device.getDeviceId();
          deviceId = iosId ?? "";
          FlutterKeychain.put(key: userKey, value: deviceId);
        }
      } else {
        final androidId = await Device.getDeviceId();
        deviceId = androidId ?? "";
      }

      options.headers["unilive-deviceId"] = deviceId;
      options.headers["unilive-random"] = randomNum;

      var content = "$timep||$randomNum";
      if (token.isEmpty) {
        content = "$content||";
      } else {
        content = "$content||$token";
      }
      content = content + "||" + url;

      options.headers["unilive-signature"] =
          await EncryptUtil.of().aesEncryptV2(content);
      options.headers["unilive-source"] = AppConfig.deviceType;
      options.headers["unilive-timestamp"] = timep;
      options.headers["unilive-url"] = url;
      options.headers["tenant"] = AppConfig.tenantType;
      options.headers["isTest"] = AppConfig.isTest;
      if (AppConfig.deviceInfo is IosDeviceInfo) {
        var info = AppConfig.deviceInfo! as IosDeviceInfo;
        options.headers["unilive-devices"] =
            iphoneName(info.utsname.machine.toString());
        options.headers["unilive-phoneVersion"] = info.systemVersion;
        options.headers["unilive-source"] = "ios";
      } else if (AppConfig.deviceInfo is AndroidDeviceInfo) {
        var info = AppConfig.deviceInfo! as AndroidDeviceInfo;
        options.headers["unilive-devices"] = info.device;
        options.headers["unilive-phoneVersion"] =
            info.version.sdkInt.toString();
        options.headers["unilive-source"] = "android";
      }

      final appVersion = AppConfig.packageInfo?.version ?? "";
      if (appVersion.isNotEmpty) {
        options.headers["unilive-clientVersion"] = appVersion;
      }
      options.headers["unilive-netType"] = AppConfig.networkType;

      if (token != '') {
        options.headers["Authorization"] = token;
      }
      if (options.uri.toString().contains("upload")) {
        options.headers['content-type'] = "multipart/form-data";
      }
      return handler.next(options); //continue
      // 如果你想完成请求并返回一些自定义数据，你可以resolve一个Response对象 `handler.resolve(response)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
      //
      // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象,如`handler.reject(error)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    }, onResponse: (response, handler) async {
      Log.d("<<==================success============================>>");
      final requestOptions = response.requestOptions;
      var data = response.data ?? {};
      /* 接口log日志不要删除，根据需要注释即可 */
      Log.d("==>【请求接口：${requestOptions.baseUrl + requestOptions.path} 】");
      Log.d("==>【请求头：${requestOptions.headers} 】");
      Log.d("==>【body请参数：${requestOptions.data} 】");
      Log.d("==>【query请参数：${requestOptions.queryParameters} 】");
      Log.d("==>【响应数据：$data 】");

      ///生产环境响应需要解密
      if (AppConfig.isPro && data is String) {
        data = await EncryptUtil.of().aesDecrypt(data);
        data = json.decode(data);
        response.data = data;
        Log.d("==>【解密后的响应数据：$data 】");
      }

      var code = data["code"];
      if (code == 200) {
        return handler.next(response);
      } else if (code == 401) {
        // 401 未登录或者token过期
        Get.offAllNamed(AppRoutes.loginPage, arguments: 1);
      } else {
        // 如果是错误信息需要把回调给出来，特殊页面需要处理错误逻辑
        handler.reject(DioError(
            requestOptions: requestOptions,
            error: BaseResponse.fromJson(data)));

        if (code != 1005 && code != 1006) {
          // 全局统一异常提示信息，不能去掉，并且短信验证码自动弹出的时候不需要提示
          OLEasyLoading.showToast(response.data["msg"] ?? "请求失败，请稍后重试！");
        }
      }
      // 如果你想终止请求并触发一个错误,你可以 reject 一个`DioError`对象,如`handler.reject(error)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    }, onError: (DioError e, handler) {
      final requestOptions = e.requestOptions;
      Log.e("==================error============================>>");
      Log.e("==>【请求接口：${requestOptions.baseUrl + requestOptions.path} 】");
      Log.e("==>【请求头：${requestOptions.headers} 】");
      Log.e("==>【body请参数：${requestOptions.data} 】");
      Log.e("==>【query请参数：${requestOptions.queryParameters} 】");
      Log.e("==>【请求异常：${e.message} 】");
      Log.e("==>【响应数据：${e.response} 】");
      handler.reject(e);
      // OLEasyLoading.showToast(e.message);
      // return handler.reject(e); //continue
    }));
  }

  /// restful get 操作
  Future get(
    String path, {
    dynamic queryParameters,
    Options? options,
  }) async {
    var response = await _dio?.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
    return BaseResponse.fromJson(response?.data);
  }

  /// restful getUri 完整url请求
  Future<BaseResponse> getUri(
    String url, {
    dynamic queryParameters,
    Options? options,
  }) async {
    var response = await _dio?.getUri(
      Uri.parse(url),
      options: options,
    );
    return BaseResponse.fromJson(response?.data);
  }

  // needCache 是否受版本接口的影响
  // uploadImg 这里在生产环境会对 img 进行加密，会报错，暂时这种除了
  Future<BaseResponse> post(
    String path, {
    dynamic data,
    Options? options,
    bool? needCache,
    bool uploadImg = false,
  }) async {
    // 处理缓存
    final isNeed = await PageCacheManager.shared.isNeedLoadCacheData(path);
    if (!isNeed) {
      if (needCache == null || needCache) {
        final cacheData = await OLCacheManager.shared.getData(path);
        return BaseResponse.fromJson(cacheData);
        // return cacheData;
      }
    }

    /// 生产环境参数需要加密 、 生产环境搜索接口目前不加密，不需要时直接在接口处/**/
    if (AppConfig.isPro && data != null && !uploadImg) {
      data = await EncryptUtil.of().aesEncryptV2(json.encode(data));
    }

    var response = await _dio?.post(
      path,
      data: data,
      options: options,
    );

    // 返回的数据需要缓存
    final responseData = response?.data;
    PageCacheManager.shared.putCache(path, responseData);
    return BaseResponse.fromJson(responseData);
  }

  /// 表单请求
  Future<BaseResponse> postForm(
    String path, {
    dynamic data,
    Options? options,
    bool? needCache,
    bool uploadImg = false,
  }) async {
    // 处理缓存
    final isNeed = await PageCacheManager.shared.isNeedLoadCacheData(path);
    if (!isNeed) {
      if (needCache == null || needCache) {
        final cacheData = await OLCacheManager.shared.getData(path);
        return BaseResponse.fromJson(cacheData);
        // return cacheData;
      }
    }
    if (options == null) {
      options = Options(contentType: "application/x-www-form-urlencoded");
    } else {
      options =
          options.copyWith(contentType: "application/x-www-form-urlencoded");
    }
    var response = await _dio?.post(
      path,
      queryParameters: data,
      options: options,
    );
    // 返回的数据需要缓存
    final responseData = response?.data;
    PageCacheManager.shared.putCache(path, responseData);
    return BaseResponse.fromJson(responseData);
  }

  Future delete(
    String path, {
    dynamic data,
    required Options options,
  }) async {
    var response = await _dio?.delete(
      path,
      data: data,
      options: options,
    );
    return response?.data;
  }

  Future put(
    String path, {
    dynamic data,
    required Options options,
  }) async {
    var response = await _dio?.put(
      path,
      data: data,
      options: options,
    );
    return response?.data;
  }
}
