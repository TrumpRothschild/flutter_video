import 'dart:developer';

import 'package:base/assets.gen.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'online_service_controller.dart';

class OnlineServicePage extends GetView<OnlineServiceController> {
  const OnlineServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            log("返回");
            Get.back();
          },
          icon: Image.asset(
            Assets.basePage.backBlack.path,
            width: 10,
            height: 20,
          ),
        ),
        title: Text(
          controller.basePageString("在线客服"),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: FontDimens.fontSp16,
            color: controller.currentCustomThemeData().colors0x000000,
          ),
        ),
      ),
      body: Obx(
        () {
          if ((controller.online.value.context?.isEmpty ?? true) &&
              controller.url.isEmpty) {
            return Container();
          } else {
            return WebView(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController web) {
                if (controller.url.isNotEmpty) {
                  web.loadUrl(controller.url);
                } else {
                  web.loadUrl(controller.online.value.context ?? "");
                }
              },
            );
          }
        },
      ),
    );
  }
}
