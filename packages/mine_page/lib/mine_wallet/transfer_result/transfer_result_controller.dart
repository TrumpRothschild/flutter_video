part of 'transfer_result_page.dart';

class TransferResultController extends GetXBaseController {
  late final String title;

  onConfirm() {
    Get.back();
    Get.back();
  }

  @override
  void onInit() {
    title = Get.arguments as String? ?? '';
    super.onInit();
  }
}
