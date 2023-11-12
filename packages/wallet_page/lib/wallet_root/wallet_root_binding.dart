import 'package:get/get.dart';

import 'wallet_root_controller.dart';

/// 登录binding
class WalletRootBinding extends Bindings {
  @override
  void dependencies() {
    //Get.lazyPut(() => WalletRootController());
    Get.put(WalletRootController());
  }
}
