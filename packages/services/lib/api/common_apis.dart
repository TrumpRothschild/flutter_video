import '../http.dart';
import '../models/req/user/send_sms_param.dart';
import '../models/res/login/online_service_model.dart';
import 'apis.dart';

/// @date 2023/02/01  10:28
/// @author bert
/// @des 通用api

class CommonApis {
  static CommonApis of() => CommonApis();

  /// 全局配置信息
  getPublicConfig() async {
    return await HttpUtil().post(Apis.publicConfig);
  }

  getPingInfo(String url) async {
    return await HttpUtil().getUri(url);
  }

  /// 获取启动页广告
  getSlide() async {
    return await HttpUtil().post(Apis.getSlide);
  }

  /// 获取接口的版本信息
  getApiVerInfo() async {
    return await HttpUtil().post(Apis.verApi);
  }

  ///发送短信验证码
  sendSms(SendSmsParam param) async {
    return await HttpUtil().post(Apis.sendSms, data: param.toJson());
  }

  ///随机图片
  ///  0 数字 1 字母
  randCode(int type) async {
    // return await HttpUtil().get(Apis.randCode, queryParameters: {"type": type});
    return await HttpUtil().postForm(Apis.randCode, data: {"type": type});
  }

  ///在线客服
  getOnlineService() async {
    return await HttpUtil().post(Apis.getOnlineService);
  }

  /// 轮播图广告位查询，根据code
  /// 参数flashviewCode说明：热门:hot, 首页(推荐):index, 游戏:game, 推荐置顶轮播:recommend
  getBannerList(Map<String, String> params) async {
    return await HttpUtil().post(Apis.getBannerList, data: params);
  }

  /// 全局公告,一条数据
  /// 参数type的说明：  1：直播间公告 2：开场公告（一个语言只有一条） 3：循环公告 4：首页公告 5：推荐栏目跑马灯公告 6：游戏列表跑马灯公告 7:兑换钻石公告 8：充值中心
  getAdvNotice(Map<String, int> params) async {
    return await HttpUtil().post(Apis.getAdvNotice, data: params);
  }

  /// 关注主播
  focusUser(Map<String, dynamic> params) async {
    return await HttpUtil().post(
      Apis.focusUser,
      data: params,
    );
  }

  /// 取关主播
  unfocusUser(Map<String, dynamic> params) async {
    return await HttpUtil().post(
      Apis.unfocusUser,
      data: params,
    );
  }

  getGameCodeList() async {
    return await HttpUtil().post(
      Apis.getGameCodeList,
    );
  }

  getLiveGameList(String code) async {
    return await HttpUtil().post(Apis.getLiveGameList, data: {'code': code});
  }

  /// 获取IM的token
  getRtmToken() async {
    return await HttpUtil().post(Apis.getRtmToken);
  }

  /// 获取用户钱包信息-接口
  getUserWallet(int walletType) async {
    return await HttpUtil()
        .post(Apis.getUserWallet, data: {'walletType': walletType});
  }

  setPassword(
    String password,
  ) async {
    return await HttpUtil().post(
      Apis.setPassword,
      data: {
        'password': password,
        'confirmPassword': password,
      },
    );
  }

  // 设置支付密码
  setPayPassword(
    String password,
  ) async {
    return await HttpUtil().post(
      Apis.resetPassword,
      data: {
        'password': password,
        'type': 2,
      },
    );
  }

  setPayPasswordByMessage(
    String password,
    String smsCode,
  ) async {
    return await HttpUtil().post(
      Apis.setPayPasswordByMessage,
      data: {
        'password': password,
        'smsCode': smsCode,
      },
    );
  }

  deleteBank(
    int? bankAccid,
  ) async {
    return await HttpUtil().post(
      Apis.deleteBank,
      data: {
        'bankAccid': bankAccid,
      },
    );
  }

  onWithdraw({
    required int? bankAccid,
    required int? price,
    required String? payPassword,
  }) async {
    return await HttpUtil().post(
      Apis.withdraw,
      data: {
        'bankAccid': bankAccid,
        'price': price,
        'payPassword': payPassword,
      },
    );
  }

  getFansList({
    required int pageNum,
    int pageSize = 10,
    required int userId,
  }) async {
    return await HttpUtil().post(
      Apis.getFansList,
      data: {
        "pageNum": pageNum,
        "pageSize": pageSize,
        "userId": userId,
      },
    );
  }

  getFocusList({
    required int pageNum,
    int pageSize = 10,
    required int userId,
  }) async {
    return await HttpUtil().post(
      Apis.getFocusList,
      data: {
        "pageNum": pageNum,
        "pageSize": pageSize,
        "userId": userId,
      },
    );
  }

  /// app 版本信息
  queryAppVersion(String proName) async {
    return await HttpUtil().get(
      Apis.queryAppVersion,
      queryParameters: {
        'proName': proName,
      },
    );
  }

