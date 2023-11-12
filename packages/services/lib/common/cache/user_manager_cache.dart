import 'dart:convert';

import 'package:base/app_config.dart';
import 'package:base/app_contant.dart';
import 'package:base/caches/ol_cache_manager.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:get/get.dart';
import 'package:services/models/res/login/login_bean.dart';
import 'package:services/models/res/public_config.dart';

import '../../models/res/user/user_detail_model.dart';

/// 登录信息的key
const loginInfoKey = "LoginInfoKey_";

/// 用户基本信息
const userDetailKey = "UserDetailKey_";

/// 用户信息管理
class UserManagerCache {
  static final shared = UserManagerCache();

  /// 配置信息
  PublicConfig? config;

  /// 客服地址 (默认一个地址)
  String onlineServiceUrl = AppConstant.keFuUrl;

  /// 登录信息
  LoginBean? info;

  /// 用户基本信息
  UserDetailModel? _userDetail;

  UserManagerCache({this.info});

  Future<void> load() async {
    final loginInfo = await OLCacheManager.shared.getData(_loginInfoKey);
    if (!GetUtils.isNull(loginInfo) && loginInfo.isNotEmpty) {
      final userInfoModel = LoginBean.fromJson(loginInfo);
      info = userInfoModel;
    }
    // 加载用户信息
    _loadUserDetail();
  }

  /// 是否已登陆
  bool isLogin() {
    return getToken().isNotEmpty;
  }

  /// 用户token
  String getToken() {
    return shared.info?.acctoken ?? "";
  }

  /// 设置用户信息
  void setLoginBean(LoginBean? loginBean) {
    info = loginBean;
  }

  /// 缓存用户信息
  void cache(Map<String, dynamic> json) {
    OLCacheManager.shared.putData(_loginInfoKey, json);
  }

  /// 从缓存充加载用户信息
  _loadUserDetail() async {
    OLCacheManager.shared.getData(_userDetailKey).then((value) {
      if (!GetUtils.isNull(value) && value.isNotEmpty) {
        _userDetail = UserDetailModel.fromJson(value);
      }
    });
  }

  /// 设置用户信息
  void setUserDetail(UserDetailModel? userDetail) {
    _userDetail = userDetail;
  }

  /// 获取用户信息
  UserDetailModel? getUserDetail() => _userDetail;

  /// 缓存用户信息
  void cacheUserDetail(Map<String, dynamic> json) {
    OLCacheManager.shared.putData(_userDetailKey, json);
  }

  /// 清除用户缓存信息
  void clearCache() {
    OLCacheManager.shared.removeFile(_loginInfoKey);
    OLCacheManager.shared.removeFile(_userDetailKey);
    info = null;
    _userDetail = null;
  }

  /// 登录信息key
  String get _loginInfoKey {
    return "$loginInfoKey${AppConfig.env.name}";
  }

  /// 用户信息key
  String get _userDetailKey {
    return "$userDetailKey${AppConfig.env.name}";
  }

  /// 获取客服链接
  String getNewOnlineUrl({
    Map<String, dynamic>? extra,
  }) {
    String accno = _userDetail!.accno ?? "";
    String kefu_id = "caihu01"; // 视频
    String tenant = AppConfig.tenantType;
    String newUrl = onlineServiceUrl
        .replaceAll("{kefu_id}", kefu_id)
        .replaceAll("{tenant}", tenant)
        .replaceAll("{visitor_id}", accno)
        .replaceAll(
          '{extra}',
          jsonEncode(
            (extra?.isNotEmpty ?? false) ? extra : {},
          ),
        );
    Log.e("newUrl:${newUrl}");
    return newUrl;
  }
}
