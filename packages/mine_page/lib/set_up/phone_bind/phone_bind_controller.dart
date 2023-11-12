import 'dart:async';

import 'package:base/app_routes.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base_page/image_code/image_code_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/api/common_apis.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/models/req/user/send_sms_param.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/login/country_code_bean.dart';
import 'package:services/models/res/login/image_code_model.dart';
import 'package:services/models/res/user/user_detail_model.dart';
import 'package:services/provider/common_provider.dart';
import 'package:services/provider/user_provider.dart';

/// 绑定手机号
class PhoneBindController extends GetXBaseController {
  late final TextEditingController phoneTextEditingController;
  late final TextEditingController codeTextEditingController;

  late Timer timer;
  var countdownTime = 61.obs;
  Rx<CountryCodeBean> countryCodeData = CountryCodeBean().obs;

  /// 获取短信验证的时候是否需要图片验证码
  var smsNeedImageCode = false;
  var smsCodeIsOk = false;

  void areaCodePage() async {
    await Get.toNamed(
      AppRoutes.areaCode,
      arguments: countryCodeData.value,
    )?.then(
      (value) => {
        if (value != null) {countryCodeData.value = value}
      },
    );
  }

  sendSms() async {
    if (countdownTime.value < 61) {
      return;
    }

    if (countryCodeData.value.areaCode.isEmpty) {
      OLEasyLoading.showToast(basePageString("please_country"));
      return;
    }
    final phone = phoneTextEditingController.text.trim();
    if (phone.isEmpty) {
      OLEasyLoading.showToast(basePageString("please_phone_first"));
      return;
    }
    SendSmsParam param = SendSmsParam(
        phone: phone, sendType: 3, areaCode: countryCodeData.value.areaCode);

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
      _startCountdownTimer();
    }).whenComplete(() => OLEasyLoading.dismiss());
  }

  void onConfirm() async {
    final areaCode = countryCodeData.value.areaCode;

    if (areaCode.isEmpty) {
      OLEasyLoading.showToast(basePageString("please_country"));
      return;
    }

    final mobilePhone = phoneTextEditingController.text.trim();
    if (mobilePhone.isEmpty) {
      OLEasyLoading.showToast(basePageString("please_phone_first"));
      return;
    }

    if (!smsCodeIsOk) {
      OLEasyLoading.showToast(basePageString("请先获取短信验证码"));
      return;
    }

    final smsCode = codeTextEditingController.text.trim();
    if (smsCode.isEmpty) {
      OLEasyLoading.showToast(basePageString("please_sms"));
      return;
    }
    OLEasyLoading.showLoading('');

    Map<String, dynamic> params = {
      "areaCode": countryCodeData.value.areaCode,
      "mobilePhone": mobilePhone,
      "smsCode": smsCode
    };

    UserProvider.userBindPhone(params).then((value) {
      /// 更新用户信息中的手机号
      UserDetailModel? userDetailModel =
          UserManagerCache.shared.getUserDetail();
      if (userDetailModel != null) {
        userDetailModel.mobilePhone = mobilePhone;
        UserManagerCache.shared.setUserDetail(userDetailModel);
        UserManagerCache.shared.cacheUserDetail(userDetailModel.toJson());
      }
      smsNeedImageCode = false;
      OLEasyLoading.showToast(basePageString("bind_phone_succ"));
      Get.back();
    }).whenComplete(() => OLEasyLoading.dismiss());
  }

  void _startCountdownTimer() {
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
  void onInit() {
    phoneTextEditingController = TextEditingController();
    codeTextEditingController = TextEditingController();
    _queryAllCountry();
    super.onInit();
  }

  @override
  void dispose() {
    timer.cancel();
    phoneTextEditingController.dispose();
    super.dispose();
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

  // 国家编号
  _queryAllCountry() async {
    UserProvider.queryAllCountry().then((value) {
      if (value == null) {
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
}
