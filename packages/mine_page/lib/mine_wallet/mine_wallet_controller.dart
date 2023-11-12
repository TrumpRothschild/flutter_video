part of 'mine_wallet_page.dart';

class MineWalletController extends GetXBaseController {
  late final RefreshController refreshController;

  List<UserWalletModel> get userWallets => _userWallets;
  final _userWallets = <UserWalletModel>[].obs;

  List<UserGameWalletBean> get userGameWallets => _userGameWallets;
  final _userGameWallets = <UserGameWalletBean>[].obs;

  bool get isCoinExpand => _isCoinExpand.value;
  final _isCoinExpand = false.obs;

  toTransferList(TransactionPageType pageType) {
    Get.toNamed(
      AppRoutes.transactionDetail,
      arguments: pageType,
    );
  }

  toExchangeCoin() {
    Get.toNamed(
      AppRoutes.exchangeCoins,
      arguments: 0,
    );
  }

  /// 一键回收游戏钱包余额
  _oneKeyRecovery() async {
    CommonProvider.oneKeyRecovery().then((value) => {_getUserWalletList()},
        onError: (error) => {_getUserWalletList()});
  }

  toExchangeDiamond() {
    Get.toNamed(
      AppRoutes.exchangeCoins,
      arguments: 1,
    );
  }

  toWithdraw() {
    Get.toNamed(
      AppRoutes.walletRoot,
    );
  }

  rollOutAll() async {
    try {
      OLEasyLoading.showLoading('');
      BaseResponse res = await CommonApis.of().oneKeyRecovery();
      if (res.data == true) {
        OLEasyLoading.showToast('操作成功');
      } else {
        OLEasyLoading.showToast(res.msg ?? '');
      }
      OLEasyLoading.dismiss();
    } catch (e) {
      OLEasyLoading.dismiss();
    }
  }

  /// 0 1余额 2金币  默认余额
  toRecharge(int accountType) {
    Get.toNamed(
      AppRoutes.walletRoot,
      arguments: {
        'accountType': accountType,
      },
    );
  }

  void onExpandGameTap() async {
    await _getUserGameWalletList();
    if (userGameWallets.isEmpty) {
      OLEasyLoading.showToast('未查询到游戏钱包');
      return;
    }
    _isCoinExpand.value = !isCoinExpand;
  }

  toGameTransferIn(
    UserWalletModel userWallet,
    UserGameWalletBean gameWallet,
  ) async {
    await Get.toNamed(
      AppRoutes.gameTransferIn,
      arguments: {
        'pageType': GameTransferPageType.transferIn,
        'walletType': userWallet.walletType,
        'categoryId': gameWallet.categoryId,
      },
    );
    refreshController.requestRefresh();
  }

  toGameRollOut(
    UserWalletModel userWallet,
    UserGameWalletBean gameWallet,
  ) async {
    await Get.toNamed(
      AppRoutes.gameTransferIn,
      arguments: {
        'pageType': GameTransferPageType.rollOut,
        'walletType': userWallet.walletType,
        'categoryId': gameWallet.categoryId,
      },
    );
    refreshController.requestRefresh();
  }

  onRefresh() async {
    _userWallets.clear();
    _userGameWallets.clear();
    _getUserWalletList();
  }

  @override
  void onInit() {
    refreshController = RefreshController();
    super.onInit();
  }

  @override
  void onReady() {
    // _getUserWalletList();
    _oneKeyRecovery();
    super.onReady();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  /// 获取用户钱包
  _getUserWalletList() async {
    try {
      OLEasyLoading.showLoading('');
      BaseResponse res = await CommonApis.of().getUserWallet(1);
      if (GetUtils.isNull(res.data) == true) {
        OLEasyLoading.dismiss();
        return;
      }

      _userWallets.clear();
      final item = UserWalletModel.fromJson(res.data);
      _userWallets.add(item);
      refreshController.refreshCompleted();
      OLEasyLoading.dismiss();
    } catch (e) {
      OLEasyLoading.dismiss();
      refreshController.refreshFailed();
    }
  }

  _getUserGameWalletList() async {
    if (userGameWallets.isNotEmpty) return;
    try {
      OLEasyLoading.showLoading('');
      BaseResponse res = await CommonApis.of().getUserGameWalletList();
      if (GetUtils.isNull(res.data) == true) {
        OLEasyLoading.dismiss();
        return;
      }
      final dataList = res.data as List;
      if (dataList.isNotEmpty) {
        _userGameWallets.clear();
        _userGameWallets.addAll(
          dataList
              .map(
                  (e) => UserGameWalletBean.fromJson(e as Map<String, dynamic>))
              .toList(),
        );
      }
      refreshController.refreshCompleted();
      OLEasyLoading.dismiss();
    } catch (e) {
      OLEasyLoading.dismiss();
      refreshController.refreshFailed();
    }
  }
}
