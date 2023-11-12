part of 'withdraw_page.dart';

class WithdrawController extends GetXBaseController {
  RxList<BankModel> bankList = <BankModel>[].obs;
  int currentBankIndex = 0;

  Rx<UserWalletModel?> userWalletModel = UserWalletModel().obs;

  double get amount =>
      double.tryParse(userWalletModel.value?.amount ?? '0.0') ?? 0.0;

  double get maxWithdraw =>
      double.tryParse(userWalletModel.value?.withdrawalMax ?? '0.0') ?? 0.0;

  double get minWithdraw =>
      double.tryParse(userWalletModel.value?.minWithdraw ?? '0.0') ?? 0.0;

  double get accountDml =>
      double.tryParse(userWalletModel.value?.accountDml ?? '0.0') ?? 0.0;

  String get withdrawTip {
    try {
      Map<String, dynamic> jsonMap =
          json.decode(userWalletModel.value?.desc ?? '');
      return jsonMap['context'];
    } catch (e) {
      return '';
    }
  }

  late TextEditingController withdrawInput;

  @override
  void onInit() {
    withdrawInput = TextEditingController();
    fetchBankList();
    getUserWallet();
    super.onInit();
  }

  @override
  void onClose() {
    withdrawInput.dispose();
    super.onClose();
  }

  Future<void> fetchBankList() async {
    BaseResponse response = await CommonApis.of().bankList();
    final resList = response.data as List? ?? [];
    final list = resList
        .map((e) => BankModel.fromJson(e as Map<String, dynamic>))
        .toList();
    bankList.clear();
    if (list.isNotEmpty) {
      bankList.addAll(list);
    }
    bankList.add(BankModel());
  }

  Future<void> getUserWallet({int walletType = 1}) async {
    BaseResponse response = await CommonApis.of().getUserWallet(walletType);
    final UserWalletModel? model = UserWalletModel.fromJson(response.data);
    if (model != null) {
      userWalletModel.value = model;
    }
  }

  Future<void> bindBank() async {
    var mobilePhone =
        UserManagerCache.shared.getUserDetail()?.mobilePhone ?? "";
    if (mobilePhone.isEmpty == true) {
      // 手机号为空,引导用户绑定手机号，并设置账户密码
      Get.dialog(NormalDialogWidgetAlert(
          controller: this,
          content: "您当前为游客账号，请先绑定手机号码哦，以防账号丢失",
          callBack: (type) async {
            if (1 == type) {
              await Get.toNamed(
                AppRoutes.register,
                arguments: {
                  "type": 5,
                },
              );
              // 刷新用户信息
              try {
                OLEasyLoading.showLoading('');
                final userDetail = await UserProvider.getUserInfo();
                if (userDetail != null) {
                  UserManagerCache.shared.setUserDetail(userDetail);
                }
                OLEasyLoading.dismiss();
              } catch (e) {
                Log.d('获取用户信息出错: $e');
                OLEasyLoading.dismiss();
              }
            }
          }));
      return;
    }

    if (bankList.length > 3) {
      OLEasyLoading.showToast('绑定银行卡不能超过3张');
      return;
    }
    final bool isRefresh =
        await Get.toNamed(AppRoutes.bindBank) as bool? ?? false;
    if (isRefresh) fetchBankList();
  }

  Future<bool> setPayPassword(
    String password,
  ) async {
    try {
      OLEasyLoading.showLoading('');
      BaseResponse res = await CommonApis.of().setPayPassword(password);
      OLEasyLoading.dismiss();
      return res.code == 200;
    } catch (e) {
      OLEasyLoading.dismiss();
      return false;
    }
  }

  Future<void> onDeleteItem(BankModel item) async {
    Get.dialog(
      DeleteBankCardAlert(
        customTheme: currentCustomThemeData(),
        onConfirm: () async {
          try {
            OLEasyLoading.showLoading('');
            BaseResponse res = await CommonApis.of().deleteBank(item.bankAccid);
            if (res.code == 200) {
              bankList.removeWhere(
                  (element) => element.bankAccid == item.bankAccid);
              OLEasyLoading.showToast('删除成功');
            }
          } catch (e) {
            print(e.toString());
          } finally {
            OLEasyLoading.dismiss();
          }
        },
      ),
    );
  }

  void toRecord() {
    Get.toNamed(AppRoutes.withdrawRecord);
  }

  Future<void> onWithdraw(BuildContext context) async {
    if (!checkWithdraw()) return;
    UserDetailModel? info = UserManagerCache.shared.getUserDetail();
    if (info?.mobilePhone?.isEmpty ?? true) {
      showBindMobileBottomSheet(
        context,
        customTheme: currentCustomThemeData(),
        onConfirm: () {
          Get.toNamed(AppRoutes.phoneBind);
        },
      );
      return;
    }
    if (info?.isPayPassword ?? false) {
      String? payPwd = await showPayPwdBottomSheet(
        context,
        customTheme: currentCustomThemeData(),
      );
      if (payPwd?.isNotEmpty ?? false) {
        try {
          OLEasyLoading.showLoading('');
          BaseResponse res = await CommonApis.of().onWithdraw(
            price: int.tryParse(withdrawInput.text) ?? 0,
            payPassword: payPwd,
            bankAccid: bankList[currentBankIndex].bankAccid,
          );
          if (res.code == 200) {
            OLEasyLoading.showToast('提现申请成功');
            getUserWallet();
            WithdrawResultModel info = WithdrawResultModel.fromJson(res.data);
            Get.toNamed(
              AppRoutes.withdrawResult,
              arguments: info.withdrawNo,
            );
          }
        } catch (e) {
          print(e.toString());
        } finally {
          OLEasyLoading.dismiss();
        }
      }
    } else {
      String? payPwd = await showNoPwdBottomSheet(
        context,
        customTheme: currentCustomThemeData(),
      );
      if (payPwd?.isNotEmpty ?? false) {
        bool hasSet = await setPayPassword(payPwd!);
        if (hasSet) {
          // 更新用户支付密码
          UserDetailModel? userDetail = UserManagerCache.shared.getUserDetail();
          if (userDetail != null) {
            UserManagerCache.shared
                .cacheUserDetail((userDetail..isPayPassword = true).toJson());
            UserManagerCache.shared
                .setUserDetail(userDetail..isPayPassword = true);
          }
          OLEasyLoading.showToast('支付密码设置成功');
          // Get.back();
        }
      }
    }
  }

  bool checkWithdraw() {
    if (currentBankIndex == bankList.length - 1 ||
        bankList.indexWhere((element) => element.bankAccid != null) == -1) {
      OLEasyLoading.showToast('请选择提现银行卡');
      return false;
    }
    if (withdrawInput.text.isEmpty) {
      OLEasyLoading.showToast('提现金额不能为空');
      return false;
    }
    final int withdrawAmount = int.tryParse(withdrawInput.text) ?? 0;
    if (withdrawAmount < 100) {
      OLEasyLoading.showToast('提现金额大于100');
      return false;
    }
    if (accountDml > 0) {
      OLEasyLoading.showToast('还需消费$accountDml金额可提现');
      return false;
    }
    if (withdrawAmount > amount) {
      OLEasyLoading.showToast('提现金额不能大于账户余额');
      withdrawInput.text = amount.toStringAsFixed(0);
      return false;
    }
    return true;
  }

  void setMaxAmount() {
    withdrawInput.text = amount.toStringAsFixed(0);
  }
}
