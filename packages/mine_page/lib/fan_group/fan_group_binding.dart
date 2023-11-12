import 'package:get/get.dart';

import 'fan_group_controller.dart';

/// 登录binding
class FanGroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FanGroupController>(() => FanGroupController());
  }
}
