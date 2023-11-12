import 'package:get/get.dart';

import 'mine_focus_controller.dart';

/// 登录binding
class MineFocusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MineFocusController>(() => MineFocusController());
  }
}
