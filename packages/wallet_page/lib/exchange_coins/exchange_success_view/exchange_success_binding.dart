import 'package:get/get.dart';

import 'exchange_coins_controller.dart';

/// 登录binding
class ExchangeSuccessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExchangeSuccessController>(() => ExchangeSuccessController());
  }
}
