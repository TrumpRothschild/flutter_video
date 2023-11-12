import 'package:base/bases/get_base_binding.dart';
import 'package:get/get.dart';

import 'game_web_controller.dart';

class GameWebBinding extends GetBaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<GameWebController>(() => GameWebController());
  }
}
