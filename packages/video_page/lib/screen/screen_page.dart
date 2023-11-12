// import 'dart:ffi';

import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/screen.dart';
import 'package:base/commons/widgets/ol_appbar_backbtn_widget.dart';
import 'package:base/commons/widgets/ol_appbar_title_widget.dart';
import 'package:base/commons/widgets/ol_blank_view.dart';
import 'package:base/translations/zh-Hans/zh_cn_video_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';
import 'package:services/models/res/video/tag_model.dart';
import 'package:services/models/res/video/video_page_list_model.dart';
import 'package:video_page/components/card_item/card_item_page.dart';
import 'package:video_page/components/floatBtn.dart';
import 'package:video_page/screen/screen_controller.dart';
import 'package:extended_wrap/extended_wrap.dart';
import 'package:video_page/video_utils.dart';

class ScreenPage extends GetView<ScreenController> {
  const ScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: controller.currentCustomThemeData().colors0xFFFFFF,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        titleSpacing: 0,
        leading: AppBarBackButton(),
        title: AppBarCenterTitle(title: "screen", controller: controller),
      ),
      body: GetX<ScreenController>(
          init: controller,
          builder: (_) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      child: SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: true,
                          header: WaterDropHeader(
                            refresh: const CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation(Color(0xff999999))),
                            complete: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.done,
                                  color: Colors.grey,
                                  size: sp(30),
                                ),
                                Container(width: 30.0),
                                Text("加载完成",
                                    style: TextStyle(
                                        fontSize: sp(28),
                                        color: const Color(0xff999999)))
                              ],
                            ),
                          ),
                          footer: CustomFooter(
                            builder: (BuildContext context, LoadStatus? mode) {
                              Widget body;
                              if (mode == LoadStatus.idle) {
                                body = Text(
                                  videoPageTranslations['up_loading_more'].toString(),
                                  style: TextStyle(
                                      color: const Color(0xff999999),
                                      fontSize: sp(28)),
                                );
                              } else if (mode == LoadStatus.loading) {
                                body = const CupertinoActivityIndicator();
                              } else if (mode == LoadStatus.failed) {
                                body = Text(
                                  "加载失败，点击重试",
                                  style: TextStyle(
                                      color: const Color(0xff999999),
                                      fontSize: sp(28)),
                                );
                              } else if (mode == LoadStatus.canLoading) {
                                body = Text(videoPageTranslations['release_loading_more'].toString(),
                                    style: TextStyle(
                                        color: const Color(0xff999999),
                                        fontSize: sp(28)));
                              } else {
                                body = Text(
                                  "暂无更多数据",
                                  style: TextStyle(
                                      color: const Color(0xff999999),
                                      fontSize: sp(28)),
                                );
                              }
                              return SizedBox(
                                height: 55.0,
                                child: Center(child: body),
                              );
                            },
                          ),
                          controller: controller.refreshController,
                          onRefresh: () {
                            controller.getVideo(1);
                          },
                          onLoading: () {
                            controller.getVideo(controller.page.value + 1);
                          },
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: width(20)),
                                  margin: EdgeInsets.only(bottom: width(8)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: width(44),
                                        margin:
                                            EdgeInsets.only(bottom: width(26)),
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                controller.changeRegin(-1);
                                              },
                                              child: Container(
                                                height: width(44),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width(14)),
                                                margin: EdgeInsets.only(
                                                    right: width(26)),
                                                alignment: Alignment.center,
                                                decoration: controller
                                                            .region.value ==
                                                        0
                                                    ? BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    width(40))),
                                                        color: controller
                                                            .currentCustomThemeData()
                                                            .colors0xEFDFFF)
                                                    : const BoxDecoration(),
                                                child: Text(
                                                  "全部地区",
                                                  style: TextStyle(
                                                      color: controller.region
                                                                  .value ==
                                                              0
                                                          ? controller
                                                              .currentCustomThemeData()
                                                              .colors0x8E1EFF
                                                          : controller
                                                              .currentCustomThemeData()
                                                              .colors0x979797,
                                                      fontSize: sp(25)),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: <Widget>[
                                                ...controller.regionList
                                                    .asMap()
                                                    .keys
                                                    .map((element) => InkWell(
                                                          onTap: () {
                                                            controller
                                                                .changeRegin(
                                                                    element);
                                                          },
                                                          child: Container(
                                                            // width: width(124),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        width(
                                                                            14)),
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: width(
                                                                        20)),
                                                            alignment: Alignment
                                                                .center,
                                                            decoration: controller
                                                                        .region
                                                                        .value ==
                                                                    element + 1
                                                                ? BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(width(
                                                                            40))),
                                                                    color: controller
                                                                        .currentCustomThemeData()
                                                                        .colors0xEFDFFF)
                                                                : const BoxDecoration(),
                                                            child: Text(
                                                              controller
                                                                  .regionList[
                                                                      element]
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: controller
                                                                              .region
                                                                              .value ==
                                                                          element +
                                                                              1
                                                                      ? controller
                                                                          .currentCustomThemeData()
                                                                          .colors0x8E1EFF
                                                                      : controller
                                                                          .currentCustomThemeData()
                                                                          .colors0x979797,
                                                                  fontSize:
                                                                      sp(25)),
                                                            ),
                                                          ),
                                                        ))
                                              ],
                                            )),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: width(44),
                                        margin:
                                            EdgeInsets.only(bottom: width(26)),
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                controller.changeMosaic(0);
                                              },
                                              child: Container(
                                                height: width(44),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width(14)),
                                                margin: EdgeInsets.only(
                                                    right: width(26)),
                                                alignment: Alignment.center,
                                                decoration: controller
                                                            .mosaicFlag.value ==
                                                        0
                                                    ? BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    width(40))),
                                                        color: controller
                                                            .currentCustomThemeData()
                                                            .colors0xEFDFFF)
                                                    : const BoxDecoration(),
                                                child: Text(
                                                  "有码无码",
                                                  style: TextStyle(
                                                      color: controller
                                                                  .mosaicFlag
                                                                  .value ==
                                                              0
                                                          ? controller
                                                              .currentCustomThemeData()
                                                              .colors0x8E1EFF
                                                          : controller
                                                              .currentCustomThemeData()
                                                              .colors0x979797,
                                                      fontSize: sp(25)),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: <Widget>[
                                                ...controller.mosaicFlagList
                                                    .asMap()
                                                    .keys
                                                    .map((element) {
                                                  return InkWell(
                                                    onTap: () {
                                                      controller.changeMosaic(
                                                          element+1);
                                                    },
                                                    child: Container(
                                                      // width: width(124),
                                                      margin: EdgeInsets.only(
                                                          right: width(20)),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  width(14)),
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: controller
                                                          .mosaicFlag
                                                          .value ==
                                                          element + 1
                                                          ? BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          width(
                                                                              40))),
                                                              color: controller
                                                                  .currentCustomThemeData()
                                                                  .colors0xEFDFFF)
                                                          : const BoxDecoration(),
                                                      child: Text(
                                                        controller
                                                            .mosaicFlagList[
                                                                element]
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: controller
                                                                .mosaicFlag
                                                                .value ==
                                                                element + 1
                                                                ? controller
                                                                    .currentCustomThemeData()
                                                                    .colors0x8E1EFF
                                                                : controller
                                                                    .currentCustomThemeData()
                                                                    .colors0x979797,
                                                            fontSize: sp(25)),
                                                      ),
                                                    ),
                                                  );
                                                })
                                              ],
                                            )),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: width(44),
                                        margin:
                                            EdgeInsets.only(bottom: width(26)),
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                controller.changeSubtitle(0);
                                              },
                                              child: Container(
                                                height: width(44),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width(14)),
                                                margin: EdgeInsets.only(
                                                    right: width(20)),
                                                alignment: Alignment.center,
                                                decoration: controller
                                                            .subtitleFlag
                                                            .value ==
                                                        0
                                                    ? BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    width(40))),
                                                        color: controller
                                                            .currentCustomThemeData()
                                                            .colors0xEFDFFF)
                                                    : const BoxDecoration(),
                                                child: Text(
                                                  "全部字幕",
                                                  style: TextStyle(
                                                      color: controller
                                                                  .subtitleFlag
                                                                  .value ==
                                                              0
                                                          ? controller
                                                              .currentCustomThemeData()
                                                              .colors0x8E1EFF
                                                          : controller
                                                              .currentCustomThemeData()
                                                              .colors0x979797,
                                                      fontSize: sp(25)),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: <Widget>[
                                                ...controller.subtitleFlagList
                                                    .asMap()
                                                    .keys
                                                    .map((element) => InkWell(
                                                          onTap: () {
                                                            controller
                                                                .changeSubtitle(
                                                                    element+1);
                                                          },
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: width(
                                                                        26)),
                                                            // width: width(124),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        width(
                                                                            14)),
                                                            alignment: Alignment
                                                                .center,
                                                            decoration: controller
                                                                        .subtitleFlag
                                                                        .value ==
                                                                    element+1
                                                                ? BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(width(
                                                                            40))),
                                                                    color: controller
                                                                        .currentCustomThemeData()
                                                                        .colors0xEFDFFF)
                                                                : const BoxDecoration(),
                                                            child: Text(
                                                              controller
                                                                  .subtitleFlagList[
                                                                      element]
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: controller
                                                                              .subtitleFlag
                                                                              .value ==
                                                                          element+1
                                                                      ? controller
                                                                          .currentCustomThemeData()
                                                                          .colors0x8E1EFF
                                                                      : controller
                                                                          .currentCustomThemeData()
                                                                          .colors0x979797,
                                                                  fontSize:
                                                                      sp(25)),
                                                            ),
                                                          ),
                                                        ))
                                              ],
                                            )),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: width(44),
                                        margin:
                                            EdgeInsets.only(bottom: width(16)),
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                controller.changeDuration(-1);
                                              },
                                              child: Container(
                                                height: width(44),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width(14)),
                                                margin: EdgeInsets.only(
                                                    right: width(20)),
                                                alignment: Alignment.center,
                                                decoration: controller
                                                            .durationType
                                                            .value ==
                                                        0
                                                    ? BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    width(40))),
                                                        color: controller
                                                            .currentCustomThemeData()
                                                            .colors0xEFDFFF)
                                                    : const BoxDecoration(),
                                                child: Text(
                                                  "全部时长",
                                                  style: TextStyle(
                                                      color: controller
                                                                  .durationType
                                                                  .value ==
                                                              0
                                                          ? controller
                                                              .currentCustomThemeData()
                                                              .colors0x8E1EFF
                                                          : controller
                                                              .currentCustomThemeData()
                                                              .colors0x979797,
                                                      fontSize: sp(25)),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: <Widget>[
                                                ...controller.durationTypeList
                                                    .asMap()
                                                    .keys
                                                    .map((element) => InkWell(
                                                          onTap: () {
                                                            controller
                                                                .changeDuration(
                                                                    element);
                                                          },
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: width(
                                                                        26)),
                                                            // width: width(124),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        width(
                                                                            14)),
                                                            alignment: Alignment
                                                                .center,
                                                            decoration: controller
                                                                        .durationType
                                                                        .value ==
                                                                    element + 1
                                                                ? BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(width(
                                                                            40))),
                                                                    color: controller
                                                                        .currentCustomThemeData()
                                                                        .colors0xEFDFFF)
                                                                : const BoxDecoration(),
                                                            child: Text(
                                                              controller
                                                                  .durationTypeList[
                                                                      element]
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: controller
                                                                              .durationType
                                                                              .value ==
                                                                          element +
                                                                              1
                                                                      ? controller
                                                                          .currentCustomThemeData()
                                                                          .colors0x8E1EFF
                                                                      : controller
                                                                          .currentCustomThemeData()
                                                                          .colors0x979797,
                                                                  fontSize:
                                                                      sp(25)),
                                                            ),
                                                          ),
                                                        ))
                                              ],
                                            )),
                                          ],
                                        ),
                                      ),
                                      /*Container(
                                        height: width(44),
                                        margin:
                                            EdgeInsets.only(bottom: width(28)),
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                controller.changePriceType(-1);
                                              },
                                              child: Container(
                                                height: width(44),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width(14)),
                                                margin: EdgeInsets.only(
                                                    right: width(26)),
                                                alignment: Alignment.center,
                                                decoration: controller
                                                            .priceType.value ==
                                                        0
                                                    ? BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    width(40))),
                                                        color: controller
                                                            .currentCustomThemeData()
                                                            .colors0xEFDFFF)
                                                    : const BoxDecoration(),
                                                child: Text(
                                                  "全部价格",
                                                  style: TextStyle(
                                                      height: 1.0,
                                                      color: controller
                                                                  .priceType
                                                                  .value ==
                                                              0
                                                          ? controller
                                                              .currentCustomThemeData()
                                                              .colors0x8E1EFF
                                                          : controller
                                                              .currentCustomThemeData()
                                                              .colors0x979797,
                                                      fontSize: sp(24)),
                                                ),
                                              ),
                                            ),
                                            /*Expanded(
                                                child: ListView(
                                              scrollDirection: Axis.horizontal,
                                              children: <Widget>[
                                                ...controller.priceTypeList
                                                    .asMap()
                                                    .keys
                                                    .map((element) => InkWell(
                                                          onTap: () {
                                                            controller
                                                                .changePriceType(
                                                                    element);
                                                          },
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: width(
                                                                        26)),
                                                            // width: width(124),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        width(
                                                                            14)),
                                                            alignment: Alignment
                                                                .center,
                                                            decoration: controller
                                                                        .priceType
                                                                        .value ==
                                                                    element + 1
                                                                ? BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(width(
                                                                            40))),
                                                                    color: controller
                                                                        .currentCustomThemeData()
                                                                        .colors0xEFDFFF)
                                                                : const BoxDecoration(),
                                                            child: Text(
                                                              controller
                                                                  .priceTypeList[
                                                                      element]
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  height: 1.0,
                                                                  color: controller
                                                                              .priceType
                                                                              .value ==
                                                                          element +
                                                                              1
                                                                      ? controller
                                                                          .currentCustomThemeData()
                                                                          .colors0x8E1EFF
                                                                      : controller
                                                                          .currentCustomThemeData()
                                                                          .colors0x979797,
                                                                  fontSize:
                                                                      sp(24)),
                                                            ),
                                                          ),
                                                        ))
                                              ],
                                            )),*/
                                          ],
                                        ),
                                      ),*/
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: controller
                                      .currentCustomThemeData()
                                      .colors0xF4F4F4,
                                  height: width(1),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: width(20),
                                      top: width(30),
                                      bottom: width(36)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            videoPageTranslations['default']
                                                .toString(),
                                            style: TextStyle(
                                                color: controller
                                                    .currentCustomThemeData()
                                                    .colors0x000000,
                                                fontSize: sp(32)),
                                          ),
                                          Opacity(
                                            opacity: 0.5,
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 2),
                                              child: Text(
                                                "（" +
                                                    videoPageTranslations[
                                                            'multiple_choices_can_be_selected_by_horizontal_sliding_up_to_5_can_be_selected']
                                                        .toString() +
                                                    "）",
                                                style: TextStyle(
                                                    color: controller
                                                        .currentCustomThemeData()
                                                        .colors0x000000,
                                                    fontSize: sp(22)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width(20)),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        controller.tagList1.length > 0
                                            ? Wrap(
                                          spacing: width(10),
                                          runSpacing: width(10),
                                          children: [
                                            ...controller.tagList1.map(
                                                    (element) =>
                                                    videoTagItem(element)),
                                          ],
                                        )
                                            : Container(),
                                        SizedBox(
                                          height: width(10),
                                        ),
                                        controller.tagList2.length > 0
                                            ? Wrap(
                                          spacing: width(10),
                                          runSpacing: width(10),
                                          children: [
                                            ...controller.tagList2.map(
                                                    (element) =>
                                                    videoTagItem(element)),
                                          ],
                                        )
                                            : Container(),
                                        SizedBox(
                                          height: width(10),
                                        ),
                                        controller.tagList3.length > 0
                                            ? Wrap(
                                          spacing: width(10),
                                          runSpacing: width(10),
                                          children: [
                                            ...controller.tagList3.map(
                                                    (element) =>
                                                    videoTagItem(element)),
                                          ],
                                        )
                                            : Container()
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: width(20)),
                                Container(
                                  color: controller
                                      .currentCustomThemeData()
                                      .colors0xF2F2F2,
                                  height: width(10),
                                ),
                                controller.videoList.isEmpty
                                    ? GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          controller.getVideo(1);
                                        },
                                        child: controller.isLoading.value
                                            ? const Center(
                                                child:
                                                    CupertinoActivityIndicator(),
                                              )
                                            : OLBlankView(),
                                      )
                                    : Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width(20)),
                                        child: Column(
                                          children: [
                                            ...controller.videoList.map(
                                                (element) => videoItem(element))
                                          ],
                                        ),
                                      )
                              ],
                            ),
                          )),
                    ),
                  ),
                ],
              )),
      floatingActionButton: Obx(() => Visibility(
          visible: controller.buttonShow.value,
          child: SizedBox(
            width: width(100),
            height: width(100),
            child: FloatingActionButton(
              onPressed: () {
                controller.scrollToTop(context);
              },
              child: Image.asset(
                Assets.videoPage.vBackTop.path,
                width: width(100),
                height: width(100),
              ),
            ),
          ))),
      floatingActionButtonLocation: CustomFloatingActionButtonLocation(
          FloatingActionButtonLocation.endFloat, -width(22), -width(112)),
    );
  }

  Widget videoItem(Video e) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(top: width(28)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(width(10)),
              ),
              child: CardView(
                num: e.priceType as int,
                cover: e.cover.toString(),
                time: e.duration.toString(),
                likes: VideoUtils.formatLikes(e.likeNumber ?? 0),
                title: e.title.toString(),
                flag: false,
                videoId: e.videoId as int,
              ),
            ),
            const SizedBox(
              width: 7.5,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Get.toNamed("/videoDetailPage", arguments: {"id": e.videoId});
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: width(192),
                  padding: EdgeInsets.symmetric(vertical: width(15)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        e.title ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: controller
                                .currentCustomThemeData()
                                .colors0x000000,
                            fontSize: sp(28)),
                      ),
                      e.tagList.toString().isNotEmpty
                          ? ExtendedWrap(
                              maxLines: 1,
                              children: [
                                ...e.tagList
                                    .toString()
                                    .split(",")
                                    .asMap()
                                    .keys
                                    .map((index) => Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width(10)),
                                          margin:
                                              EdgeInsets.only(right: width(10)),
                                          height: width(40),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(width(8))),
                                              color: controller
                                                  .currentCustomThemeData()
                                                  .colors0xF0F0F0),
                                          child: Text(
                                            e.tagList
                                                .toString()
                                                .split(",")[index],
                                            style: TextStyle(
                                                color: controller
                                                    .currentCustomThemeData()
                                                    .colors0x868686,
                                                fontSize: sp(20),
                                                height: 1.91),
                                          ),
                                        )),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget videoTagItem(TagSubModel element) {
    return InkWell(
      onTap: () {
        controller.chooseTag(element);
      },
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: width(20)),
            height: width(52),
            decoration: element.isSelected == true
                ? BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(width(8))),
                    border: Border.all(
                        width: width(2),
                        color:
                            controller.currentCustomThemeData().colors0x8E1EFF),
                    color: controller.currentCustomThemeData().colors0xF1E4FF,
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(width(8))),
                    border:
                        Border.all(width: width(2), color: Colors.transparent),
                    color: controller.currentCustomThemeData().colors0xF1F1F1,
                  ),
            child: Text(
              element.name ?? "",
              style: TextStyle(
                  color: controller.currentCustomThemeData().colors0x000000,
                  fontSize: sp(25)),
            ),
          ),
          element.isSelected == true
              ? Positioned(
                  left: 0,
                  top: 0,
                  child: SizedBox(
                      width: width(28),
                      height: width(22),
                      child: Image.asset(Assets.videoPage.vSelcetVideo.path)))
              : Container()
        ],
      ),
    );
  }
}
