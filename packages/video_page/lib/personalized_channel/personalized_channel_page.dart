import 'dart:developer';

import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/screen.dart';
import 'package:base/commons/widgets/ol_sortable_gridView.dart';
import 'package:base/translations/zh-Hans/zh_cn_video_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/models/res/video/video_category_model.dart';
import 'package:video_page/personalized_channel/personalized_channel_controller.dart';

class PersonalizedChannelPage extends GetView<PersonalizedChannelController> {
  const PersonalizedChannelPage({Key? key}) : super(key: key);

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
            width: 8,
            height: 15,
          ),
        ),
        title: Text(videoPageTranslations['personalized_channel'].toString(),
            style: TextStyle(
                color: controller.currentCustomThemeData().colors0x000000,
                fontSize: sp(32),
                fontWeight: FontWeight.w600)),
        actions: [
          Obx((){
            return InkWell(
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: width(30)),
                child: Text(
                    controller.editStates.value == 0 ? "编辑" : "保存",
                    style: TextStyle(
                        color: controller.currentCustomThemeData().colors0x000000,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              ),
              onTap: () {
                controller.editActionItem();
              },
            );
          }),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: width(30)),
              child: Text(videoPageTranslations['reset'].toString(),
                  style: TextStyle(
                      color: controller.currentCustomThemeData().colors0x000000,
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
            ),
            onTap: () {
              controller.getDatas();
            },
          ),
        ],
      ),
      body: GetX<PersonalizedChannelController>(
          init: controller,
          builder: (_) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 当前选择的
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width(20))
                        .copyWith(top: width(10)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                videoPageTranslations['current_use'].toString(),
                                style: TextStyle(
                                    color: controller
                                        .currentCustomThemeData()
                                        .colors0xACACAC,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400)),
                            Text('(9/${controller.tabList.length})',
                                style: TextStyle(
                                    color: controller
                                        .currentCustomThemeData()
                                        .colors0xACACAC,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                        SizedBox(
                          height: width(16),
                        ),
                        SortableGridView(
                          controller.tabList,
                          childAspectRatio: 2.3, //宽高3比1
                          crossAxisCount: 3, //3列
                          scrollDirection: Axis.vertical, //竖向滑动
                          physics: false, // 禁止滑动
                          canAccept: (oldIndex, newIndex) {
                            controller.useOldIndex = oldIndex;
                            controller.useNewIndex = newIndex;
                            print(
                                "oldIndex:${oldIndex}---newIndex:${newIndex}");
                            return true;
                          },
                          dragCompletedCallBack: (newIndex) {
                            controller.draggableItem();
                          },
                          itemBuilder: (context, data) {
                            final model = data as VideoCategoryModel;
                            return Container(
                              margin: EdgeInsets.only(right: 5, bottom: 10),
                              height: width(82),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(width(8))),
                                  border: Border.all(
                                      color: controller
                                          .currentCustomThemeData()
                                          .colors0xE8E8E8,
                                      width: width(1))),
                              child: InkWell(
                                  onTap: () {
                                    log(model.categoryName ?? "");
                                    controller.selectTabListItem(model);
                                  },
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Text(model.categoryName ?? '',
                                            style: TextStyle(
                                                color: controller
                                                    .currentCustomThemeData()
                                                    .colors0x000000,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400)),
                                      ),
                                      Positioned(
                                        right: width(12),
                                        top: width(12),
                                        child: Visibility(
                                          visible: controller.editStates.value == 0 ? false : true,
                                          child: Container(
                                              width: width(24),
                                              height: width(24),
                                              margin: EdgeInsets.only(
                                                  left: width(12)),
                                              child: Image.asset(
                                                  model.isSelect == true
                                                      ? Assets
                                                      .videoPage.vSelect.path
                                                      : Assets
                                                      .videoPage.vUnMore.path,
                                                  fit: BoxFit.fitWidth)),
                                        ),
                                      )
                                    ],
                                  )),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  /// 所有的
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// 导航
                        Container(
                            padding: EdgeInsets.only(left: width(20)),
                            height: width(76),
                            child: Row(
                              children: [
                                Expanded(
                                    child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    ...controller.allList.map((e) {
                                      return Expanded(
                                          child: InkWell(
                                        onTap: () {
                                          controller.changeIndex(e);
                                        },
                                        child: Container(
                                          margin:
                                              EdgeInsets.only(right: width(42)),
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: width(6)),
                                                child: Text(
                                                  e.categoryName ?? '',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: e.id ==
                                                            controller
                                                                .currentIndex
                                                                .value
                                                        ? Colors.black
                                                        : controller
                                                            .currentCustomThemeData()
                                                            .colors0xACACAC,
                                                  ),
                                                ),
                                              ),
                                              e.id ==
                                                      controller
                                                          .currentIndex.value
                                                  ? Container(
                                                      width: width(40),
                                                      height: width(4),
                                                      decoration: const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20)),
                                                          gradient: LinearGradient(
                                                              begin: Alignment
                                                                  .centerLeft,
                                                              end: Alignment
                                                                  .centerRight,
                                                              colors: [
                                                                Color(
                                                                    0xff6129FF),
                                                                Color(
                                                                    0xffD96CFF)
                                                              ])),
                                                    )
                                                  : SizedBox(
                                                      width: width(20),
                                                      height: width(4),
                                                    )
                                            ],
                                          ),
                                        ),
                                      ));
                                    })
                                  ],
                                ))
                              ],
                            )),
                        Expanded(
                            child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ...controller.allList.map((element) => Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width(20)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: width(40),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              log(element.categoryName ??
                                                  'test');
                                              controller.selectItem(element);
                                            },
                                            child: Row(
                                              children: [
                                                Text(element.categoryName ?? '',
                                                    style: TextStyle(
                                                        color: controller
                                                            .currentCustomThemeData()
                                                            .colors0x000000,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                Visibility(
                                                  visible: controller.editStates.value == 0 ? false : true,
                                                  child: Container(
                                                      width: width(24),
                                                      height: width(24),
                                                      margin: EdgeInsets.only(
                                                          left: width(12)),
                                                      child: Image.asset(
                                                          element.isSelect == true
                                                              ? Assets.videoPage
                                                              .vSelect.path
                                                              : Assets.videoPage
                                                              .vUnMore.path,
                                                          fit: BoxFit
                                                              .fitWidth)), //vSelect,
                                                ),
                                              ],
                                            )),
                                        SizedBox(
                                          height: width(16),
                                        ),
                                        Wrap(
                                          spacing: width(10),
                                          runSpacing: width(18),
                                          children: [
                                            ...?element.categoryList?.map((e) =>
                                                InkWell(
                                                  onTap: () {
                                                    log(e.categoryName ??
                                                        "test");
                                                    controller.selectSubItem(e);
                                                  },
                                                  child: Container(
                                                      width: width(230),
                                                      height: width(82),
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      width(
                                                                          8))),
                                                          border: Border.all(
                                                              color: controller
                                                                  .currentCustomThemeData()
                                                                  .colors0xE8E8E8,
                                                              width: width(1))),
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            width: width(230),
                                                            height: width(82),
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                                e.categoryName ??
                                                                    '',
                                                                style: TextStyle(
                                                                    color: controller
                                                                        .currentCustomThemeData()
                                                                        .colors0x000000,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400)),
                                                          ),
                                                          Visibility(
                                                            visible: controller.editStates.value == 0 ? false : true,
                                                            child: Positioned(
                                                              right: width(12),
                                                              top: width(10),
                                                              child: InkWell(
                                                                child: SizedBox(
                                                                    width:
                                                                    width(24),
                                                                    height:
                                                                    width(24),
                                                                    child: Image.asset(
                                                                        e.isSelect ==
                                                                            true
                                                                            ? Assets
                                                                            .videoPage
                                                                            .vSelect
                                                                            .path
                                                                            : Assets
                                                                            .videoPage
                                                                            .vUnMore
                                                                            .path,
                                                                        fit: BoxFit
                                                                            .cover)),
                                                              ),
                                                            ),
                                                          )

                                                        ],
                                                      )),
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              )),
    );
  }
}
