import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/screen.dart';
import 'package:base/translations/zh-Hans/zh_cn_video_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_page/my_request/my_request_controller.dart';

class MyRequestPage extends GetView<MyRequestController> {
  const MyRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: controller.currentCustomThemeData().colors0xFFFFFF,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          titleSpacing: 0,
          leading: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Get.back();
            },
            icon: Image.asset(
              Assets.basePage.backBlack.path,
              width: 10,
              height: 20,
            ),
          ),
          title: SizedBox(
            child: Text(
              videoPageTranslations['my'].toString() +
                  videoPageTranslations['slicing'].toString() +
                  "/" +
                  videoPageTranslations['pushing'].toString(),
              style: TextStyle(
                  color: controller.currentCustomThemeData().colors0x000000,
                  fontSize: sp(32),
                  fontWeight: FontWeight.w600),
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        body: Container());
  }
}
