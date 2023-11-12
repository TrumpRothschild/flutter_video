part of 'withdraw_result_page.dart';

class WithdrawResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WithdrawResultController>(
      () => WithdrawResultController(),
    );
  }
}
