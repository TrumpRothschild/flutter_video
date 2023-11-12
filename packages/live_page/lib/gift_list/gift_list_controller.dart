part of 'gift_list_page.dart';

/// 礼物controller
class GiftListController extends GetXBaseController
    with StateMixin<List<LiveGiftBean>?> {
  /// 发送礼物成功响应
  Rx<LiveSendGiftBean?> sendGiftData = LiveSendGiftBean().obs;

  /// 用户钱包响应
  Rx<UserWalletModel?> userWalletData = UserWalletModel().obs;

  /// 当前选中发送的礼物
  Rx<LiveGiftBean?> curGiftData = LiveGiftBean().obs;


  @override
  void onInit() {
    super.onInit();
    _giftList();
    _getUserWallet();
  }

  /// 直播礼物列表
  _giftList() async {
    LiveProvider.giftList().then((value) {
      change(value, status: RxStatus.success());
    });
  }

  /// 获取用户钱包信息
  _getUserWallet() async {
    CommonProvider.getUserWallet().then((value) {
      userWalletData.value=value;
    });
  }

  /// 礼物打赏接口
  giftGiving(
      {required num? giftId,
      int giftNumber = 1,
      required num hostId,
      bool? isComboEnd = false}) {
    Map<String, dynamic> params = {
      "giftComboId": DateTime.now().millisecondsSinceEpoch,
      "giftId": giftId,
      "giftNumber": giftNumber,
      "hostId": hostId,
      "isComboEnd": isComboEnd
    };
    LiveProvider.giftGiving(params).then((value) {
      sendGiftData.value = value;
    });
  }
}
