import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:services/api/user_apis.dart';

import '../common/cache/user_manager_cache.dart';
import '../models/req/user/find_password_param.dart';
import '../models/req/user/login_param.dart';
import '../models/res/base_response.dart';
import '../models/res/login/country_code_bean.dart';
import '../models/res/login/login_bean.dart';
import '../models/res/user/user_detail_model.dart';

/// 用户相关provider
class UserProvider {
  /// 获取所有地区列表
  static Future<List<CountryCodeBean>?> queryAllCountry() async {
    BaseResponse response = await UserApis.of().queryAllCountry();
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return (response.data as List<dynamic>)
        .map((e) => CountryCodeBean.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// 普通会员手机注册或登录
  static Future<LoginBean?> userRegisterAndLogin(LoginParam param) async {
    BaseResponse response = await UserApis.of().userRegisterAndLogin(param);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    var data = response.data;

    ///缓存用户登录信息
    UserManagerCache.shared.cache(data);

    /// 获取用户基本信息
    getUserInfo()
        .then((value) => {UserManagerCache.shared.setUserDetail(value)});

    return LoginBean.fromJson(data);
  }

  /// 游客注册登录
  static Future<LoginBean?> visitorLogin(LoginParam param) async {
    BaseResponse response = await UserApis.of().visitorLogin(param);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    var data = response.data;

    ///缓存用户登录信息
    UserManagerCache.shared.cache(data);

    /// 获取用户基本信息
    getUserInfo()
        .then((value) => {UserManagerCache.shared.setUserDetail(value)});
    return LoginBean.fromJson(data);
  }

  /// 判断游客已绑定手机号，不能走游客登录
  static Future<bool?> visitorCheck() async {
    BaseResponse response = await UserApis.of().visitorCheck();
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return response.data;
  }

  /// 获取用户基本信息
  static Future<UserDetailModel?> getUserInfo() async {
    BaseResponse response = await UserApis.of().getUserInfo();
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    var data = response.data;

    ///缓存用户基本信息
    UserManagerCache.shared.cacheUserDetail(data);
    return UserDetailModel.fromJson(data);
  }

  /// 获取用户是否存在密码状态信息,接口比较反着来，false 存在 true 不存在
  static Future<bool?> getUserPasswordStatus(int reqType) async {
    BaseResponse response = await UserApis.of().getUserPasswordStatus(reqType);
    if (GetUtils.isNull(response) == true) {
      return true;
    }
    return response.data;
  }

  /// 游客绑定手机号
  static Future<bool?> userBindPhone(Map<String, dynamic> params) async {
    BaseResponse response = await UserApis.of().userBindPhone(params);
    if (GetUtils.isNull(response) == true) {
      return false;
    }
    return response.data;
  }

  /// 设置/更新账户/支付密码
  static Future<String?> resetPassword(Map<String, dynamic> params) async {
    BaseResponse response = await UserApis.of().resetPassword(params);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return response.data;
  }

  ///普通会员找回密码/支付密码接口
  static Future<String?> findPassword(FindPasswordParam param) async {
    BaseResponse response = await UserApis.of().findPassword(param);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return response.data;
  }

  ///普通会员找回密码/支付密码接口
  static Future<String?> userLogout() async {
    BaseResponse response = await UserApis.of().userLogout();
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return response.data;
  }
}
