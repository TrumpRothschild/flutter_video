part of 'gesture_pwd_page.dart';

class GesturePwdController extends GetXBaseController
    with GetSingleTickerProviderStateMixin {
  String _pwd = '';

  String get pwdTipText => _pwdTipText.value;
  final _pwdTipText = '请滑动输入密码'.obs;

  final String _wrongPwdTipText = '密码输入错误';

  bool get isWrongPwd => pwdTipText == _wrongPwdTipText;

  /// 抖动动画controller
  late AnimationController shakeController;

  onGesPwdComplete(List<int?>? data) async {
    if (_pwd.isEmpty) {
      _pwd = await _getCachePwd();
      if (_pwd.isEmpty) {
        OLEasyLoading.showToast('未设置手势密码');
        // 未设置手势密码
        return;
      }
    }
    if (data?.isEmpty == true) {
      _pwdTipText.value = _wrongPwdTipText;
      return;
    }
    final pwd = data!.join('');
    if (pwd != _pwd) {
      shakeController.forward();
      _pwdTipText.value = _wrongPwdTipText;
      return;
    }
    // 密码验证成功
    Get.back(result: true);
  }

  void toForgetPwd() async {
    await Get.offAndToNamed(AppRoutes.loginPage, arguments: 1);
    _pwd = await _getCachePwd();
  }

  void toUpdatePwd() async {
    await Get.toNamed(AppRoutes.gesturePwdUpdate);
    _pwd = await _getCachePwd();
  }

  @override
  void onInit() {
    _getCachePwd().then((pwd) {
      if (pwd.isNotEmpty) {
        _pwd = pwd;
      }
    });
    shakeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    super.onInit();
  }

  @override
  void onReady() {
    if (!GetUtils.isNull(shakeController)) {
      shakeController.addListener(() {
        if (shakeController.status == AnimationStatus.completed) {
          shakeController.reset();
        }
      });
    }
    super.onReady();
  }

  @override
  void onClose() {
    if (!GetUtils.isNull(shakeController)) {
      shakeController.reset();
      shakeController.dispose();
    }
    super.onClose();
  }

  Future<String> _getCachePwd() async {
    return GesturePwdCache.instance.getCachedGesPwd();
  }
}
