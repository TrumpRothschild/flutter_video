import 'package:base/bases/get_base_binding.dart';
import 'package:get/get.dart';

import 'game_record_controller.dart';

class GameRecordBinding extends GetBaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<GameRecordController>(() => GameRecordController());
  }
}
