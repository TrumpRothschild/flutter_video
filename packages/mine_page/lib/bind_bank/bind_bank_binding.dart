part of 'bind_bank_page.dart';

class BindBankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BindBankController>(
      () => BindBankController(),
    );
  }
}
