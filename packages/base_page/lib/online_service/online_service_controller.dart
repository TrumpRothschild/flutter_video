import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:get/get.dart';
import 'package:services/api/common_apis.dart';
import 'package:services/models/res/login/online_service_model.dart';
import 'package:services/provider/common_provider.dart';

class OnlineServiceController extends GetXBaseController {
  String url = '';
  Rx<OnlineServiceModel> online = OnlineServiceModel().obs;

  @override
  void onInit() {
    url = Get.arguments as String? ?? '';
    Log.d(url);
    if (url.isEmpty) {
      queryAllCountry();
    }
    super.onInit();
  }

  queryAllCountry() async {
    CommonProvider.getOnlineService().then((value) {
      if (value != null) {
        online.value = value;
      }
    });
  }
}
