import 'dart:async';

import 'package:base/app_config.dart';
import 'package:base/app_routes.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base_page/image_code/image_code_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/models/req/user/find_password_param.dart';
import 'package:services/models/req/user/login_param.dart';
import 'package:services/models/req/user/send_sms_param.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/login/country_code_bean.dart';
import 'package:services/models/res/login/image_code_model.dart';
import 'package:services/provider/common_provider.dart';
import 'package:services/provider/user_provider.dart';

class RegisterController extends GetXBaseController {
  final TextEditingController phone = TextEditingController();
  final TextEditingController smscode = TextEditingController();
  final TextEditingController password = TextEditingController();

  /// 获取短信验证的时候是否需要图片验证码
  var smsNeedImageCode = false;
  var smsCodeIsOk = false;

  ///1-注册 2-忘记密码  4-忘记支付密码 5-手机号码认证
  ///@kap add 6 用于游客登录，修改密码流程，进入到请设置密码
  var type = 1.obs;

  /// 默认手机号
  var mobilePhone = "".obs;
  var typeTitle = "请设置密码（6-18位字符）";
  var pageTitle = "".obs;

   Timer? timer;
  var countdownTime = 61.obs;

  /// 区域信息
  Rx<CountryCodeBean> countryCodeData = CountryCodeBean().obs;

  @override
  void onInit() {
    _queryAllCountry();
    // 参数
    Map<String, dynamic>? args = Get.arguments;
    if (args != null && args.isNotEmpty) {
      type.value = args["type"] ?? 1;
      mobilePhone.value = args["mobilePhone"] ?? "";
    }
    // 手机号不为空，则设置手机号不可编辑
    if (mobilePhone.value.isNotEmpty) {
      phone.text = mobilePhone.value;
    }

    if (type.value == 1) {
      pageTitle.value = "注册";
    } else if (type.value == 2) {
      pageTitle.value = "忘记密码";
    } else if (type.value == 4) {
      pageTitle.value = "忘记支付密码";
    } else if (type.value == 5) {
      pageTitle.value = "手机号码认证";
    }
    else if (type.value == 6) {
      pageTitle.value = "手机号码设置";
    }
    super.onInit();
  }

  @override
  void onClose() {
    timer?.cancel();
  }

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

  void areaCodePage() async {
    await Get.toNamed(AppRoutes.areaCode, arguments: countryCodeData.value)
        ?.then((value) => {
              if (value != null) {countryCodeData.value = value}
            });
  }

