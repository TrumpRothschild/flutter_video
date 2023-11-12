import 'package:get/get.dart';

import 'activity_center_controller.dart';

/// 登录binding
class ActivityCenterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActivityCenterController>(
      () => ActivityCenterController(),
    );
  }
}
