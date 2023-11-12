import 'package:services/models/req/user/login_param.dart';

import '../http.dart';
import '../models/req/user/find_password_param.dart';
import 'apis.dart';

/// 用户相关api
class UserApis {
  static UserApis of() => UserApis();

  /// 获取所有地区列表
  queryAllCountry() async {
    return await HttpUtil().post(Apis.queryAllCountry);
  }

  /// 普通会员手机注册或登录
  userRegisterAndLogin(LoginParam param) async {
    return await HttpUtil()
        .post(Apis.userRegisterAndLogin, data: param);
  }

  /// 游客注册登录
  visitorLogin(LoginParam param) async {
    return await HttpUtil().post(Apis.visitorLogin, data: param);
  }

  /// 判断游客已绑定手机号，不能走游客登录
  visitorCheck() async {
    return await HttpUtil().post(Apis.visitorCheck);
  }

  /// 获取用户基本信息
  getUserInfo() async {
    return await HttpUtil().post(Apis.getUserInfo);
  }

  /// 获取用户是否存在密码状态信息
  /// reqType	1：登录密码 2：支付密码 3: 是否绑定了手机号
  getUserPasswordStatus(int reqType) async {
    return await HttpUtil()
        .get(Apis.getUserPasswordStatus, queryParameters: {'reqType': reqType});
  }

  /// 游客绑定手机号
  userBindPhone(Map<String, dynamic> params) async {
    return await HttpUtil().post(Apis.userBindPhone, data: params);
  }

  /// 设置/更新账户/支付密码
  resetPassword(Map<String, dynamic> params) async {
    return await HttpUtil().post(Apis.resetPassword, data: params);
  }

  ///普通会员找回密码/支付密码接口
  findPassword(FindPasswordParam param) async {
    return await HttpUtil().post(Apis.findPassword, data: param.toJson());
  }
  ///普通会员退出登录
  userLogout() async {
    return await HttpUtil().post(Apis.userLogout);
  }
}
