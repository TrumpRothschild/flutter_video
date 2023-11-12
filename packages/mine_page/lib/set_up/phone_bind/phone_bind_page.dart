import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/country_row.dart';
import '../widgets/real_name_auth_functions.dart';
import 'phone_bind_controller.dart';

/// 绑定手机号
class PhoneBindPage extends GetView<PhoneBindController> {
  PhoneBindPage({Key? key}) : super(key: key);

  final TextEditingController zhanghao = TextEditingController();
  final TextEditingController mima = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Get.back();
            },
            icon: Image.asset(
              Assets.basePage.backBlack.path,
              width: 10,
              height: 20,
            ),
          ),
          centerTitle: true,
          title: Text(
            "手机认证",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: controller.currentCustomThemeData().colors0x000000,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  InkWell(
                    onTap: controller.areaCodePage,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 11),
                      child: Obx(
                        () => CountryRow(
                          customTheme: controller.currentCustomThemeData(),
                          countryName:
                              controller.countryCodeData.value.name ?? '',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Obx(
                        () => Text(
                          controller.countryCodeData.value.areaCode,
                          style: TextStyle(
                            color: controller
                                .currentCustomThemeData()
                                .colors0x000000,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: TextField(
                          controller: controller.phoneTextEditingController,
                          style: TextStyle(
                            color: controller
                                .currentCustomThemeData()
                                .colors0x000000,
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            hintText: '请输入手机号码',
                            hintStyle: TextStyle(
                              color: controller
                                  .currentCustomThemeData()
                                  .colors0xD6D6D6,
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: controller.sendSms,
                        child: Obx(
                          () => Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: controller.countdownTime.value < 61
                                  ? controller
                                      .currentCustomThemeData()
                                      .colors0xE3E3E3
                                  : controller
                                      .currentCustomThemeData()
                                      .colors0x7032FF,
                            ),
                            child: Center(
                              child: Text(
                                controller.countdownTime.value < 61
                                    ? "${controller.countdownTime.value}s${controller.basePageString("后重发")}"
                                    : controller.basePageString("sms_get"),
                                style: TextStyle(
                                  color: controller.countdownTime.value < 61
                                      ? controller
                                          .currentCustomThemeData()
                                          .colors0x000000
                                      : controller
                                          .currentCustomThemeData()
                                          .colors0xFFFFFF,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '验证码',
                        style: TextStyle(
                          color: controller
                              .currentCustomThemeData()
                              .colors0x000000,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: TextField(
                          controller: controller.codeTextEditingController,
                          style: TextStyle(
                            color: controller
                                .currentCustomThemeData()
                                .colors0x000000,
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            hintText: '请输入验证码',
                            hintStyle: TextStyle(
                              color: controller
                                  .currentCustomThemeData()
                                  .colors0xD6D6D6,
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(flex: 48),
            InkWell(
              onTap: controller.onConfirm,
              child: Container(
                width: 201,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  gradient: LinearGradient(
                    colors: [
                      controller.currentCustomThemeData().colors0x6129FF,
                      controller.currentCustomThemeData().colors0xD96CFF,
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    '确 认',
                    style: TextStyle(
                      color: controller.currentCustomThemeData().colors0xFFFFFF,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(flex: 158),
            RealNameAuthFunctions(
              customTheme: controller.currentCustomThemeData(),
              isRealNameAuth: false,
            ),
            const Spacer(flex: 221),
          ],
        ));
  }
}
