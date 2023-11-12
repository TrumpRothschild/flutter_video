import 'dart:developer';
// import 'dart:ffi';

import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:get/get.dart';
import 'package:services/api/wallet_apis.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/wallet/diamond_model.dart';
import 'package:services/models/res/wallet/user_wallet_model.dart';
import 'package:services/provider/common_provider.dart';
import 'exchange_success_view/exchange_success_page.dart';

class ExchangeCoinsController extends GetXBaseController {
  Rx<UserWalletModel?> wallet = UserWalletModel().obs;
  RxList ways = [].obs;

  ///0 金币  1钻石
  var exType = 0.obs;

  @override
  void onInit() {
    exType.value = Get.arguments ?? 0;
    getUserWallet();
    getPayData();
    super.onInit();
  }

  getUserWallet() async {
    try {
      wallet.value = await CommonProvider.getUserWallet();
      // OLUserManager.shared.save(res);
    } catch (e) {
      print(e);
    }
  }

  getPayData() async {
    try {
      if (exType.value == 0) {
        ways.value = await WalletApis.of.call().getGoldOptions();
      } else {
        ways.value = await WalletApis.of.call().getSilverBeanOptions();
      }
    } catch (e) {
      print(e);
    }
  }

  exchange(DiamondModel data) async {
    try {
      var tar = data.platformGoldNum?.toDouble() ?? 0;
      var cur = double.parse(wallet.value?.balance ?? "");
      if (tar > cur) {
        showSuccess(data, false);
        return;
      }
      OLEasyLoading.showLoading(walletPageString("提交中..."));
      BaseResponse res;
      if (exType.value == 0) {
        res =
            await WalletApis.of.call().exchangeGold(data.platformGoldNum ?? 0);
      } else {
        res = await WalletApis.of
            .call()
            .exchangeSilver(data.platformGoldNum ?? 0);
      }
      OLEasyLoading.dismiss();
      if ((res.code ?? 0) == 200) {
        getUserWallet();
        showSuccess(data, true);
      } else if ((res.code ?? 0) == 2030) {
        showSuccess(data, false);
      } else {
        OLEasyLoading.showToast(res.msg ?? basePageString("请重试"));
      }
    } catch (e) {
      print(e);
      OLEasyLoading.dismiss();
      OLEasyLoading.showToast(basePageString("请重试"));
    }
  }

  showSuccess(DiamondModel data, bool isok) {
    Get.bottomSheet(
      ExchangeSuccessPage(data, exType.value, isok),
      elevation: 1,
      enableDrag: false,
      persistent: true,
      ignoreSafeArea: true,
      isScrollControlled: true,
      isDismissible: false,
      enterBottomSheetDuration: const Duration(seconds: 0),
      exitBottomSheetDuration: const Duration(seconds: 0),
      barrierColor: currentCustomThemeData().colors0x000000_60,
    );
  }
}