  ///获取短信验证码
  sendSms(String phone, {String? imgCode, String? captchaKey}) async {
    if (countdownTime.value < 61) {
      return;
    }
    if (countryCodeData.value.areaCode.isEmpty) {
      OLEasyLoading.showToast(basePageString("please_country"));
      return;
    }
    if (phone.isEmpty) {
      OLEasyLoading.showToast(basePageString("please_phone_first"));
      return;
    }
    // 手机号正则校验
    if (!GetUtils.isPhoneNumber(phone)) {
      OLEasyLoading.showToast(basePageString("please_valid_phone"));
      return;
    }

    int newType = type.value;
    if (newType == 5) {
      newType = 3;
    }
    else if (newType == 6) { // 游客模式下
      newType = 1;
    }

    SendSmsParam param = SendSmsParam(
        phone: phone,
        sendType: newType,
        areaCode: countryCodeData.value.areaCode);
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
      if (res is BaseResponse?) {
        if (res?.code == 1005 || res?.code == 1006) {
          if (Get.isDialogOpen == true) {
            OLEasyLoading.showToast(res?.msg ?? "请填写图片验证码！");
          } else {
            _showImageCode((imageCode) {
              param = param.copyWith(
                  imgCode: imageCode?.imgCode,
                  captchaKey: imageCode?.captchaKey);
              _sendSms(param);
            });
          }
        }
        /*
        else if (res?.code == 2007) {
          // 无效的手机号码,忘记密码页面同时登录状态
          if ((type.value == 2 || type.value == 4) &&
              UserManagerCache.shared.isLogin()) {
            OLEasyLoading.showToast("请先绑定手机号码");
            Get.toNamed(AppRoutes.phoneBind);
          }
        }*/
      }
    }).whenComplete(() => OLEasyLoading.dismiss());
  }

  ///获取所有地区列表
  _queryAllCountry() async {
    UserProvider.queryAllCountry().then((value) {
      if (value == null || value.isEmpty == true) {
        return;
      }
      for (var obj in value) {
        if (obj.areaCode.contains("86")) {
          countryCodeData.value = obj;
          break;
        }
      }
    });
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

  /// 确定
  ///1-注册 2-忘记密码  4-忘记支付密码 5-手机号码认证
  submit() {
    var mobilePhone = phone.text.trim();
    if (mobilePhone.isEmpty) {
      OLEasyLoading.showToast(basePageString("please_phone_first"));
      return;
    }
    if (!smsCodeIsOk) {
      OLEasyLoading.showToast(basePageString("请先获取短信验证码"));
      return;
    }
    var smsCode = smscode.text.trim();
    if (smsCode.isEmpty) {
      OLEasyLoading.showToast(basePageString("please_sms"));
      return;
    }
    switch (type.value) {
      case 1:
      case 6:
        // 注册
        userRegisterAndLogin(
          phone.text,
          password: password.text,
          smsCode: smscode.text,
        );
        break;
      case 2:
        // 忘记密码
        _findPassword(1);
        break;
      case 4:
        // 忘记支付密码
        _findPassword(2);
        break;
      case 5:
        // 手机号码认证
        _userBindPhone();
        break;
      default:
        break;
    }
  }

  userRegisterAndLogin(
    String mobilePhone, {
    String? password,
    String? channelCode,
    String? inviteCode,
    String? smsCode,
    String? captchaKey,
    String? imgCode,
  }) async {
    if (mobilePhone.isEmpty) {
      OLEasyLoading.showToast(basePageString("please_phone_first"));
      return;
    }
    //手机登录
    if ((smsCode?.length ?? 0) <= 0) {
      OLEasyLoading.showToast(basePageString("please_sms"));
      return;
    }
    if ((password?.length ?? 0) <= 0) {
      OLEasyLoading.showToast(basePageString("please_pwd"));
      return;
    }
    if (!smsCodeIsOk) {
      OLEasyLoading.showToast(basePageString("请先获取短信验证码"));
      return;
    }

    if (type.value == 6) {
      OLEasyLoading.showLoading(basePageString('binding...'));
    }
    else {
      OLEasyLoading.showLoading(basePageString('register_ing'));
    }


    LoginParam param = LoginParam(
      flag: 3,
      mobilePhone: mobilePhone,
      areaCode: countryCodeData.value.areaCode,
      countryCode: countryCodeData.value.countryCode ?? "",
      password: password,
      channelCode: channelCode,
      inviteCode: inviteCode,
      smsCode: smsCode,
      captchaKey: captchaKey,
      imgCode: imgCode,
    );


    // OLEasyLoading.showLoading(basePageString("register_ing"));
    UserProvider.userRegisterAndLogin(param).then((value) {
      UserManagerCache.shared.setLoginBean(value);
      _handleLoginNext();
    }).whenComplete(() => OLEasyLoading.dismiss());
  }

  _handleLoginNext() {
    // 重置图形验证码标识
    smsNeedImageCode = false;

    if (type.value == 6) {
      OLEasyLoading.showToast(basePageString("bind_success"));
    }
    else {
      OLEasyLoading.showToast(basePageString("register_success"));
    }


    // 延迟1秒为了确保缓存信息保持成功
    Future.delayed(const Duration(seconds: 1), () {
      if (type.value == 1) {
        /// 关闭之前所有页面进入登录
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

  /// 忘密码
  _findPassword(int type) async {
    var mobilePhoneTxt = phone.text;
    var passwordTxt = password.text;
    var smsCodeTxt = smscode.text;
    if (mobilePhoneTxt.isEmpty) {
      OLEasyLoading.showToast(basePageString("please_phone_first"));
      return;
    }
    if (smsCodeTxt.isEmpty) {
      OLEasyLoading.showToast(basePageString("please_sms"));
      return;
    }
    if (passwordTxt.isEmpty) {
      OLEasyLoading.showToast(basePageString("please_pwd"));
      return;
    }
    if (!smsCodeIsOk) {
      OLEasyLoading.showToast(basePageString("请先获取短信验证码"));
      return;
    }
    FindPasswordParam param = FindPasswordParam(
        areaCode: countryCodeData.value.areaCode,
        type: type,
        mobilePhone: mobilePhoneTxt,
        password: passwordTxt,
        smsCode: smsCodeTxt);
    OLEasyLoading.showLoading(basePageString("修改中..."));

    UserProvider.findPassword(param).then((value) {
      OLEasyLoading.showToast(basePageString("修改成功"));
      // 重置图形验证码标识
      smsNeedImageCode = false;
      if (type == 1) {
        Get.offAllNamed(AppRoutes.loginPage, arguments: 1);
      } else {
        // Get.offAllNamed(AppRoutes.setUp);
        Get.back();
      }
    }).whenComplete(() => OLEasyLoading.dismiss());
  }

  /// 绑定手机号
  _userBindPhone() {
    Map<String, dynamic> params = {
      "areaCode": countryCodeData.value.areaCode,
      "mobilePhone": phone.text,
      "smsCode": smscode.text,
      "password": password.text
    };
    UserProvider.userBindPhone(params).then((value) {
      // 重置图形验证码标识
      smsNeedImageCode = false;
      Get.back();
    });
  }
}
