import 'package:base/app_routes.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/provider/user_provider.dart';

enum ChangePwdPageType {
  setAccountPwd,
  updateAccountPwd,
  setPayPwd,
  updatePayPwd,
}

extension PageTypeHelper on ChangePwdPageType {
  String get pageTitle {
    switch (this) {
      case ChangePwdPageType.setAccountPwd:
        return '设置账户密码';
      case ChangePwdPageType.updateAccountPwd:
        return '修改账户密码';
      case ChangePwdPageType.setPayPwd:
        return '设置支付密码';
      case ChangePwdPageType.updatePayPwd:
        return '修改支付密码';
      default:
        return '未知类型';
    }
  }
}

class ChangePasswordController extends GetXBaseController {
  late final ChangePwdPageType pageType;
  late final TextEditingController textEditingController1;
  late final TextEditingController textEditingController2;

  /// 是否展示忘记密码
  bool get showForgetPwd =>
      pageType == ChangePwdPageType.updateAccountPwd ||
      pageType == ChangePwdPageType.updatePayPwd;

  String get hintText1 {
    switch (pageType) {
      case ChangePwdPageType.setAccountPwd:
      case ChangePwdPageType.setPayPwd:
        return '请设置密码（6-18位字符）';
      case ChangePwdPageType.updateAccountPwd:
      case ChangePwdPageType.updatePayPwd:
        return '请输入旧密码';
    }
  }

  String get hintText2 {
    switch (pageType) {
      case ChangePwdPageType.setAccountPwd:
      case ChangePwdPageType.setPayPwd:
        return '请再次确认密码';
      case ChangePwdPageType.updateAccountPwd:
      case ChangePwdPageType.updatePayPwd:
        return '请设置新密码（6-18位字符）';
    }
  }

  void clearTextField1() {
    textEditingController1.clear();
  }

  void clearTextField2() {
    textEditingController2.clear();
  }

  void onConfirm() async {
    final pwd1 = textEditingController1.text.trim();
    final pwd2 = textEditingController2.text.trim();

    switch (pageType) {
      case ChangePwdPageType.setAccountPwd:
        // 设置账号密码
        final valid = _checkSetPwd(pwd1, pwd2);
        if (!valid) return;
        _resetPassword(type: 1, password: pwd2, msg: '账号密码设置成功，请重新登录');
        break;
      case ChangePwdPageType.updateAccountPwd:
        // 更新账号密码
        final valid = _checkUpdatePwd(pwd1, pwd2);
        if (!valid) return;
        _resetPassword(
            type: 1, oldPassword: pwd1, password: pwd2, msg: '账号密码修改成功，请重新登录');
        break;
      case ChangePwdPageType.setPayPwd:
        // 设置支付密码
        final valid = _checkSetPwd(pwd1, pwd2);
        if (!valid) return;
        _resetPassword(type: 2, password: pwd2, msg: '支付密码设置成功');
        break;
      case ChangePwdPageType.updatePayPwd:
        // 更新支付密码
        final valid = _checkUpdatePwd(pwd1, pwd2);
        if (!valid) return;
        _resetPassword(
            type: 2, oldPassword: pwd1, password: pwd2, msg: '支付密码修改成功');
        break;
    }
  }

  /// 进入忘记密码页面
  void toForgetPwd() {
    if (pageType == ChangePwdPageType.updateAccountPwd) {
      //忘记账户密码
      Get.toNamed(
        AppRoutes.register,
        arguments: {
          "type": 2,
          "mobilePhone":
              UserManagerCache.shared.getUserDetail()?.mobilePhone ?? ""
        },
      );
    } else if (pageType == ChangePwdPageType.updatePayPwd) {
      // 忘记支付密码
      Get.toNamed(
        AppRoutes.register,
        arguments: {
          "type": 4,
          "mobilePhone":
              UserManagerCache.shared.getUserDetail()?.mobilePhone ?? ""
        },
      );
    }
  }

  @override
  void onInit() {
    pageType = Get.arguments as ChangePwdPageType;
    textEditingController1 = TextEditingController();
    textEditingController2 = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    textEditingController1.dispose();
    textEditingController2.dispose();
    super.onClose();
  }

  bool _checkSetPwd(String pwd1, String pwd2) {
    if (pwd1.isEmpty) {
      OLEasyLoading.showToast('请先输入密码');
      return false;
    }
    if (pwd2.isEmpty) {
      OLEasyLoading.showToast('请再次确认密码');
      return false;
    }
    if (pwd1 != pwd2) {
      OLEasyLoading.showToast('两次输入密码不一致');
      return false;
    }
    return true;
  }

  bool _checkUpdatePwd(String pwd1, String pwd2) {
    if (pwd1.isEmpty) {
      OLEasyLoading.showToast('请先输入旧密码');
      return false;
    }
    if (pwd2.isEmpty) {
      OLEasyLoading.showToast('请先输入新密码');
      return false;
    }
    if (pwd1 == pwd2) {
      OLEasyLoading.showToast('新密码不能和旧密码一样');
      return false;
    }
    return true;
  }

  /// 设置/更新账户/支付密码
  /// type	操作类型 1：登录业务，2：支付业务
  /// oldPassword	通过旧密码设置新密码时必填
  /// password	密码
  _resetPassword(
      {required int type,
      required String password,
      String oldPassword = "",
      String msg = ""}) async {
    Map<String, dynamic> params = {"type": type, "password": password};
    if (oldPassword.isNotEmpty) {
      params["oldPassword"] = oldPassword;
    }
    OLEasyLoading.showLoading('');
    UserProvider.resetPassword(params).then((value) {
      if (msg.isNotEmpty) {
        OLEasyLoading.showToast(msg);
      }
      if (type == 1) {
        Get.offAllNamed(AppRoutes.loginPage, arguments: 1);
      } else {
        Get.back();
      }
    }).whenComplete(() => OLEasyLoading.dismiss());
  }
}
