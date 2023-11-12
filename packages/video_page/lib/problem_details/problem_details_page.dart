import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/screen.dart';
import 'package:base/translations/zh-Hans/zh_cn_video_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_page/problem_details/problem_details_controller.dart';

class ProblemDetailsPage extends GetView<ProblemDetailsController> {
  const ProblemDetailsPage({Key? key}) : super(key: key);

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
          title: Text(videoPageTranslations['problem_details'].toString(),
              style: TextStyle(
                  color: controller.currentCustomThemeData().colors0x000000,
                  fontSize: sp(32),
                  fontWeight: FontWeight.w600)),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: width(20),
                color: controller.currentCustomThemeData().colors0xF3F3F3,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: width(25)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: width(124),
                      alignment: Alignment.centerLeft,
                      child: Text(
                          videoPageTranslations[
                                  'how_to_obtain_unlimited_viewing_times']
                              .toString(),
                          style:
                              TextStyle(
                                  color: controller
                                      .currentCustomThemeData()
                                      .colors0x262626,
                                  fontSize: sp(36),
                                  fontWeight: FontWeight.w600)),
                    ),
                    Divider(
                      height: width(2),
                      color: controller.currentCustomThemeData().colors0xF4F4F4,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: width(24)),
                      child: Text(
                          videoPageTranslations['recharged_vip'].toString(),
                          style: TextStyle(
                              color: controller
                                  .currentCustomThemeData()
                                  .colors0x000000,
                              fontSize: sp(28),
                              fontWeight: FontWeight.w400)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Container(
                            margin: EdgeInsets.only(top: width(80)),
                            width: width(360),
                            height: width(70),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(width(40))),
                                gradient: const LinearGradient(colors: [
                                  Color(0xff6129FF),
                                  Color(0xffD96CFF)
                                ], stops: [
                                  0.03,
                                  0.95
                                ])),
                            child: Text(
                                videoPageTranslations['go_to_buy'].toString(),
                                style: TextStyle(
                                    color: controller
                                        .currentCustomThemeData()
                                        .colors0xFFFFFF,
                                    fontSize: sp(32),
                                    fontWeight: FontWeight.w400)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
