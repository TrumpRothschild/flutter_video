import 'package:get/get.dart';

import 'phone_bind_controller.dart';

/// 登录binding
class PhoneBindBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhoneBindController>(() => PhoneBindController());
  }
}
