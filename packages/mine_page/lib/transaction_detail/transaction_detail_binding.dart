import 'package:base/bases/get_base_binding.dart';
import 'package:get/get.dart';

import 'transaction_detail_controller.dart';

class TransactionDetailBinding extends GetBaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionDetailController>(() => TransactionDetailController());
  }
}
