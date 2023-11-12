
import 'package:get/get.dart';
import 'mine_root_controller.dart';

/// 我的binding
class MineRootPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MineRootPageController>(() => MineRootPageController());
  }
}
