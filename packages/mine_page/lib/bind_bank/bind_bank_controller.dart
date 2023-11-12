part of 'bind_bank_page.dart';

class BindBankController extends GetXBaseController {
  RxList<SimpleBankModel> bankList = <SimpleBankModel>[].obs;
  RxString selectBank = ''.obs;

  late final TextEditingController textEditingController1;
  late final TextEditingController textEditingController2;
  late final TextEditingController codeController;

  get bankAccountName => null;

  get bankAccountNo => null;

  @override
  void onInit() {
    textEditingController1 = TextEditingController();
    textEditingController2 = TextEditingController();
    codeController = TextEditingController();
    fetchBankList();
    super.onInit();
  }

  @override
  void onClose() {
    textEditingController1.dispose();
    textEditingController2.dispose();
    codeController.dispose();
    super.onClose();
  }

  Future<void> fetchBankList() async {
    final list = await BindBankProvider.getBankList();
    if (list.isNotEmpty) {
      bankList.clear();
      bankList.addAll(list);
    }
  }

  void onConfirm() async {
    final bankAccountName = textEditingController1.text.trim();
    if (bankAccountName.isEmpty) {
      OLEasyLoading.showToast('请输入持卡人姓名');
      return;
    }
    final bankAccountNo = textEditingController2.text.trim();
    if (bankAccountNo.isEmpty) {
      OLEasyLoading.showToast('请输入银行卡号');
      return;
    }

    RegExp bankNoRegex = RegExp(r'^\d{15,19}$');
    if (!bankNoRegex.hasMatch(bankAccountNo)) {
      OLEasyLoading.showToast('请输入15到19位的纯数字银行卡号');
      return;
    }
    if (selectBank.isEmpty) {
      OLEasyLoading.showToast('请选择银行');
      return;
    }
    codeController.clear();

    Get.dialog(
      BindCardCodeDialog(
        customTheme: currentCustomThemeData(),
        onConfirm: () {
          final smsCode = codeController.text.trim();
          if (smsCode.isEmpty) {
            OLEasyLoading.showToast('请输入当前注册手机收到的验证码');
            return;
          }
          OLEasyLoading.showLoading('');
          BindBankProvider.addBank(
            bankAccountName: bankAccountName,
            bankAccountNo: bankAccountNo,
            bankCode: selectBank.value,
            smsCode: smsCode,
          ).then(
            (res) {
              if (res?.code == 200) {
                OLEasyLoading.showToast('添加成功！');
                Get.back();
                Get.back(result: true);
              }
            },
          ).whenComplete(
            () {
              OLEasyLoading.dismiss();
            },
          );
        },
        codeController: codeController,
        bankController: this,
      ),
      barrierDismissible: false,
    );
  }

  /// 图片验证码弹框
  void showImageCode(Function(ImageCodeModel?) callback) {
    Get.dialog(
      ImageCodePage(
        submit: callback,
      ),
      barrierDismissible: false,
      barrierColor: currentCustomThemeData().colors0x000000_60,
    );
  }
}
