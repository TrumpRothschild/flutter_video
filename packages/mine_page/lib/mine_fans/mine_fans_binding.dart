import 'package:get/get.dart';

import 'mine_fans_controller.dart';

/// 登录binding
class MineFansBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MineFansController>(() => MineFansController());
  }
}
