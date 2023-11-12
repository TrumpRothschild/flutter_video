part of 'withdraw_page.dart';

class WithdrawBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WithdrawController>(
      () => WithdrawController(),
    );
  }
}
