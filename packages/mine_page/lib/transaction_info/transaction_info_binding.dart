part of 'transaction_info_page.dart';

class TransactionInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionInfoController>(
      () => TransactionInfoController(),
    );
  }
}
