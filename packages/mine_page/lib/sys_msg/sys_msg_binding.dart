import 'package:get/get.dart';

import 'sys_msg_controller.dart';

/// 登录binding
class SysMsgBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SysMsgController>(() => SysMsgController());
  }
}
