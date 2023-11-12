import 'package:get/get.dart';

import 'edit_information_controller.dart';

/// 登录binding
class EditInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditInformationController>(() => EditInformationController());
  }
}
