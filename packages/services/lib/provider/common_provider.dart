import 'package:base/bases/get_base_connect.dart';
import 'package:get/get.dart';
import 'package:services/api/common_apis.dart';
import 'package:services/models/res/banner/banner_bean.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/live/agora_token_bean.dart';
import 'package:services/models/res/notice/notice_bean.dart';
import 'package:services/models/res/version/app_version_update.dart';
import 'package:services/models/res/wallet/user_wallet_model.dart';

import '../models/req/user/send_sms_param.dart';
import '../models/res/app_version_baen.dart';
import '../models/res/login/image_code_model.dart';
import '../models/res/login/online_service_model.dart';
import '../models/res/login/send_sms_bean.dart';
import '../models/res/public_config.dart';
import '../models/res/splash/slide_bean.dart';

/// 一些通用的请求，比如公告、banner等
class CommonProvider extends GetBaseConnect {
  /// 获取启动页广告
  static Future<SlideBean?> getSlide() async {
    BaseResponse response = await CommonApis.of().getSlide();
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return SlideBean.fromJson(response.data);
  }

  /// 轮播图广告位查询，根据code
  static Future<List<BannerBean>?> getBannerList(String code) async {
    Map<String, String> params = {"flashviewCode": code};
    BaseResponse response = await CommonApis.of().getBannerList(params);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return (response.data as List<dynamic>)
        .map((e) => BannerBean.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// 全局公告,一条数据
  static Future<NoticeBean?> getAdvNotice(int type) async {
    Map<String, int> params = {"type": type};
    BaseResponse response = await CommonApis.of().getAdvNotice(params);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    var data = response.data;
    if (GetUtils.isNull(data) == true) {
      return null;
    }
    return NoticeBean.fromJson(response.data);
  }

  /// 版本更新
  static Future<AppVersionUpdateBean?> getAppVersionUpdateBean() async {
    BaseResponse response = await CommonApis.of().getApiVerInfo();
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return AppVersionUpdateBean.fromJson(response.data);
  }

  /// 获取IM的token
  static Future<AgoraTokenBean?> getRtmToken() async {
    BaseResponse response = await CommonApis.of().getRtmToken();
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return AgoraTokenBean.fromJson(response.data);
  }

  /// 获取用户钱包信息-接口
  static Future<UserWalletModel?> getUserWallet({int walletType = 1}) async {
    BaseResponse response = await CommonApis.of().getUserWallet(walletType);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return UserWalletModel.fromJson(response.data);
  }

  /// 获取视频访问地址
  static Future<String?> getVideoVisitUrl(String fileId) async {
    BaseResponse response = await CommonApis.of().getVideoVisitUrl(fileId);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return response.data;
  }

  /// 全局配置信息
  static Future<PublicConfig?> getPublicConfig() async {
    BaseResponse response = await CommonApis.of().getPublicConfig();
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return PublicConfig.fromJson(response.data);
  }

  /// 获取图片验证码
  static Future<ImageCodeModel?> randCode(int type) async {
    BaseResponse response = await CommonApis.of().randCode(type);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return ImageCodeModel.fromJson(response.data);
  }

  /// 获取短信验证码
  static Future<SendSmsBean?> sendSms(SendSmsParam param) async {
    BaseResponse response = await CommonApis.of().sendSms(param);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return SendSmsBean.fromJson(response.data);
  }

  /// 一键回收钱包余额
  static Future<BaseResponse?> oneKeyRecovery() async {
    BaseResponse response = await CommonApis.of().oneKeyRecovery();
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return response;
  }

  /// app 版本信息
  static Future<AppVersionBean?> queryAppVersion(String proName) async {
    BaseResponse response = await CommonApis.of().queryAppVersion(proName);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return AppVersionBean.fromJson(response.data);
  }

  /// 获取在线客服url
  static Future<OnlineServiceModel?> getOnlineService() async {
    BaseResponse response = await CommonApis.of().getOnlineService();
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return OnlineServiceModel.fromJson(response.data);
  }
}
