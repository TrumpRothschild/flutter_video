import 'dart:developer';

import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: controller.currentCustomThemeData().colors0x9F44FF,
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Get.back();
          },
          icon: Image.asset(
            Assets.basePage.back.path,
            width: 7,
            height: 11,
          ),
        ),
        centerTitle: true,
        title: Obx(() {
          return Text(
            controller.pageTitle.value,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: controller.currentCustomThemeData().colors0xFFFFFF),
          );
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 27, 8, 0),
        child: Column(
          children: [
            Divider(
              height: 0.5,
              color: controller.currentCustomThemeData().colors0xDEDEDE,
            ),
            Row(
              children: [
                Text(
                  controller.basePageString("country_area"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: controller.currentCustomThemeData().colors0x000000,
                  ),
                ),
                Expanded(child: Container()),
                MaterialButton(
                  minWidth: 0,
                  padding: EdgeInsets.zero,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  height: 50,
                  onPressed: () {
                    controller.areaCodePage();
                    log("选择区号");
                  },
                  child: Row(
                    children: [
                      Obx(() {
                        return Text(
                          controller.countryCodeData.value.name ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: controller
                                .currentCustomThemeData()
                                .colors0x000000,
                          ),
                        );
                      }),
                      const SizedBox(
                        width: 8,
                      ),
                      Image.asset(
                        Assets.basePage.more.path,
                        width: 12,
                        height: 12,
                      ),
                    ],
                  ),
                )
              ],
            ),
            Divider(
              height: 0.5,
              color: controller.currentCustomThemeData().colors0xDEDEDE,
            ),
            field(
              controller.phone,
              "请输入手机号",
              enabled: controller.mobilePhone.isEmpty,
              isNumber: true,
              prefix: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    Assets.basePage.phoneBlack.path,
                    width: 10,
                    height: 15,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Obx(() {
                    return Text(
                      controller.countryCodeData.value.areaCode,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color:
                            controller.currentCustomThemeData().colors0x000000,
                      ),
                    );
                  }),
                  const SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 0.5,
                    height: 22,
                    decoration: BoxDecoration(
                      color:
                          controller.currentCustomThemeData().colors0xD1D1D1_70,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              ),
            ),
            Divider(
              height: 0.5,
              color: controller.currentCustomThemeData().colors0xDEDEDE,
            ),
            Obx(() {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: field(
                      controller.smscode,
                      "请输入短信验证码",
                      isNumber: true,
                      prefix: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            Assets.basePage.pwdBlack.path,
                            width: 12,
                            height: 14,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.zero,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minWidth: 0,
                    onPressed: () {
                      log("获取短信");
                      controller.sendSms(controller.phone.text);
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: controller.countdownTime.value < 61
                            ? controller.currentCustomThemeData().colors0xE5E5E5
                            : controller
                                .currentCustomThemeData()
                                .colors0x9F44FF,
                      ),
                      child: Center(
                        child: Text(
                          controller.countdownTime.value < 61
                              ? "${controller.countdownTime.value}s${controller.basePageString("后重发")}"
                              : controller.basePageString("sms_get"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: controller.countdownTime.value < 61
                                ? controller
                                    .currentCustomThemeData()
                                    .colors0x000000
                                : controller
                                    .currentCustomThemeData()
                                    .colors0xFFFFFF,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
            Divider(
              height: 0.5,
              color: controller.currentCustomThemeData().colors0xDEDEDE,
            ),
            Visibility(
                child: field(
                  controller.password,
                  controller.typeTitle,
                  prefix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        Assets.basePage.pwdOs.path,
                        width: 12,
                        height: 14,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  obscureText: true,
                ),
                visible: controller.type.value != 5),
            Divider(
              height: 0.5,
              color: controller.currentCustomThemeData().colors0xDEDEDE,
            ),
            const SizedBox(
              height: 28,
            ),
            MaterialButton(
              padding: EdgeInsets.zero,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              height: 33,
              minWidth: 150,
              onPressed: () {
                log("点击提交");
                controller.submit();
              },
              child: Container(
                width: 200,
                height: 35,
                decoration: BoxDecoration(
                  color: controller.currentCustomThemeData().colors0x9F44FF,
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
                child: Center(
                  child: Text(
                    controller.basePageString("确认"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: controller.currentCustomThemeData().colors0xFFFFFF,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextField field(TextEditingController textController, String hintText,
      {bool obscureText = false,
      Widget? prefix,
      bool enabled = true,
      bool isNumber = false}) {
    return TextField(
      controller: textController,
      enabled: enabled,
      // maxLength: 15,
      style: TextStyle(
        color: controller.currentCustomThemeData().colors0x000000,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      inputFormatters: isNumber
          ? [FilteringTextInputFormatter.digitsOnly]
          : [FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]"))],
      decoration: InputDecoration(
        // labelText: "手机号",
        border: InputBorder.none,
        // 去掉下滑线
        counterText: '',
        // 去除输入框底部的字符计数
        hintText: hintText,
        hintStyle: TextStyle(
          color: controller.currentCustomThemeData().colors0xD1D1D1,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        // prefix: prefix,
        prefixIcon: prefix,
        prefixIconConstraints: const BoxConstraints(
          minHeight: 0,
          minWidth: 0,
        ),
      ),
      obscureText: obscureText,
    );
  }
}
