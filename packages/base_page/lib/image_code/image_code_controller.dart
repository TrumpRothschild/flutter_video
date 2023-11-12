import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:get/get.dart';
import 'package:services/models/res/login/image_code_model.dart';
import 'package:services/provider/common_provider.dart';

/// 登录controller
class ImageCodeController extends GetXBaseController {
  Rx<ImageCodeModel> imageCodeData = ImageCodeModel().obs;

  @override
  void onInit() {
    randCode();
    super.onInit();
  }

  /// 获取图片验证码
  randCode() async {
    CommonProvider.randCode(1).then((value) {
      if (value != null) {
        imageCodeData.value = value;
      } else {
        OLEasyLoading.showToast(basePageString("验证码获取失败,请重试"));
        Get.back();
      }
    });
  }
}
