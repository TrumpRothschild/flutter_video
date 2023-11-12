import 'package:base/app_routes.dart';
import 'package:base/bases/get_base_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'game_web_controller.dart';
import 'widgets/circle_menu/draggable_circular_menu.dart';

/// GameWeb
class GameWebPage extends GetBaseView<GameWebController> {
  const GameWebPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) => WillPopScope(
          onWillPop: () async {
            controller.quitGame();
            return true;
          },
          child: DraggableCircularMenu(
            items: [
              CircularMenuItem(
                menuWidget: _buildMenuItem(name: '充值'),
                onTap: () => Get.toNamed(AppRoutes.walletRoot),
              ),
              CircularMenuItem(
                menuWidget: _buildMenuItem(name: '刷新'),
                onTap: () => {controller.webViewController.reload()},
              ),
              CircularMenuItem(
                  menuWidget: _buildMenuItem(name: '退出'),
                  onTap: controller.quitGame),
            ],
            backgroundWidget: Scaffold(
              body: Stack(
                children: [
                  WebView(
                    onWebViewCreated: (WebViewController webViewC) {
                      controller.webViewController = webViewC;
                    },
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: state?.data,
                    onPageFinished: (String url) {},
                    onPageStarted: (String url) {},
                    onProgress: controller.onProgress,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildMenuItem({
    required String name,
  }) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: CircleBorder(side: BorderSide(color: Colors.black, width: 2)),
      ),
      child: RotatedBox(
        quarterTurns: 1,
        child: Text(
          name,
          style: const TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
    );
  }
}
