import 'dart:async';

import 'package:base/app_config.dart';
import 'package:base/app_event_bus.dart';
import 'package:base/app_routes.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/models/event/login_event.dart';
import 'package:services/models/req/user/login_param.dart';
import 'package:services/models/req/user/send_sms_param.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/login/country_code_bean.dart';
import 'package:services/models/res/login/image_code_model.dart';
import 'package:services/provider/common_provider.dart';
import 'package:services/provider/user_provider.dart';
import 'package:services/models/event/login_event.dart';
import 'package:base/app_event_bus.dart';
import '../image_code/image_code_page.dart';

/// 登录controller
class LoginController extends GetXBaseController {
  /// 密码是否需要图片验证码
  var pwdLoginNeedImageCode = false;

  /// 短信是否需要图片验证码
  var smsNeedImageCode = false;

  var smsCodeIsOk = false;

  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController sms = TextEditingController();

  /// 0 密码登录 1 验证码登录
  var tab = 1.obs;
   Timer? timer;
  var countdownTime = 61.obs;

  ///当前选择的区域
  Rx<CountryCodeBean> currentCode = CountryCodeBean().obs;


  DateTime lastPopTime = DateTime.now();

  void startCountdownTimer() {
    var oneSec = const Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (timer) {
      if (countdownTime < 1) {
        countdownTime.value = 61;
        timer.cancel();
      } else {
        countdownTime.value = countdownTime.value - 1;
      }
    });
  }

  @override
  void onClose() {
    timer?.cancel();
  }

  @override
  void onInit() {
    _queryAllCountry();
    super.onInit();
  }

  ///手机号或者密码登陆
  login() async {
    if (phone.text.isEmpty) {
      OLEasyLoading.showToast(basePageString("please_phone_first"));
      return;
    }
    // 手机号正则校验
    if (!GetUtils.isPhoneNumber(phone.text)) {
      OLEasyLoading.showToast(basePageString("please_valid_phone"));
      return;
    }

    LoginParam param = LoginParam(
        mobilePhone: phone.text,
        areaCode: currentCode.value.areaCode,
        countryCode: currentCode.value.countryCode ?? "");
    if (tab.value == 1) {
      //验证码登录
      if (sms.text.isEmpty) {
        OLEasyLoading.showToast(basePageString("please_sms"));
        return;
      }
      if (!smsCodeIsOk) {
        OLEasyLoading.showToast(basePageString("请先获取短信验证码"));
        return;
      }
      param = param.copyWith(flag: 1, smsCode: sms.text);
      _login(param);
    } else {
      // 密码登录
      if (password.text.isEmpty) {
        OLEasyLoading.showToast(basePageString("please_pwd"));
        return;
      }
      param = param.copyWith(flag: 2, password: password.text);
      if (pwdLoginNeedImageCode) {
        //需要图形验证码
        _showImageCode((imageCode) {
          param = param.copyWith(
              captchaKey: imageCode?.captchaKey, imgCode: imageCode?.imgCode);
          //在调用登录
          _login(param);
        });
      } else {
        _login(param);
      }
    }
  }

  ///国家编号
  _queryAllCountry() async {
    UserProvider.queryAllCountry().then((value) {
      if (value != null) {
        for (var obj in value) {
          if (obj.areaCode.contains("86")) {
            currentCode.value = obj;
            break;
          }
        }
      }
      if (currentCode.value.countryCode?.isEmpty == true) {
        currentCode.value = CountryCodeBean(
            name: "中国", countryCode: "zh_CN", areaCode: "0086", lang: "zh_CN");
      }
    });
  }

  void areaCodePage() async {
    await Get.toNamed(AppRoutes.areaCode, arguments: currentCode.value)
        ?.then((value) => {
              if (value != null) {currentCode.value = value}
            });
  }

  /// 获取短信验证码
  sendSms() async {
    if (countdownTime.value < 61) {
      return;
    }
    if (phone.text.isEmpty) {
      OLEasyLoading.showToast(basePageString("please_phone_first"));
      return;
    }
    // 手机号正则校验
    if (!GetUtils.isPhoneNumber(phone.text)) {
      OLEasyLoading.showToast(basePageString("please_valid_phone"));
      return;
    }
    if (currentCode.value.areaCode.isEmpty) {
      OLEasyLoading.showToast(basePageString("please_country"));
      return;
    }
    SendSmsParam param = SendSmsParam(
        phone: phone.text, sendType: 1, areaCode: currentCode.value.areaCode);
    if (smsNeedImageCode) {
      _showImageCode((imageCode) {
        param = param.copyWith(
            imgCode: imageCode?.imgCode, captchaKey: imageCode?.captchaKey);
        _sendSms(param);
      });
    } else {
      // 不论成功失败，第二次获取短信验证码，都需要图形验证码
      if (!smsNeedImageCode) {
        smsNeedImageCode = true;
      }
      _sendSms(param);
    }
  }

  /// 获取短信验证码
  _sendSms(SendSmsParam param) {
    OLEasyLoading.showLoading(basePageString("send_ing"));
    CommonProvider.sendSms(param).then((value) {
      if (Get.isDialogOpen == true && smsNeedImageCode) {
        // 关闭图片验证码弹框
        Get.back();
      }

      smsCodeIsOk = true;
      OLEasyLoading.showToast(basePageString("send_sms_success"));
      countdownTime.value = (value?.countDown ?? 60).toInt();
      startCountdownTimer();
    }, onError: (error) {
      final res = error.error;
      if ((res is BaseResponse?) && (res?.code == 1005 || res?.code == 1006)) {
        if (Get.isDialogOpen == true) {
          OLEasyLoading.showToast(res?.msg ?? "请填写图片验证码！");
        } else {
          _showImageCode((imageCode) {
            param = param.copyWith(
                imgCode: imageCode?.imgCode, captchaKey: imageCode?.captchaKey);
            _sendSms(param);
          });
        }
      }
    }).whenComplete(() => OLEasyLoading.dismiss());
  }

  /// 图片验证码弹框
  _showImageCode(Function(ImageCodeModel?) callback) {
    Get.dialog(
      ImageCodePage(
        submit: callback,
      ),
      barrierDismissible: false,
      barrierColor: currentCustomThemeData().colors0x000000_60,
    );
  }

  ///游客登录
  visitorLogin() async {
    OLEasyLoading.showLoading(basePageString("login_ing"));
    //检测游客是否已绑定手机号
    bool? check = await UserProvider.visitorCheck();
    if (check == true) {
      OLEasyLoading.dismiss();
      OLEasyLoading.showToast(basePageString("bind_phone_already"));
    } else {
      // 游客登录
      LoginParam param = LoginParam();
      UserProvider.visitorLogin(param).then((value) {
        UserManagerCache.shared.setLoginBean(value);
        _handleLoginNext(1);
      }).whenComplete(() => OLEasyLoading.dismiss());
    }
  }

  /// 账户密码登录
  _login(LoginParam param) {
    OLEasyLoading.showLoading(basePageString("login_ing"));
    UserProvider.userRegisterAndLogin(param).then((value) {
      if (pwdLoginNeedImageCode) {
        // 关闭图片验证码弹框
        Get.back();
      }
      UserManagerCache.shared.setLoginBean(value);
      _handleLoginNext(2);
    }, onError: (error) {
      if (tab.value == 0) {
        // 用户名密码登录
        pwdLoginNeedImageCode = true;
      }
    }).whenComplete(() => OLEasyLoading.dismiss());
  }

  /// 登录成功跳转处理 1 游客登录 2 账户密码登录
  _handleLoginNext(int type) {
    OLEasyLoading.showToast(basePageString("login_success"));
    // 重置图形验证码标识
    pwdLoginNeedImageCode = false;
    smsNeedImageCode = false;

    // 延迟1秒为了确保缓存信息保持成功
    Future.delayed(const Duration(seconds: 1), () {
      //发送登录事件
      eventBus.fire(LoginEvent(type));
      if ((Get.arguments ?? 0) == 1) {
        /// 关闭之前所有页面进入登录
        eventBus.fire(LoginEvent(type));
        if (AppConfig.app == EnvApp.video) {
          Get.offAndToNamed(AppRoutes.videoMain, arguments: 0);
        } else {
          Get.offAndToNamed(AppRoutes.mainPage, arguments: 0);
        }
      } else {
        Get.back();
      }
    });
  }
}
