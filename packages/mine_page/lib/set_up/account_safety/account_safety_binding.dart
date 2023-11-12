part of 'account_safety_page.dart';

class AccountSafetyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountSafetyController>(
      () => AccountSafetyController(),
    );
  }
}
