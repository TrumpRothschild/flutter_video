import 'package:base/app_config.dart';
import 'package:base/assets.gen.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'login_controller.dart';
import 'login_widget.dart';

/// 登录view
class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var customTheme = controller.currentCustomThemeData();
    var isVideo = AppConfig.isVideo;
    return Obx(() => GestureDetector(
          onTap: () {
            WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
          },
          onVerticalDragEnd: (_) {
            WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
          },
          child: Scaffold(
              body: WillPopScope(
            onWillPop: () async {
              // 点击返回键的操作
              if (DateTime.now().difference(controller.lastPopTime) >
                  const Duration(seconds: 2)) {
                controller.lastPopTime = DateTime.now();
                OLEasyLoading.showToast('再按一次退出');
                return Future.value(false);
              } else {
                controller.lastPopTime = DateTime.now();
                // 退出app
                await SystemChannels.platform
                    .invokeMethod('SystemNavigator.pop');
                return Future.value(true);
              }
            },
            child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // 背景
                  LoginWidget.of().loginBg(),
                  // 注册
                  Visibility(
                      child: Positioned(
                          top: AppDimens.h_50,
                          right: AppDimens.w_30,
                          child: LoginWidget.of().register()),
                      visible: controller.tab.value == 0 && isVideo),

                  // logo
                  Visibility(
                      child: Positioned(
                          top: AppDimens.h_100,
                          child: Image.asset(
                            Assets.basePage.icVideoLoginLogo.path,
                            width: AppDimens.w_90,
                            height: AppDimens.w_90,
                          )),
                      visible: isVideo),

                  Positioned(
                    top: AppDimens.h_240,
                    left: isVideo ? AppDimens.w_30 : AppDimens.w_50,
                    right: isVideo ? AppDimens.w_30 : AppDimens.w_50,
                    child: Container(
                      padding: const EdgeInsets.all(AppDimens.w_13)
                          .copyWith(top: AppDimens.h_15),
                      decoration: BoxDecoration(
                        color: isVideo
                            ? Colors.transparent
                            : customTheme.colors0x000000_30,
                        borderRadius: BorderRadius.circular(AppDimens.w_20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.tab.value = 0;
                                },
                                child: Text(
                                  controller.basePageString("pwd_login"),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: FontDimens.fontSp18,
                                    color: controller.tab.value == 0
                                        ? customTheme.colors0xFFFFFF
                                        : customTheme.colors0xFFFFFF_50,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.tab.value = 1;
                                },
                                child: Text(
                                  controller.basePageString("phone_login"),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: FontDimens.fontSp18,
                                    color: controller.tab.value == 1
                                        ? customTheme.colors0xFFFFFF
                                        : customTheme.colors0xFFFFFF_50,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppDimens.h_6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.basePageString("country_area"),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: FontDimens.fontSp14,
                                  color: customTheme.colors0xFFFFFF,
                                ),
                              ),
                              InkWell(
                                // height: 10,
                                onTap: () {
                                  controller.areaCodePage();
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      controller.currentCode.value.name ?? "",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: FontDimens.fontSp14,
                                        color: customTheme.colors0xFFFFFF,
                                      ),
                                    ),
                                    const SizedBox(width: AppDimens.w_8),
                                    Image.asset(
                                      Assets.basePage.moreWhile.path,
                                      width: AppDimens.w_9,
                                      height: AppDimens.h_8,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: AppDimens.h_6),
                          LoginWidget.of().divider(),
                          const SizedBox(height: AppDimens.h_6),
                          field(
                            controller.phone,
                            "请输入手机号",
                            isNumber: true,
                            prefix: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  Assets.basePage.phoneWhilt.path,
                                  width: AppDimens.w_10,
                                  height: AppDimens.h_15,
                                ),
                                const SizedBox(width: AppDimens.w_5),
                                Text(
                                  controller.currentCode.value.areaCode,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: FontDimens.fontSp14,
                                    color: customTheme.colors0xFFFFFF,
                                  ),
                                ),
                                const SizedBox(width: AppDimens.w_5),
                                Container(
                                  width: 0.5,
                                  height: 22,
                                  decoration: BoxDecoration(
                                      color: customTheme.colors0xFFFFFF),
                                ),
                                const SizedBox(
                                  width: AppDimens.w_8,
                                ),
                              ],
                            ),
                          ),
                          LoginWidget.of().divider(),
                          const SizedBox(height: AppDimens.h_6),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                Assets.basePage.whilePwd.path,
                                width: AppDimens.w_10,
                                height: AppDimens.h_15,
                              ),
                              const SizedBox(width: AppDimens.w_5),
                              Expanded(
                                child: field(
                                  controller.tab.value == 0
                                      ? controller.password
                                      : controller.sms,
                                  controller.tab.value == 0
                                      ? controller.basePageString("请输入密码")
                                      : controller.basePageString("请输入短信验证码"),
                                  isNumber: controller.tab.value != 0,
                                  obscureText: controller.tab.value == 0,
                                ),
                              ),
                              Visibility(
                                  child: InkWell(
                                    onTap: () {
                                      controller.sendSms();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: AppDimens.w_6,
                                          vertical: AppDimens.h_2),
                                      decoration: BoxDecoration(
                                        color:
                                            controller.countdownTime.value < 61
                                                ? customTheme.colors0xE5E5E5
                                                : customTheme.colors0xAE6FFF,
                                        borderRadius: BorderRadius.circular(
                                            AppDimens.w_30),
                                      ),
                                      child: Text(
                                        controller.countdownTime.value < 61
                                            ? "${controller.countdownTime.value}s${controller.basePageString("后重发")}"
                                            : controller
                                                .basePageString("sms_get"),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: FontDimens.fontSp12,
                                          color:
                                              controller.countdownTime.value <
                                                      61
                                                  ? customTheme.colors0x000000
                                                  : customTheme.colors0xFFFFFF,
                                        ),
                                      ),
                                    ),
                                  ),
                                  visible: controller.tab.value == 1),
                            ],
                          ),
                          LoginWidget.of().divider(),
                          const SizedBox(height: AppDimens.h_6),
                          Visibility(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  isVideo
                                      ? const SizedBox()
                                      : LoginWidget.of().register(),
                                  LoginWidget.of().forgetPassword()
                                ],
                              ),
                              visible: controller.tab.value == 0),
                          const SizedBox(height: AppDimens.h_14),
                          LoginWidget.of().visitorLoginBtn(),
                          LoginWidget.of().loginBtn()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
        ));
  }

  TextField field(TextEditingController textController, String hintText,
      {bool obscureText = false, Widget? prefix, bool isNumber = false}) {
    return TextField(
      controller: textController,
      // maxLength: 15,
      style: TextStyle(
        color: controller.currentCustomThemeData().colors0xFFFFFF,
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
          color: controller.currentCustomThemeData().colors0xFFFFFF_40,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        // prefix: prefix,
        prefixIcon: prefix,
      ),
      obscureText: obscureText,
    );
  }
}
