import 'dart:developer';

import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:get/get.dart';
import 'package:services/api/wallet_apis.dart';
import 'package:services/models/res/wallet/user_wallet_model.dart';
import 'package:services/provider/common_provider.dart';

class ExchangeSuccessController extends GetXBaseController {
  Rx<UserWalletModel?> wallet = UserWalletModel().obs;

  @override
  void onInit() {
    getUserWallet();
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
}
