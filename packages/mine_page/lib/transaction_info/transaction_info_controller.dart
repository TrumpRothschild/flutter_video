part of 'transaction_info_page.dart';

class TransactionInfoController extends GetxController {
  late DetailList info;

  String get stateName {
    //1处理中，2成功，3失败，4取消，5申请中，6超时，7撒单
    switch (info.orderStatus) {
      case 1:
        return '交易处理中';
      case 2:
        return '交易成功';
      case 3:
        return '交易失败';
      case 4:
        return '交易取消';
      case 5:
        return '交易申请中';
      case 6:
        return '交易超时';
      case 7:
        return '交易撤销';
    }
    return '';
  }

  @override
  void onInit() {
    info = Get.arguments;
    super.onInit();
  }
}
