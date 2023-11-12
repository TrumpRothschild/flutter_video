import 'package:base/app_routes.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'activity_center_web_controller.dart';

class ActivityCenterWeb extends GetView<ActivityCenterWebController> {
  ActivityCenterWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var verticalGestures = Factory<VerticalDragGestureRecognizer>(
            () => VerticalDragGestureRecognizer());
    var gestureSet = {verticalGestures};
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: controller.currentCustomThemeData().colors0x000000),
        centerTitle: true,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          "活动详情",
          style: TextStyle(
              color: controller.currentCustomThemeData().colors0x000000,
              fontSize: 16),
        ),
      ),
      body: WebView(
          gestureRecognizers: gestureSet,
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: controller.url,
          onWebViewCreated: (WebViewController web) {
            // web.loadUrl(controller.url);
          },
          javascriptChannels: <JavascriptChannel>{
            controller.jumpToRecharge(),
          }),
    );
  }
}
