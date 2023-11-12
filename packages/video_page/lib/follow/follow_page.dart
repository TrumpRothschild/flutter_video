import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/screen.dart';
import 'package:base/translations/zh-Hans/zh_cn_video_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_page/components/TabBarIndicator.dart';
import 'package:video_page/follow/follow_controller.dart';

class FollowPage extends GetView<FollowController> {
  const FollowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: controller.currentCustomThemeData().colors0xFFFFFF,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          titleSpacing: 0,
          backgroundColor: controller.currentCustomThemeData().colors0xF8F8F8,
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
          title: Text(videoPageTranslations['follow'].toString(),
              style: TextStyle(
                  color: controller.currentCustomThemeData().colors0x000000,
                  fontSize: sp(32),
                  fontWeight: FontWeight.w600)),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: width(100),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                          child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                            videoPageTranslations['my'].toString() +
                                videoPageTranslations['follow'].toString(),
                            style: TextStyle(
                                color: controller
                                    .currentCustomThemeData()
                                    .colors0x7032FF,
                                fontSize: sp(28),
                                fontWeight: FontWeight.w400)),
                      ),
                      Container(
                        width: width(32),
                        height: width(4),
                        margin: EdgeInsets.only(top: width(6)),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xff6129FF),
                                  Color(0xffD96CFF)
                                ])),
                      )
                    ],
                  ))),
                  Expanded(
                      child: InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                          videoPageTranslations['my'].toString() +
                              videoPageTranslations['fans'].toString(),
                          style: TextStyle(
                              color: controller
                                  .currentCustomThemeData()
                                  .colors0x979797,
                              fontSize: sp(28),
                              fontWeight: FontWeight.w400)),
                    ),
                  ))
                ],
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: width(25)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: width(140),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: controller
                                    .currentCustomThemeData()
                                    .colors0xF4F4F4,
                                width: width(1)))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                                width: width(80),
                                height: width(80),
                                margin: EdgeInsets.only(right: width(16)),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(width(80)))),
                                child: Image.asset(Assets.videoPage.vAva.path,
                                    fit: BoxFit.cover)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: width(6)),
                                      child: Text(
                                        "老色批",
                                        style: TextStyle(
                                            color: controller
                                                .currentCustomThemeData()
                                                .colors0x000000,
                                            fontSize: sp(28)),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: width(10)),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width(5)),
                                      height: width(26),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(width(4))),
                                          color: controller
                                              .currentCustomThemeData()
                                              .colors0x7032FF),
                                      child: Text(
                                        "特约小伙伴",
                                        style: TextStyle(
                                            color: controller
                                                .currentCustomThemeData()
                                                .colors0xFFFFFF,
                                            fontSize: sp(18)),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: width(10)),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width(5)),
                                      height: width(26),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(width(4))),
                                          color: controller
                                              .currentCustomThemeData()
                                              .colors0xFF32F7),
                                      child: Text(
                                        "老司机",
                                        style: TextStyle(
                                            color: controller
                                                .currentCustomThemeData()
                                                .colors0xFFFFFF,
                                            fontSize: sp(18)),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "6826" +
                                      videoPageTranslations['fans'].toString() +
                                      " · 763" +
                                      videoPageTranslations['part'].toString() +
                                      videoPageTranslations['video'].toString(),
                                  style: TextStyle(
                                      color: controller
                                          .currentCustomThemeData()
                                          .colors0x979797,
                                      fontSize: sp(20)),
                                ),
                              ],
                            )
                          ],
                        ),
                        InkWell(
                          child: Container(
                            width: width(100),
                            height: width(40),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: controller
                                        .currentCustomThemeData()
                                        .colors0x7032FF,
                                    width: width(2)),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(width(40)))),
                            child: Text(
                              videoPageTranslations['cancel'].toString(),
                              style: TextStyle(
                                  color: controller
                                      .currentCustomThemeData()
                                      .colors0x7032FF,
                                  fontSize: sp(20)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: width(140),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: controller
                                    .currentCustomThemeData()
                                    .colors0xF4F4F4,
                                width: width(1)))),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                                width: width(80),
                                height: width(80),
                                margin: EdgeInsets.only(right: width(16)),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(width(80)))),
                                child: Image.asset(Assets.videoPage.vAva.path,
                                    fit: BoxFit.cover)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: width(6)),
                                      child: Text(
                                        "老色批",
                                        style: TextStyle(
                                            color: controller
                                                .currentCustomThemeData()
                                                .colors0x000000,
                                            fontSize: sp(28)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width(64),
                                      height: width(20),
                                      child: Image.asset(
                                        Assets.videoPage.vVipVipIcon.path,
                                        width: width(64),
                                        height: width(20),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "TA好像忘记说点什么了...",
                                  style: TextStyle(
                                      color: controller
                                          .currentCustomThemeData()
                                          .colors0xB1B1B1,
                                      fontSize: sp(20)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
          ],
        ));
  }
}
