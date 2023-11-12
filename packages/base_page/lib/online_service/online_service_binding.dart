import 'package:get/get.dart';

import 'online_service_controller.dart';

/// 登录binding
class OnlineServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnlineServiceController>(() => OnlineServiceController());
  }
}
