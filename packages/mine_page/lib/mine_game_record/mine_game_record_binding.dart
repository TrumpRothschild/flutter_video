import 'package:get/get.dart';
import 'mine_game_record_controller.dart';

/// 登录binding
class MineGameRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MineGameRecordController>(() => MineGameRecordController());
  }
}
