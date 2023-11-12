import 'package:get/get.dart';

import 'set_up_controller.dart';

/// 登录binding
class SetUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SetUpController>(() => SetUpController());
  }
}
