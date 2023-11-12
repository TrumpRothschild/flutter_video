import 'package:services/api/apis.dart';
import 'package:services/http.dart';
import 'package:services/models/res/wallet/user_wallet_model.dart';

import '../models/res/base_response.dart';
import '../models/res/wallet/diamond_model.dart';
import '../models/res/wallet/pay_way_model.dart';

/// @date 2023/02/14
/// @author bert
/// @des 钱包相关api

class WalletApis {
  static WalletApis of() => WalletApis();

  ///兑换金币
  exchangeGold(int balanceAmount) async {
    Map<dynamic, dynamic> data = {
      "balanceAmount": balanceAmount,
    };
    return await HttpUtil().post(Apis.exchangeGold, data: data);
  }

  ///金币列表
  getGoldOptions() async {
    var response = await HttpUtil().post(Apis.getGoldOptions);
    List<dynamic> data = response.data;
    return data.map((m) => DiamondModel.fromJson(m)).toList();
  }

  ///兑换钻石
  exchangeSilver(int balanceAmount) async {
    Map<dynamic, dynamic> data = {
      "balanceAmount": balanceAmount,
    };
    return await HttpUtil().post(Apis.exchangeSilver, data: data);
  }

  ///钻石列表
  getSilverBeanOptions() async {
    var response = await HttpUtil().post(Apis.getSilverBeanOptions);
    List<dynamic> data = response.data;
    return data.map((m) => DiamondModel.fromJson(m)).toList();
  }

  ///支付方式
  getPayData() async {
    var response = await HttpUtil().post(Apis.getPayData);
    List<dynamic> data = response.data;
    return data.map((m) => PayWayModel.fromJson(m)).toList();
  }

  ///支付方式
  getPayDataV2(bool antiComplaint) async {
    Map<dynamic, dynamic> params = {
      "antiComplaint": antiComplaint,
    };
    var response = await HttpUtil().post(Apis.getPayDataV2, data: params);
    List<dynamic> data = response.data;
    return data.map((m) => PayWayModel.fromJson(m)).toList();
  }

  ///充值
  recharge(
    String? backCode,
    String? payWayId,
    String? price,
    String? payName,
    int? accountType,
    int? activityType,
  ) async {
    Map<dynamic, dynamic> data = {
      "backCode": backCode,
      "payWayId": payWayId,
      "price": price,
      "payName": payName,
      "accountType": accountType,
      "activityType": activityType,
    };
    var response = await HttpUtil().post(Apis.recharge, data: data);
    return response;
  }

  /// 充值
  /// accountType	充值入账的货币类型(必填) 1余额 2金币
  /// activityType 参加活动, 活动类型 1推广返现,2签到活动,3充值返现,4红包活动,5注册返现,6首充送钻石,7首充送金币
  /// backCode 支付渠道编码 ChannelCode
  /// captchaKey	图片标识
  /// imgCode	图片验证码
  /// payWayId	支付方式id
  /// price	金币数量
  rechargeV2(
    String? backCode,
    String? payWayId,
    String? price,
    int? accountType,
    int? activityType,
    String? captchaKey,
    String? imgCode,
  ) async {
    Map<dynamic, dynamic> data = {
      "backCode": backCode,
      "payWayId": payWayId,
      "price": price,
      "accountType": accountType,
      "activityType": activityType,
      "imgCode": imgCode,
      "captchaKey": captchaKey,
    };
    return await HttpUtil().post(
      Apis.rechargeV2,
      data: data
    );
  }
}