  /// 获取视频访问地址
  getVideoVisitUrl(String fileId) async {
    return await HttpUtil().get(Apis.getVideoVisitUrl,
        queryParameters: {'cloudType': 0, 'fileId': fileId});
  }

  /// 用户钱包列表
  getUserWalletList() async {
    return await HttpUtil().post(
      Apis.getUserWalletList,
    );
  }

  /// 用户游戏钱包列表
  getUserGameWalletList() async {
    return await HttpUtil().post(
      Apis.getUserGameWalletList,
    );
  }

  /// 用户绑定银行卡列表
  bankList() async {
    return await HttpUtil().post(
      Apis.bankList,
    );
  }

  /// 银行卡列表
  getBankList() async {
    return await HttpUtil().post(
      Apis.getBankList,
    );
  }

  addBank(
    String bankAccountName,
    String bankAccountNo,
    String bankCode,
    String smsCode,
  ) async {
    return await HttpUtil().post(
      Apis.addBank,
      data: {
        "bankAccountName": bankAccountName,
        "bankAccountNo": bankAccountNo,
        "bankCode": bankCode,
        "isDefault": true,
        "smsCode": smsCode,
      },
    );
  }

  /// 一键回收游戏钱包余额
  oneKeyRecovery() async {
    return await HttpUtil().post(
      Apis.oneKeyRecovery,
    );
  }

  /// 游戏余额
  queryGameBalance({
    required int? categoryId,
  }) async {
    return await HttpUtil().post(
      Apis.queryGameBalance,
      data: {
        "categoryId": '$categoryId',
      },
    );
  }

  /// 转入转出
  /// optionType	操作类型：0=转入、1=转出
  /// walletType  划转的钱包类型（转出：需要转出的钱包类型 转入：需要转入的钱包类型）
  userWalletChange({
    required double amount,
    required int optionType,
    required String? walletType,
  }) async {
    return await HttpUtil().post(
      Apis.userWalletChange,
      data: {
        "amount": amount,
        "optionType": optionType,
        "walletType": walletType,
      },
    );
  }

  // 用户绑定手机号
  userBindPhone({
    required String areaCode,
    required String mobilePhone,
    required String smsCode,
  }) async {
    return await HttpUtil().post(
      Apis.userBindPhone,
      data: {
        "areaCode": areaCode,
        "mobilePhone": mobilePhone,
        "smsCode": smsCode,
      },
    );
  }

  // 用户绑定手机号
  getUserLevelInfo() async {
    return await HttpUtil().post(
      Apis.getUserLevelInfo,
    );
  }

  // 活动列表
  /// activityType 活动类型 0.其他 1.游戏活动 2.直播活动 3.首页弹窗 4.直播间弹窗
  getActivityList(int activityType) async {
    return await HttpUtil().post(
      Apis.getActivityList,
      data: {
        'activityType': activityType,
      },
    );
  }

  // 更新昵称
  updateNickName(String nickName) async {
    return await HttpUtil().post(
      Apis.updateNickName,
      data: {
        'nickName': nickName,
      },
    );
  }

  // 更新签名
  updateSignature(String signature) async {
    return await HttpUtil().post(
      Apis.updateSignature,
      data: {
        'signature': signature,
      },
    );
  }

  // 更新头像
  updateUserAvatar(String avatar) async {
    return await HttpUtil().post(
      Apis.updateUserAvatar,
      data: {
        'avatar': avatar,
      },
    );
  }

  // 更新用户信息
  updateUserInfo({
    String avatar = '',
    String birthday = '',
    String hometown = '',
    int maritalStatus = -1,
    String occupationCode = '',
    int sex = -1,
  }) async {
    return await HttpUtil().post(
      Apis.updateUserInfo,
      data: {
        if (avatar.isNotEmpty) "avatar": avatar,
        if (birthday.isNotEmpty) "birthday": birthday,
        if (hometown.isNotEmpty) "hometown": hometown,
        if (maritalStatus != -1) "maritalStatus": maritalStatus,
        if (occupationCode.isNotEmpty) "occupationCode": occupationCode,
        if (sex != -1) "sex": sex,
      },
    );
  }

  // 用户职业列表
  getUserOccupationList() async {
    return await HttpUtil().post(
      Apis.getUserOccupationList,
    );
  }

  // 转入游戏：上分
  depositToGameWallet({
    required String amount,
    required int categoryId,
    required int walletType,
  }) async {
    return await HttpUtil().post(
      Apis.depositToGameWallet,
      data: {
        "amount": amount,
        "categoryId": categoryId,
        "walletType": walletType,
      },
    );
  }

  // 游戏转出：下分
  withdrawGameCoin({
    required String amount,
    required int? categoryId,
    required String? walletType,
  }) async {
    return await HttpUtil().post(
      Apis.withdrawGameCoin,
      data: {
        "amount": amount,
        "categoryId": categoryId,
        "walletType": walletType,
      },
    );
  }
}
