import 'package:base/bases/get_base_binding.dart';
import 'package:get/get.dart';

import 'game_home_controller.dart';

class GameHomeBinding extends GetBaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<GameHomeController>(() => GameHomeController());
  }
}
