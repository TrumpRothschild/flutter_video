import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/api/common_apis.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/user/user_detail_model.dart';

class SignController extends GetXBaseController {
  late String sign;
  late final TextEditingController editingController;

  int get length => _length.value;
  final _length = 0.obs;

  void onSave() async {
    final newSign = editingController.text.trim();
    if (newSign.isEmpty) {
      OLEasyLoading.showToast('请先输入签名');
      return;
    }
    // 如果相同昵称，不需要请求接口，默认成功
    bool succ = true;
    if (newSign != sign) {
      succ = await _updateSignature(newSign);
    }
    if (succ) {
      UserDetailModel? userDetail = UserManagerCache.shared.getUserDetail();
      if (userDetail != null) {
        UserManagerCache.shared.cacheUserDetail(
            (userDetail..personalSignature = newSign).toJson());
        UserManagerCache.shared
            .setUserDetail(userDetail..personalSignature = newSign);
      }
      Get.back(result: newSign);
    }
  }

  Future<bool> _updateSignature(String sign) async {
    try {
      OLEasyLoading.showLoading('');
      BaseResponse res = await CommonApis.of().updateSignature(sign);
      OLEasyLoading.dismiss();
      return res.code == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  void onInit() {
    sign = Get.arguments as String? ?? '';
    editingController = TextEditingController()
      ..addListener(() {
        _length.value = editingController.text.characters.length;
      });
    if (sign.isNotEmpty) {}
    editingController.text = sign;
    super.onInit();
  }

  @override
  void onClose() {
    editingController.dispose();
    super.onClose();
  }
}
