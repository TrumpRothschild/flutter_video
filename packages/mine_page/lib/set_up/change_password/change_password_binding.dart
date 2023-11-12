import 'package:get/get.dart';

import 'change_password_controller.dart';

/// 登录binding
class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
  }
}
