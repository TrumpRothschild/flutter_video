part of 'update_ges_pwd_page.dart';

enum UpdateGesPwdStep {
  oldPwd,
  oldPwdError,
  setNewPwd,
  againSetPwd,
  newPwdNotSame,
  pwdPass,
  invalidNewPwdLength,
}

extension UpdateGesPwdStepHelper on UpdateGesPwdStep {
  String get tipText {
    switch (this) {
      case UpdateGesPwdStep.oldPwd:
        return '请输入旧密码';
      case UpdateGesPwdStep.oldPwdError:
        return '密码输入错误';
      case UpdateGesPwdStep.setNewPwd:
        return '请滑动设置新密码';
      case UpdateGesPwdStep.againSetPwd:
        return '请再次滑动设置新密码';
      case UpdateGesPwdStep.newPwdNotSame:
        return '两次输入密码不一致';
      case UpdateGesPwdStep.pwdPass:
        return '密码设置成功';
      case UpdateGesPwdStep.invalidNewPwdLength:
        return '密码长度不合法';
    }
  }

  bool get isErrorTipText {
    switch (this) {
      case UpdateGesPwdStep.oldPwdError:
      case UpdateGesPwdStep.newPwdNotSame:
      case UpdateGesPwdStep.invalidNewPwdLength:
        return true;
      case UpdateGesPwdStep.oldPwd:
      case UpdateGesPwdStep.setNewPwd:
      case UpdateGesPwdStep.againSetPwd:
      case UpdateGesPwdStep.pwdPass:
        return false;
    }
  }
}

class UpdateGesPwdController extends GetXBaseController
    with GetSingleTickerProviderStateMixin {
  String _pwd = '';
  String _lastPwd = '';

  // 输入错误的次数
  var errorCount = 0.obs;

  /// 抖动动画controller
  late AnimationController shakeController;

  UpdateGesPwdStep get updateGesPwdStep => _updateGesPwdStep.value;
  final _updateGesPwdStep = UpdateGesPwdStep.oldPwd.obs;

  onGesPwdComplete(List<int?>? data) async {
    if (data?.isEmpty == true) {
      OLEasyLoading.showToast('密码不能为空');
      return;
    }
    final pwd = data!.join('');
    switch (updateGesPwdStep) {
      case UpdateGesPwdStep.oldPwd:
      case UpdateGesPwdStep.oldPwdError:
        if (_pwd.isEmpty) {
          _pwd = await GesturePwdCache.instance.getCachedGesPwd();
          if (_pwd.isEmpty) {
            OLEasyLoading.showToast('未设置手势密码');
            // 未设置手势密码
            return;
          }
        }
        // 发起旧密码验证请求，根据返回结果设置新步骤
        // 1. 旧密码错误
        if (pwd != _pwd) {
          _updateGesPwdStep.value = UpdateGesPwdStep.oldPwdError;
          errorCount.value++;
          shakeController.forward();
          // 输入错误三次自动跳转登录页面
          if (errorCount.value >= 3) {
            Get.offAndToNamed(AppRoutes.loginPage, arguments: 1);
          }
          return;
        }
        // 2. 旧密码正确
        _updateGesPwdStep.value = UpdateGesPwdStep.setNewPwd;
        break;
      case UpdateGesPwdStep.setNewPwd:
      case UpdateGesPwdStep.invalidNewPwdLength:
        // 判断密码长度
        if (pwd.length < 4) {
          // 1. 不合法，设置错误提示
          OLEasyLoading.showToast('请设置最少4位数密码');
          _updateGesPwdStep.value = UpdateGesPwdStep.invalidNewPwdLength;
          return;
        }
        // 1. 合法，进入下一步
        _lastPwd = pwd;
        _updateGesPwdStep.value = UpdateGesPwdStep.againSetPwd;
        break;

      case UpdateGesPwdStep.againSetPwd:
      case UpdateGesPwdStep.newPwdNotSame:
        // 判断两次密码是否一致
        if (_lastPwd != pwd) {
          // 2. 不一致
          OLEasyLoading.showToast('两次输入密码不一致');
          _updateGesPwdStep.value = UpdateGesPwdStep.newPwdNotSame;
          return;
        }
        // 1. 一致
        _updateGesPwdStep.value = UpdateGesPwdStep.pwdPass;
        GesturePwdCache.instance.updateCachedGesPwd(_lastPwd);
        Get.back(result: true);
        break;
      case UpdateGesPwdStep.pwdPass:
        // 发起请求，修改密码
        break;
    }
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      _updateGesPwdStep.value = Get.arguments as UpdateGesPwdStep;
    }
    GesturePwdCache.instance.getCachedGesPwd().then((pwd) {
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
}
