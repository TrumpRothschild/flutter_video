import 'package:get/get.dart';

import 'area_code_controller.dart';

/// 选择区域binding
class AreaCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AreaCodeController>(() => AreaCodeController());
  }
}
