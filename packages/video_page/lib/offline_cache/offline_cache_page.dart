import 'dart:math';

import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/screen.dart';
import 'package:base/translations/zh-Hans/zh_cn_video_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:video_page/offline_cache/offline_cache_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';




class OfflineCachePage extends GetView<OfflineCacheController> {
  const OfflineCachePage({Key? key}) : super(key: key);


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
          title: Text(videoPageTranslations['offline_cache'].toString(),
              style: TextStyle(
                  color: controller.currentCustomThemeData().colors0x000000,
                  fontSize: sp(32),
                  fontWeight: FontWeight.w600)),
          actions: [
            Obx(() => InkWell(
                onTap: () {
                  controller.changeEdit();
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: width(30)),
                  child: Text(
                      controller.isEdit.value
                          ? videoPageTranslations['cancel'].toString()
                          : videoPageTranslations['edit'].toString(),
                      style: TextStyle(
                          color: controller
                              .currentCustomThemeData()
                              .colors0x262626,
                          fontSize: sp(32),
                          fontWeight: FontWeight.w600)),
                )))
          ],
        ),
        body: GetX<OfflineCacheController>(
            init: controller,
            builder: (_) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: width(100),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Expanded(
                          child: InkWell(
                            onTap: () {
                              controller.changeType(1);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                  videoPageTranslations['caching'].toString(),
                                  style: TextStyle(
                                      color: controller.currentType.value == 1
                                          ? controller
                                          .currentCustomThemeData()
                                          .colors0x7032FF
                                          : controller
                                          .currentCustomThemeData()
                                          .colors0x000000,
                                      fontSize: sp(28),
                                      fontWeight: FontWeight.w400)),
                            ),
                          )),
                      Expanded(
                          child: InkWell(
                            onTap: () {
                              controller.changeType(2);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                  videoPageTranslations['cached'].toString(),
                                  style: TextStyle(
                                      color: controller.currentType.value == 2
                                          ? controller
                                          .currentCustomThemeData()
                                          .colors0x7032FF
                                          : controller
                                          .currentCustomThemeData()
                                          .colors0x000000,
                                      fontSize: sp(28),
                                      fontWeight: FontWeight.w400)),
                            ),
                          ))
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: width(20)),
                      margin: EdgeInsets.only(bottom: width(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          controller.currentType.value == 1
                              ? Container(
                            margin: EdgeInsets.only(bottom: width(20)),
                            child: Row(
                              children: [
                                controller.isEdit.value
                                    ? Container(
                                    margin: EdgeInsets.only(
                                        right: width(24)),
                                    width: width(40),
                                    height: width(40),
                                    child: Image.asset(
                                        Assets.videoPage.vUn.path,
                                        fit: BoxFit.cover))
                                    : Container(),
                                Container(
                                  width: width(340),
                                  height: width(192),
                                  margin:
                                  EdgeInsets.only(right: width(15)),
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(width(10)))),
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        width: width(340),
                                        height: width(192),
                                        child: Image.asset(
                                          Assets.videoPage.vImg.path,
                                          width: width(340),
                                          height: width(192),
                                        ),
                                      ),
                                      Positioned(
                                        left: width(140),
                                        top: width(66),
                                        child: Image.asset(
                                          Assets.videoPage.vPlayIcon.path,
                                          width: width(60),
                                          height: width(60),
                                        ),
                                      ),
                                      Positioned(
                                        right: width(6),
                                        bottom: width(4),
                                        child: Text('01:56:20',
                                            style: TextStyle(
                                                color: controller
                                                    .currentCustomThemeData()
                                                    .colors0xFFFFFF,
                                                fontSize: sp(20),
                                                fontWeight:
                                                FontWeight.w400)),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: width(192),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: width(14)),
                                          child: Text(
                                              '名字可以很长很长很长很长很长很长很长很长',
                                              style: TextStyle(
                                                  color: controller
                                                      .currentCustomThemeData()
                                                      .colors0x000000,
                                                  fontSize: sp(24),
                                                  fontWeight:
                                                  FontWeight.w400)),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  bottom: width(6)),
                                              alignment:
                                              Alignment.centerRight,
                                              child: Text('1.3MB/s',
                                                  style: TextStyle(
                                                      color: controller
                                                          .currentCustomThemeData()
                                                          .colors0x000000,
                                                      fontSize: sp(24),
                                                      fontWeight:
                                                      FontWeight
                                                          .w400)),
                                            ),
                                            Container(
                                              clipBehavior: Clip.hardEdge,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(
                                                          width(4)))),
                                              child:
                                              LinearProgressIndicator(
                                                value: 0.4,
                                                backgroundColor: controller
                                                    .currentCustomThemeData()
                                                    .colors0xD9D9D9, // 背景色为黑色
                                                valueColor: AlwaysStoppedAnimation<
                                                    Color>(
                                                    controller
                                                        .currentCustomThemeData()
                                                        .colors0x7032FF), // 进度条颜色为粉色
                                              ),
                                            ),
                                            Container(
                                                padding: EdgeInsets.only(
                                                    top: width(6)),
                                                alignment:
                                                Alignment.centerRight,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .end,
                                                  children: [
                                                    Text('31.5 MB /',
                                                        style: TextStyle(
                                                            color: controller
                                                                .currentCustomThemeData()
                                                                .colors0x000000,
                                                            fontSize:
                                                            sp(24),
                                                            fontWeight:
                                                            FontWeight
                                                                .w400)),
                                                    Text('63 MB',
                                                        style: TextStyle(
                                                            color: controller
                                                                .currentCustomThemeData()
                                                                .colors0x979797,
                                                            fontSize:
                                                            sp(24),
                                                            fontWeight:
                                                            FontWeight
                                                                .w400)),
                                                  ],
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                              : Container(
                            margin: EdgeInsets.only(bottom: width(20)),
                            child: Row(
                              // child: controller.isSelected.value ? Image.asset(
                              //     Assets.videoPage.vUn.path,
                              //     fit: BoxFit.cover) : Image.asset(
                              //     Assets.videoPage.vSelect.path,
                              //     fit: BoxFit.cover),
                              children: [
                                controller.isEdit.value ?
                                GestureDetector(
                                    onTap: (){
                                      controller.isSelected.value = true;
                                      // controller.isSelected.value = !controller.isSelected.value;
                                      // if(!controller.isSelected.value) {
                                      //   controller.isSelected.value = true;
                                      // } else {
                                      //   controller.isSelected.value = false;
                                      // }
                                      controller.update();
                                    },
                                    child:  Container(
                                        margin: EdgeInsets.only(
                                            right: width(24)),
                                        width: width(40),
                                        height: width(40),
                                        child: Image.asset(Assets.videoPage.vSelect.path, fit: BoxFit.cover))
                                ) : Container(),
                                Container(
                                  width: width(340),
                                  height: width(192),
                                  margin:
                                  EdgeInsets.only(right: width(15)),
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(width(10)))),
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        width: width(340),
                                        height: width(192),
                                        child: Image.asset(
                                          Assets.videoPage.vImg.path,
                                          width: width(340),
                                          height: width(192),
                                        ),
                                      ),
                                      Positioned(
                                        left: width(140),
                                        top: width(66),
                                        child: Image.asset(
                                          Assets.videoPage.vPlayIcon.path,
                                          width: width(60),
                                          height: width(60),
                                        ),
                                      ),
                                      Positioned(
                                        right: width(6),
                                        bottom: width(4),
                                        child: Text('01:56:20',
                                            style: TextStyle(
                                                color: controller
                                                    .currentCustomThemeData()
                                                    .colors0xFFFFFF,
                                                fontSize: sp(20),
                                                fontWeight:
                                                FontWeight.w400)),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: width(192),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: width(14)),
                                          child: Text(
                                              '名字可以很长很长很长很长很长很长很长很长',
                                              style: TextStyle(
                                                  color: controller
                                                      .currentCustomThemeData()
                                                      .colors0x000000,
                                                  fontSize: sp(24),
                                                  fontWeight:
                                                  FontWeight.w400)),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text('63 MB | ',
                                                    style: TextStyle(
                                                        color: controller
                                                            .currentCustomThemeData()
                                                            .colors0x000000,
                                                        fontSize: sp(24),
                                                        fontWeight:
                                                        FontWeight
                                                            .w400)),
                                                Text(
                                                    videoPageTranslations[
                                                    'not_watched']
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: controller
                                                            .currentCustomThemeData()
                                                            .colors0xFF9900,
                                                        fontSize: sp(24),
                                                        fontWeight:
                                                        FontWeight
                                                            .w400)),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
                controller.isEdit.value
                    ? Container(
                  height: width(108),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: controller
                                  .currentCustomThemeData()
                                  .colors0x000000,
                              width: width(1)))),
                  child: Row(
                    children: [
                      Expanded(
                          child: InkWell(
                            onTap: () {
                              controller.selectAll();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                  controller.allChooseFlag.value
                                      ? videoPageTranslations[
                                  'cancel_all']
                                      .toString()
                                      : videoPageTranslations[
                                  'select_all']
                                      .toString(),
                                  style: TextStyle(
                                      color: controller
                                          .currentCustomThemeData()
                                          .colors0x000000,
                                      fontSize: sp(32),
                                      fontWeight: FontWeight.w400)),
                            ),
                          )),
                      Container(
                        width: width(1),
                        height: width(44),
                        color: controller
                            .currentCustomThemeData()
                            .colors0x000000,
                      ),
                      Expanded(
                          child: InkWell(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                  controller.videoIds.isNotEmpty
                                      ? videoPageTranslations['delete']
                                      .toString() +
                                      '(${controller.videoIds.length.toString()})'
                                      : videoPageTranslations['delete']
                                      .toString(),
                                  style: TextStyle(
                                      color: controller
                                          .videoIds.isNotEmpty
                                          ? controller
                                          .currentCustomThemeData()
                                          .colors0xF82D2D
                                          : controller
                                          .currentCustomThemeData()
                                          .colors0xB6B6B6,
                                      fontSize: sp(32),
                                      fontWeight: FontWeight.w400)),
                            ),
                          )),
                    ],
                  ),
                )
                    : Container(),
                Container(
                  height: width(80),
                  alignment: Alignment.center,
                  color: controller.currentCustomThemeData().colors0x979797,
                  child: Text(
                      videoPageTranslations['cache_occupancy'].toString() +
                          '63 MB/ ' +
                          videoPageTranslations['system_remaining_space']
                              .toString() +
                          '114 GB',
                      style: TextStyle(
                          color: controller
                              .currentCustomThemeData()
                              .colors0xFFFFFF,
                          fontSize: sp(28),
                          fontWeight: FontWeight.w400)),
                ),
              ],
            )));
  }
}
