import 'package:get/get.dart';

import 'image_code_controller.dart';

/// 登录binding
class ImageCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImageCodeController>(() => ImageCodeController());
  }
}
