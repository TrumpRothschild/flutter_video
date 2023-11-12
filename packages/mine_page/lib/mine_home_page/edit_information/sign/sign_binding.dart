import 'package:get/get.dart';

import 'sign_controller.dart';

/// 登录binding
class SignBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignController>(() => SignController());
  }
}
