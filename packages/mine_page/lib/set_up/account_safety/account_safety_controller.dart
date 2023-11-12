part of 'account_safety_page.dart';

class AccountSafetyController extends GetXBaseController {
  bool get isPhoneBinded => _isPhoneBinded.value;
  final _isPhoneBinded = false.obs;

  String get bindPhoneStatus => isPhoneBinded ? '您已经绑定了手机' : '您暂未认证手机号码';

  String get bindPhoneNumber => isPhoneBinded
      ? UserManagerCache.shared.getUserDetail()?.mobilePhone ?? ''
      : '点我进行认证';

  void toPhoneBinding() async {
    if (isPhoneBinded) return;
    await Get.toNamed(AppRoutes.phoneBind);
    _getUserPasswordStatus();
  }

  @override
  void onInit() {
    _getUserPasswordStatus();
    super.onInit();
  }

  _getUserPasswordStatus() async {
    OLEasyLoading.showLoading('');
    UserProvider.getUserPasswordStatus(3).then((value) {
      if (value != null) {
        _isPhoneBinded.value = !value;
      }
    }).whenComplete(() => OLEasyLoading.dismiss());
  }
}
