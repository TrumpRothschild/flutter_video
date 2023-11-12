import 'package:base/bases/get_base_binding.dart';
import 'package:get/get.dart';

import 'withdraw_record_controller.dart';

class WithdrawRecordBinding extends GetBaseBindings {
  @override
  void dependencies() {
    Get.lazyPut<WithdrawRecordController>(() => WithdrawRecordController());
  }
}
