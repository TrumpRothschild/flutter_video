part of 'transfer_result_page.dart';

class TransferResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransferResultController>(
      () => TransferResultController(),
    );
  }
}
