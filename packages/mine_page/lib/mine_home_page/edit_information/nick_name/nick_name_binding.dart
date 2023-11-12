import 'package:get/get.dart';

import 'nick_name_controller.dart';

/// 登录binding
class NickNameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NickNameController>(() => NickNameController());
  }
}
