import 'package:get/get.dart';

import 'my_grade_controller.dart';

/// 登录binding
class MyGradeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyGradeController>(() => MyGradeController());
  }
}
