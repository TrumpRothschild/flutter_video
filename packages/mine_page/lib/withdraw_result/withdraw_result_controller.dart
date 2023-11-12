part of 'withdraw_result_page.dart';

class WithdrawResultController extends GetXBaseController {
  String? _orderNo;

  Rx<WithdrawResultModel> info = WithdrawResultModel().obs;

  _getResult() async {
    try {
      OLEasyLoading.showLoading('');
      final res = await WithdrawRecordProvider.withdrawResult(_orderNo);

      if (res?.code == 200 && GetUtils.isNull(res?.data) == false) {
        info.value = WithdrawResultModel.fromJson(res!.data);
      }
      OLEasyLoading.dismiss();
    } catch (e) {
      OLEasyLoading.dismiss();
    }
  }

  @override
  void onInit() {
    _orderNo = Get.arguments;
    super.onInit();
  }

  @override
  void onReady() {
    _getResult();
    super.onReady();
  }
}
