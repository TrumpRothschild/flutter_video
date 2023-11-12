import 'package:base/bases/get_base_binding.dart';
import 'package:get/get.dart';

import 'game_transaction_controller.dart';

class GameTransactionBinding extends GetBaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<GameTransactionController>(() => GameTransactionController());
  }
}
