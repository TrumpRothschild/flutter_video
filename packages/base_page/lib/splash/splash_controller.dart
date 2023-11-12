import 'dart:async';

import 'package:base/app_config.dart';
import 'package:base/app_doamin.dart';
import 'package:base/app_routes.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:get/get.dart';
import 'package:services/common/cache/gesture_pwd_cache.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/models/req/user/login_param.dart';
import 'package:services/models/res/splash/slide_bean.dart';
import 'package:services/provider/common_provider.dart';
import 'package:services/provider/user_provider.dart';

class SplashController extends GetXBaseController with StateMixin<SlideBean?> {
  /// 广告页倒计时总时间
  var adSeconds = 0.obs;

  /// 倒计时
  Timer? _timer;

  bool showCount = false;

  @override
  void onInit() {
    // 重置广告倒计时
    adSeconds.value = 0;
    _initDomain();
    super.onInit();
  }

  @override
  void onClose() {
    if (_timer != null) {
      _timer?.cancel();
    }
  }

  /// 初始化api请求地址的域名
  _initDomain() async {
    bool res = await AppDomain.checkDomain();
    Log.d("当前地址状态：【$res】");
    if (res) {
      _getPublicConfig();
      _getOnlineService();
    }
  }

  /// 获取配置信息，并缓存
  _getPublicConfig() {
    CommonProvider.getPublicConfig().then((value) {
      // 全局配置信息
      UserManagerCache.shared.config = value;
    }).whenComplete(() {
      // dave反馈启动页延迟2秒
      Future.delayed(const Duration(seconds: 2)).then((value) {
        _getSlide();
      });
    });
  }

  /// 获取在线客服url
  _getOnlineService() {
    CommonProvider.getOnlineService().then((value) {
      if (value != null) {
        UserManagerCache.shared.onlineServiceUrl = value.context ?? "";
      }
    });
  }

  /// 广告页
  _getSlide() async {
    CommonProvider.getSlide().then((value) {
      if (!isClosed && value != null) {
        change(value, status: RxStatus.success());
        showCountDown();
        adSeconds.value = (value.showTime ?? 0).toInt();
      } else {
        _goNextPage();
        return;
      }
    }, onError: (err) {
      _goNextPage();
    });
  }

  ///  进去下一个页面
  _goNextPage() async {
    if (UserManagerCache.shared.isLogin()) {
      Log.d("splash【已登陆】");
      final gesPwd = await GesturePwdCache.instance.getCachedGesPwd();
      if (gesPwd.isNotEmpty) {
        final bool isCheck =
            await Get.toNamed(AppRoutes.gesturePwdAuth) as bool? ?? false;
        if (!isCheck) return;
      }
      // 已经登录,直接进入主页
      if (AppConfig.app == EnvApp.video) {
        Get.offNamed(AppRoutes.videoMain);
      } else {
        Get.offNamed(AppRoutes.mainPage);
      }
      _oneKeyRecovery();
    } else {
      Log.d("splash【游客登陆】");
      var loginParam = LoginParam(
          channelCode: "official", appVersion: AppConfig.packageInfo?.version);
      UserProvider.visitorLogin(loginParam).then((value) async {
        // 设置用户信息
        UserManagerCache.shared.setLoginBean(value);
      }).whenComplete(() {
        _oneKeyRecovery();
        // 进入主页
        if (AppConfig.app == EnvApp.video) {
          Get.offNamed(AppRoutes.videoMain);
        } else {
          Get.offNamed(AppRoutes.mainPage);
        }
      });
    }
  }

  void showCountDown() {
    // OLImage 的 fadeInDuration 是 500
    Future.delayed(const Duration(milliseconds: 600)).then((value) {
      showCount = true;
      update(['count_down']);
      _countdownTimer();
    });
  }

  void _countdownTimer() {
    if (adSeconds.value < 1) {
      _goNextPage();
      return;
    }
    var oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      adSeconds.value--;
      if (adSeconds.value < 1) {
        timer.cancel();
        _goNextPage();
      }
    });
  }

  /// 一键回收游戏钱包余额
  _oneKeyRecovery() async {
    CommonProvider.oneKeyRecovery();
  }
}
