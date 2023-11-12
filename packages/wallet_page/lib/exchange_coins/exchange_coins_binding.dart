import 'package:get/get.dart';

import 'exchange_coins_controller.dart';

/// 登录binding
class ExchangeCoinsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExchangeCoinsController>(() => ExchangeCoinsController());
  }
}
