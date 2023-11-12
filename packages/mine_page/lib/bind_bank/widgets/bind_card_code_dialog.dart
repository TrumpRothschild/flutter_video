import 'dart:async';

import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mine_page/bind_bank/bind_bank_page.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/models/req/user/send_sms_param.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/provider/common_provider.dart';

class BindCardCodeDialog extends StatefulWidget {
  const BindCardCodeDialog(
      {Key? key,
      required this.customTheme,
      required this.onConfirm,
      required this.codeController,
      required this.bankController})
      : super(key: key);

  final CustomTheme customTheme;
  final VoidCallback onConfirm;
  final TextEditingController codeController;
  final BindBankController bankController;

  @override
  State<BindCardCodeDialog> createState() => _BindCardCodeDialogState();
}

class _BindCardCodeDialogState extends State<BindCardCodeDialog> {
  late Timer _timer;
  var countdownTime = 61.obs;

  /// 短信是否需要图片验证码
  var smsNeedImageCode = false;

  void _startCountdownTimer() {
    var oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (countdownTime < 1) {
        countdownTime.value = 61;
        timer.cancel();
      } else {
        countdownTime.value = countdownTime.value - 1;
      }
    });
  }

  // 短信验证码
  _sendSms() async {
    if (countdownTime.value < 61) {
      return;
    }

    final phone = UserManagerCache.shared.getUserDetail()?.mobilePhone ?? "";
    if (phone.isEmpty) {
      OLEasyLoading.showToast('该用户未绑定手机号');
      return;
    }
    final areaCode =
        UserManagerCache.shared.getUserDetail()?.registerAreaCode ?? "";

    SendSmsParam param = SendSmsParam(
      phone: phone,
      sendType: 6,
      areaCode: areaCode,
    );
    if (smsNeedImageCode) {
      widget.bankController.showImageCode((imageCode) {
        param = param.copyWith(
            imgCode: imageCode?.imgCode, captchaKey: imageCode?.captchaKey);
        _sendSmsNext(param, isImageCode: true);
      });
    } else {
      // 不论成功失败，第二次获取短信验证码，都需要图形验证码
      if (!smsNeedImageCode) {
        smsNeedImageCode = true;
      }
      _sendSmsNext(param);
    }
  }

  // 短信验证码
  void _sendSmsNext(SendSmsParam param, {bool isImageCode = false}) {
    OLEasyLoading.showLoading("发送中...");
    CommonProvider.sendSms(param).then((value) {
      if (isImageCode && Get.isDialogOpen == true && smsNeedImageCode) {
        // 关闭图片验证码弹框
        Get.back();
      }
      OLEasyLoading.showToast('验证码发送成功');
      countdownTime.value = (value?.countDown ?? 60).toInt();
      _startCountdownTimer();
    }, onError: (error) {
      final res = error.error;
      if ((res is BaseResponse?) && (res?.code == 1005 || res?.code == 1006)) {
        if (Get.isDialogOpen == true) {
          OLEasyLoading.showToast(res?.msg ?? "请填写图片验证码！");
        } else {
          widget.bankController.showImageCode((imageCode) {
            param = param.copyWith(
                imgCode: imageCode?.imgCode, captchaKey: imageCode?.captchaKey);
            _sendSmsNext(param, isImageCode: true);
          });
        }
      }
    }).whenComplete(() => OLEasyLoading.dismiss());
  }

  @override
  void dispose() {
    _timer.cancel();
    smsNeedImageCode = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(Get.context!).size.width - 30,
          decoration: BoxDecoration(
            color: widget.customTheme.colors0xFFFFFF,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Text(
                  '请发送验证码',
                  style: TextStyle(
                    fontSize: 20,
                    color: widget.customTheme.colors0x000000,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 145,
                    height: 35,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: widget.customTheme.colors0xB6B6B6,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: TextField(
                        controller: widget.codeController,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9]')) // 设置只允许输入数字
                        ],
                        decoration: const InputDecoration(
                          hintText: '',
                          border: InputBorder.none,
                          isCollapsed: true,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          counterText: '',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: _sendSms,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color:
                            widget.customTheme.colors0xFF0000?.withOpacity(0.2),
                      ),
                      child: Obx(
                        () => Text(
                          countdownTime.value < 61
                              ? "${countdownTime.value}s${'后重发'}"
                              : '获取验证码',
                          style: TextStyle(
                            color: widget.customTheme.colors0xFF0000,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                '请输入当前注册手机收到的验证码',
                style: TextStyle(
                  color: widget.customTheme.colors0xFF0000,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: widget.customTheme.colors0xD9D9D9,
                      width: 0.5,
                    ),
                  ),
                ),
                height: 54,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Text(
                          '取消',
                          style: TextStyle(
                            color: widget.customTheme.colors0xD9D9D9,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: VerticalDivider(
                        color: widget.customTheme.colors0xD9D9D9,
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: widget.onConfirm,
                        child: Text(
                          '确认',
                          style: TextStyle(
                            color: widget.customTheme.colors0x9F44FF,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
