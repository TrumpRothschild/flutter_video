part of 'game_transfer_page.dart';

enum GameTransferPageType {
  /// 转入游戏
  transferIn,

  /// 游戏转出
  rollOut,
}

extension GameTransferPageTypeHelper on GameTransferPageType {
  String get title {
    switch (this) {
      case GameTransferPageType.transferIn:
        return '转入游戏';
      case GameTransferPageType.rollOut:
        return '游戏转出';
    }
  }
}

class GameTransferInController extends GetXBaseController {
  late final GameTransferPageType pageType;

  late final String? _walletType;

  UserWalletModel get userWallet => _userWallet.value;
  final _userWallet = UserWalletModel().obs;

  late final TextEditingController amountController;

  int? _categoryId;

  double _balance = 0.0;
  double _coin = 0.0;

  bool get showQuickBalance => pageType == GameTransferPageType.transferIn;

  List<DiamondModel> get quickBalances => _quickBalances;
  final _quickBalances = <DiamondModel>[].obs;
  DiamondModel? selectedQuick;

  RxDouble freeMoney = 0.0.obs;

  toRecharge() async {
    await Get.toNamed(
      AppRoutes.walletRoot,
      arguments: {
        'accountType': 2,
      },
    );
    // 刷新金币余额
    _getBalance();
  }

  typeAllBalance() {
    if (showQuickBalance) {
      if (_coin > 0) {
        amountController.text = '$_coin';
      }
    } else {
      if (freeMoney.value > 0) {
        amountController.text = '${freeMoney.value}';
      }
    }
  }

  onQuickItemTap(DiamondModel model) {
    if (model == selectedQuick) return;

    selectedQuick = model;
    amountController.text = '${selectedQuick?.platformGoldNum}';
    _quickBalances.refresh();
  }

  onConfirm() async {
    final amount = amountController.text.trim();
    if (amount.isEmpty) {
      OLEasyLoading.showToast(showQuickBalance ? '请输入转入金额' : '请输入转出金币');
      return;
    }
    final amountDouble = double.parse(amount);

    if (amountDouble < 1) {
      OLEasyLoading.showToast(showQuickBalance ? '最少转入1个金币' : '最少转出1个金币');
      return;
    }
    if (showQuickBalance) {
      try {
        if (amountDouble > _balance) {
          Get.dialog(
            BalanchNoEnoughDialog(
              customTheme: currentCustomThemeData(),
              onRecharge: () async {
                Get.back();
                toRecharge();
              },
            ),
          );
        } else {
          BaseResponse res = await CommonApis.of().depositToGameWallet(
            amount: '$amountDouble',
            categoryId: _categoryId ?? 0,
            walletType: int.parse(_walletType ?? '0'),
          );
          if (res.code == 200) {
            _getBalance();
            OLEasyLoading.showToast(res.msg ?? '');
            Get.toNamed(
              AppRoutes.gameTransferResult,
              arguments: pageType.title,
            );
          }
        }
      } catch (e) {
        OLEasyLoading.showToast(e.toString());
      }
    } else {
      try {
        if (amountDouble > freeMoney.value) {
          Get.dialog(
            CoinNoEnoughDialog(
              customTheme: currentCustomThemeData(),
              toEarn: () {
                Get.back();
                // 赚金币
              },
            ),
          );
        } else {
          BaseResponse res = await CommonApis.of().withdrawGameCoin(
            amount: '$amountDouble',
            categoryId: _categoryId,
            walletType: _walletType,
          );
          if (res.code == 200) {
            _getBalance();
            OLEasyLoading.showToast(res.msg ?? '');
            Get.toNamed(
              AppRoutes.gameTransferResult,
              arguments: pageType.title,
            );
          }
        }
      } catch (e) {
        OLEasyLoading.showToast(e.toString());
      }
    }
  }

  @override
  void onInit() {
    pageType = Get.arguments['pageType'] as GameTransferPageType;
    _walletType = Get.arguments['walletType'] as String?;
    _categoryId = Get.arguments['categoryId'] as int?;
    amountController = TextEditingController();

    _getBalance();
    _getQuickOptions();
    _getGameBalance();
    super.onInit();
  }

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }

  // 获取用户钱包信息-接口
  static Future<UserWalletModel?> getUserWallet({int walletType = 1}) async {
    BaseResponse response = await CommonApis.of().getUserWallet(walletType);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return UserWalletModel.fromJson(response.data);
  }

  // 转入的时候获取用户余额
  _getBalance() async {
    try {
      OLEasyLoading.showLoading('');
      BaseResponse res = await CommonApis.of().getUserWallet(1);
      if (GetUtils.isNull(res.data) == true) {
        OLEasyLoading.dismiss();
        return;
      }
      _userWallet.value = UserWalletModel.fromJson(res.data);
      _balance = double.parse(userWallet.balance ?? '0.0');
      _coin = double.parse(userWallet.amount ?? '0.0');
      OLEasyLoading.dismiss();
    } catch (e) {
      OLEasyLoading.dismiss();
    }
  }

  // 转出的时候获取游戏金币
  _getGameBalance() async {
    try {
      OLEasyLoading.showLoading('');
      BaseResponse res =
          await CommonApis.of().queryGameBalance(categoryId: _categoryId);
      if (GetUtils.isNull(res.data) == true) {
        OLEasyLoading.dismiss();
        return;
      }
      freeMoney.value = res.data['freeMoney'] as double? ?? 0.0;
      OLEasyLoading.dismiss();
    } catch (e) {
      OLEasyLoading.dismiss();
    }
  }

  _getQuickOptions() async {
    try {
      final res = await WalletApis.of.call().getGoldOptions();
      _quickBalances.clear();
      _quickBalances.addAll(res);
    } catch (e) {
      Log.d(e.toString());
    }
  }
}
