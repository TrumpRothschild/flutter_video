import 'package:base/app_routes.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:get/get.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ActivityCenterWebController extends GetXBaseController
    with GetTickerProviderStateMixin {
  String url = '';

  @override
  void onInit() {
    url = "${Get.arguments as String? ?? ''}?platform=flutter";
    super.onInit();
  }

  // js调用flutter方法
  JavascriptChannel jumpToRecharge() {
    return JavascriptChannel(
        name: "flutter",
        onMessageReceived: (JavascriptMessage message) {
          // 跳转到充值页面
          if (message.message.toString() == "2") {
            // 不需要判断，游客也可以充值
            // 判断是否为游客
            /*int? userType = UserManagerCache.shared.getUserDetail()?.userType ?? 0;
            if (userType == 1) {
              Get.toNamed(AppRoutes.loginPage);
              return;
            }*/
            Get.toNamed(AppRoutes.walletRoot,
                arguments: {"accountType": "2", "activity": "7"});
          }
    });
  }
}
