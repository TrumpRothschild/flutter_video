import 'package:get/get.dart';

import 'login_controller.dart';

/// 登录binding
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }

}
