part of 'recharge_confirm_dialog.dart';

class RechargeConfirmDialogController extends GetXBaseController {
  RechargeConfirmDialogController({
    required this.imagecode,
    required this.accountType,
    required this.activityType,
    required this.backCode,
    required this.payWayId,
    required this.price,
    required this.walletRootController,
  });

  late final TextEditingController verifyCodeTEC;
  late final FocusNode focusNode;

  final ImageCodeModel imagecode;
  final int accountType;
  final int activityType;
  final String backCode;
  final String payWayId;
  final String price;
  final WalletRootController walletRootController;

  Future<void> onContinue(String text) async {
    try {
      var account = accountType;
      if (account == 0) {
        account = 1;
      }
      int? activity;
      if (activityType != 100) {
        activity = activityType;
      }

      // OLEasyLoading.showLoading(walletPageString("提交中..."));
      BaseResponse res = await WalletApis.of.call().rechargeV2(
            backCode,
            payWayId,
            price,
            account,
            activity,
            imagecode.captchaKey ?? '',
            text,
          );
      // OLEasyLoading.dismiss();
      if (res.code == 200) {
        Get.back();
        OnLinePayModel data = OnLinePayModel.fromJson(res.data);
        var url = data.url ?? "";
        if (!url.startsWith("http")) {
          url = "https://" + url;
        }
        Log.d("外部网页");
        if (await canLaunchUrl(Uri.parse(url))) {
          // await launchUrl(Uri.parse(url));
          walletRootController.rechargeComplete();
          await launch(url);
        } else {
          OLEasyLoading.showToast(basePageString("无法打开") + url);
        }
      }
    } catch (e) {
      Log.d('e.toString(): ${e.runtimeType}');
      if (e is DioError?) {
        DioError? error = e as DioError?;
        Log.d('e.error: ${error?.runtimeType}');
        if (error?.error is BaseResponse?) {
          final res = error?.error as BaseResponse?;
          if (res?.code == 1006) {
            OLEasyLoading.showToast(res?.msg ?? '');
          }
        }
      }
    }
  }

  @override
  void onInit() {
    focusNode = FocusNode();
    verifyCodeTEC = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    focusNode.requestFocus();
    super.onReady();
  }

  @override
  void onClose() {
    focusNode.dispose();
    verifyCodeTEC.dispose();
    super.onClose();
  }
}
