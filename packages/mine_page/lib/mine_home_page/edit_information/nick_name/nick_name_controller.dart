import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/api/common_apis.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/user/user_detail_model.dart';

class NickNameController extends GetXBaseController {
  late String nickname;
  late final TextEditingController editingController;

  void onSave() async {
    final newNickname = editingController.text.trim();
    if (newNickname.isEmpty) {
      OLEasyLoading.showToast('请先输入昵称');
      return;
    }

    // 如果相同昵称，不需要请求接口，默认成功
    bool succ = true;
    if (newNickname != nickname) {
      succ = await _updateNickName(newNickname);
    }
    if (succ) {
      UserDetailModel? userDetail = UserManagerCache.shared.getUserDetail();
      if (userDetail != null) {
        UserManagerCache.shared.cacheUserDetail(
            (userDetail..nickName = newNickname).toJson());
        UserManagerCache.shared
            .setUserDetail(userDetail..nickName = newNickname);
      }
      Get.back(result: newNickname);
    }
  }

  Future<bool> _updateNickName(String nickName) async {
    try {
      OLEasyLoading.showLoading('');
      BaseResponse res = await CommonApis.of().updateNickName(nickName);
      OLEasyLoading.dismiss();
      return res.code == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  void onInit() {
    nickname = Get.arguments as String? ?? '';
    editingController = TextEditingController();
    if (nickname.isNotEmpty) {}
    editingController.text = nickname;
    super.onInit();
  }

  @override
  void onClose() {
    editingController.dispose();
    super.onClose();
  }
}
