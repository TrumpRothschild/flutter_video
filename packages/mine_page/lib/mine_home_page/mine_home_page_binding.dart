import 'package:get/get.dart';

import 'mine_home_page_controller.dart';

/// 登录binding
class MineHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MineHomeController>(() => MineHomeController());
  }
}
