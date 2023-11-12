import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/api/wallet_apis.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/login/image_code_model.dart';
import 'package:services/models/res/wallet/on_line_pay_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../wallet_root/wallet_root_controller.dart';
import 'widgets/pin_code_text_field.dart';

part 'recharge_confirm_dialog_controller.dart';

class RechargeConfirmDialog extends GetView<RechargeConfirmDialogController> {
  const RechargeConfirmDialog({
    Key? key,
    required this.imagecode,
    required this.accountType,
    required this.activityType,
    required this.backCode,
    required this.payWayId,
    required this.price,
    required this.walletRootController
  }) : super(key: key);

  final ImageCodeModel imagecode;
  final int accountType;
  final int activityType;
  final String backCode;
  final String payWayId;
  final String price;
  final WalletRootController walletRootController;

  @override
  Widget build(BuildContext context) {
    Log.d('imagecode.img64Code: ${imagecode.img64Code}');
    return GetBuilder<RechargeConfirmDialogController>(
      init: RechargeConfirmDialogController(
        imagecode: imagecode,
        accountType: accountType,
        activityType: activityType,
        backCode: backCode,
        payWayId: payWayId,
        price: price,
        walletRootController: walletRootController,
      ),
      builder: (controller) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: FittedBox(
            child: Container(
              width: 45 * 4 + 7.5 * 2 * 3 + 20 * 2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 12),
                      Text(
                        '订单确认',
                        style: TextStyle(
                          color: controller
                              .currentCustomThemeData()
                              .colors0x000000_50,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Assets.walletPage.rechargeDollar.image(
                        width: 47,
                        height: 47,
                      ),
                      const SizedBox(height: 7),
                      Text(
                        '充值：￥$price',
                        style: TextStyle(
                          color: controller
                              .currentCustomThemeData()
                              .colors0x000000_50,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Container(
                        height: 1,
                        width: 242,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              controller
                                  .currentCustomThemeData()
                                  .colors0x000000_40!,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      if (imagecode.imgCode?.isNotEmpty == true) ...[
                        Text(
                          imagecode.imgCode ?? '',
                          style: TextStyle(
                            color: controller
                                .currentCustomThemeData()
                                .colors0x000000,
                            fontSize: 28,
                            letterSpacing: 10,
                          ),
                        ),
                        const SizedBox(height: 14),
                      ] else if (imagecode.validImg64Code.isNotEmpty) ...[
                        Image.memory(
                          imagecode.imageUrl(),
                          height: 39,
                          width: 120,
                          fit: BoxFit.cover,
                          gaplessPlayback: true,
                        ),
                        const SizedBox(height: 14),
                      ],
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: PinCodeTextField(
                          controller: controller.verifyCodeTEC,
                          focusNode: controller.focusNode,
                          pinBoxBorderWidth: 1,
                          defaultBorderColor: controller
                              .currentCustomThemeData()
                              .colors0x9F9F9F,
                          hasTextBorderColor: controller
                              .currentCustomThemeData()
                              .colors0x9F9F9F,
                          onTextChanged: (text) {},
                          onDone: (text) {
                            controller.onContinue(text);
                            controller.dispose();
                          },
                          pinBoxWidth: 45,
                          pinBoxHeight: 41,
                          pinBoxRadius: 5,
                          // maxLength: 6,
                          pinBoxOuterPadding: const EdgeInsets.symmetric(
                            horizontal: 7.5,
                          ),
                          hasUnderline: false,
                          wrapAlignment: WrapAlignment.spaceAround,
                          pinBoxDecoration:
                              ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                          keyboardType: TextInputType.number,
                          pinTextStyle: TextStyle(
                            fontSize: 20.0,
                            color: controller
                                .currentCustomThemeData()
                                .colors0x000000,
                          ),
                          pinTextAnimatedSwitcherTransition:
                              ProvidedPinBoxTextAnimation.scalingTransition,
                          pinBoxColor: Colors.transparent,
                          pinTextAnimatedSwitcherDuration:
                              const Duration(milliseconds: 200),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        '如订单无误，请输入以上验证码',
                        style: TextStyle(
                          color: controller
                              .currentCustomThemeData()
                              .colors0x000000_50,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: Get.back,
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Assets.walletPage.rechargeClose.image(
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
