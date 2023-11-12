import 'package:get/get.dart';

import 'sys_msg_detail_controller.dart';

/// 登录binding
class SysMsgDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SysMsgDetailController>(() => SysMsgDetailController());
  }
}
