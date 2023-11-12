import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:get/get.dart';
import 'package:services/api/common_apis.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/user/user_level_bean.dart';

class MyGradeController extends GetXBaseController {
  UserLevelBean get userLevelBean => _userLevelBean.value;
  final _userLevelBean = UserLevelBean().obs;

  @override
  void onReady() {
    _getUserLevelInfo();
    super.onReady();
  }

  _getUserLevelInfo() async {
    try {
      OLEasyLoading.showLoading('');
      BaseResponse res = await CommonApis.of().getUserLevelInfo();
      if (GetUtils.isNull(res.data) == true) {
        OLEasyLoading.dismiss();
        return;
      }

      final dataJson = res.data as Map<String, dynamic>;
      _userLevelBean.value = UserLevelBean.fromJson(dataJson);
      OLEasyLoading.dismiss();
    } catch (e) {
      OLEasyLoading.dismiss();
    }
  }
}
