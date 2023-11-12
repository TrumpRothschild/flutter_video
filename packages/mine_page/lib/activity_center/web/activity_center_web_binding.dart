import 'package:get/get.dart';

import 'activity_center_web_controller.dart';

/// 登录binding
class ActivityCenterWebBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivityCenterWebController>(
      () => ActivityCenterWebController(),
    );
  }
}
