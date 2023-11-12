import 'package:base/app_config.dart';
import 'package:base/app_routes.dart';
import 'package:base/assets.gen.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

/// 登录模块组件
class LoginWidget {
  static LoginWidget of() => LoginWidget();

  final LoginController _controller = Get.find<LoginController>();

  /// 登录背景
  Widget loginBg() {
    return Image.asset(
      AppConfig.isVideo
          ? Assets.basePage.icVideoLoginBg.path
          : Assets.basePage.icLiveLoginBg.path,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }

  /// 分割线
  Widget divider() {
    return const Divider(
      height: 0.5,
      color: Colors.white,
    );
  }

  /// 注册组件
  Widget register() {
    return InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.register, arguments: {
            "type": 1,
          });
        },
        child: Text(
          _controller.basePageString("register"),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: FontDimens.fontSp14,
            color: Colors.white,
          ),
        ));
  }

  /// 忘记密码组件
  Widget forgetPassword() {
    return InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.register, arguments: {
            "type": 2,
          });
        },
        child: Text(
          _controller.basePageString("forget_pwd"),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: FontDimens.fontSp14,
            color: Colors.white,
          ),
        ));
  }

  /// 游客登录组件
  Widget visitorLoginBtn() {
    return InkWell(
      onTap: () {
        _controller.visitorLogin();
      },
      child: Text(
        _controller.basePageString("visitor_login"),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: FontDimens.fontSp16,
          color: _controller.currentCustomThemeData().colors0xFFFFFF_70,
        ),
      ),
    );
  }

  /// 登录
  Widget loginBtn() {
    return Obx(() {
      return InkWell(
        onTap: () {
          _controller.login();
        },
        child: Container(
          margin: const EdgeInsets.only(top: AppDimens.h_8),
          alignment: Alignment.center,
          width: AppDimens.w_150,
          height: AppDimens.h_34,
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: ExactAssetImage(
                  Assets.basePage.loginBunBg.path,
                ),
              ),
              borderRadius: BorderRadius.circular(AppDimens.w_20)),
          child: Text(
            _controller.tab.value == 0
                ? _controller.basePageString("login")
                : _controller.basePageString("login_register"),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: FontDimens.fontSp16,
              color: Colors.white,
            ),
          ),
        ),
      );
    });
  }
}
