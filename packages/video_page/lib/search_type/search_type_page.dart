import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/screen.dart';
import 'package:base/commons/widgets/ol_appbar_backbtn_widget.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/translations/zh-Hans/zh_cn_video_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_page/search_type/search_type_controller.dart';

class SearchTypePage extends GetView<SearchTypePageController> {
  SearchTypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          titleSpacing: 0,
          leading: AppBarBackButton(),
          title: Container(
            height: width(65),
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.w_8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(width(40))),
                color: controller.currentCustomThemeData().colors0xF8F7F7, //
                border: Border.all(
                    color: controller.currentCustomThemeData().colors0xCFCFCF,
                    width: width(1))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Assets.videoPage.vSeachIcon
                    .image(width: AppDimens.w_18, height: AppDimens.w_18),
                const SizedBox(width: AppDimens.w_8),
                Obx(() {
                  var searchText = controller.searchTextController.text;
                  if (controller.selectTag.isNotEmpty) {
                    searchText = controller.selectTag.join(",").toString();
                    controller.searchTextController.value = TextEditingValue(
                        text: searchText,
                        selection: TextSelection.fromPosition(
                            TextPosition(offset: searchText.length)));
                    // searchTextController.text = searchText;
                  }
                  return Expanded(
                    child: TextField(
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      controller: controller.searchTextController,
                      cursorColor:
                          controller.currentCustomThemeData().colors0x9F44FF,
                      enabled: true,
                      onChanged: (text) {
                        // searchTextController.text = text;
                        if (controller.selectTag.isNotEmpty) {
                          controller.selectTag.value = [];
                          controller.searchTextController.text = "";
                        }
                      },
                      style: TextStyle(
                        color:
                            controller.currentCustomThemeData().colors0x000000,
                        fontSize: sp(28),
                        height: 1.5,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 12),
                        border: InputBorder.none,
                        hintText:
                            videoPageTranslations['search_what_you_want_to_see']
                                .toString(),
                        hintStyle: TextStyle(
                            color: Color(0xff979797),
                            fontSize: 14.0,
                            height: 1.5),
                      ),
                    ),
                  );
                }),
                Obx(() {
                  return controller.selectTag.isNotEmpty
                      ? InkWell(
                          onTap: () {
                            controller.clearAllSelectTags();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: width(5),
                            ),
                            child: Icon(
                              Icons.cancel,
                              color: controller
                                  .currentCustomThemeData()
                                  .colors0xC2C2C2,
                            ),
                          ),
                        )
                      : Container();
                }),
              ],
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                String searchValue = "";
                if (controller.selectTag.value.isNotEmpty) {
                  searchValue = controller.selectTag.join(",");
                } else {
                  searchValue = controller.searchTextController.text;
                }
                Get.toNamed("/searchResultPage",
                    arguments: {"keyWords": searchValue});
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: width(30), left: width(30)),
                child: Text(
                  videoPageTranslations['search'].toString(),
                  style: TextStyle(
                      color: controller.currentCustomThemeData().colors0x979797,
                      fontSize: sp(32)),
                ),
              ),
            )
          ],
        ),
        body: GetX<SearchTypePageController>(
            init: controller,
            builder: (_) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...controller.firstList.map((element) => Container(
                          padding: EdgeInsets.symmetric(horizontal: width(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: width(14), top: width(40)),
                                child: Text(
                                  element.name.toString(),
                                  style: TextStyle(
                                      color: controller
                                          .currentCustomThemeData()
                                          .colors0x000000,
                                      fontSize: sp(32)),
                                ),
                              ),
                              element.tagList!.length > 0
                                  ? Wrap(
                                      spacing: width(9),
                                      runSpacing: width(10),
                                      children: [
                                        ...element.tagList!.map((e) => InkWell(
                                              onTap: () {
                                                controller.chooseTag(e);
                                              },
                                              child: Container(
                                                width: width(170),
                                                height: width(60),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                width(10))),
                                                    color: controller.selectTag
                                                            .contains(e.name)
                                                        ? controller
                                                            .currentCustomThemeData()
                                                            .colors0xEDDCFF
                                                        : controller
                                                            .currentCustomThemeData()
                                                            .colors0xF7F7F7),
                                                child: Text(
                                                  e.name ?? "",
                                                  style: TextStyle(
                                                      color: controller
                                                              .selectTag
                                                              .contains(e.name)
                                                          ? controller
                                                              .currentCustomThemeData()
                                                              .colors0x9F44FF
                                                          : controller
                                                              .currentCustomThemeData()
                                                              .colors0x979797,
                                                      fontSize: sp(24)),
                                                ),
                                              ),
                                            ))
                                      ],
                                    )
                                  : Container()
                            ],
                          ),
                        )),

                    /// 横向导航栏
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: width(20)),
                      height: width(80),
                      margin:
                          EdgeInsets.only(top: width(40), bottom: width(10)),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: controller
                                      .currentCustomThemeData()
                                      .colors0xF7F7F7,
                                  width: width(2)))),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ...controller.tagList.asMap().keys.map((index) =>
                              InkWell(
                                onTap: () {
                                  print("test");
                                  controller.changeKey(index);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: width(50)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        controller.tagItemList[index]
                                            .toString(),
                                        style: TextStyle(
                                            color: controller
                                                        .currentKey.value ==
                                                    index
                                                ? controller
                                                    .currentCustomThemeData()
                                                    .colors0x000000
                                                : controller
                                                    .currentCustomThemeData()
                                                    .colors0x979797,
                                            fontSize: sp(32)),
                                      ),
                                      controller.currentKey.value == index
                                          ? Container(
                                              width: width(60),
                                              height: width(6),
                                              margin: EdgeInsets.only(
                                                  top: width(10)),
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end:
                                                          Alignment.centerRight,
                                                      colors: [
                                                        Color(0xff6129FF),
                                                        Color(0xffD96CFF)
                                                      ])),
                                            )
                                          : Container(
                                              width: width(60),
                                              height: width(6),
                                              margin: EdgeInsets.only(
                                                  top: width(10)),
                                            )
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...controller.tagList.map((element) => Container(
                                padding:
                                    EdgeInsets.symmetric(horizontal: width(20)),
                                margin: EdgeInsets.only(bottom: width(40)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(bottom: width(20)),
                                      child: Text(
                                        element.name.toString(),
                                        style: TextStyle(
                                            color: controller
                                                .currentCustomThemeData()
                                                .colors0x000000,
                                            fontSize: sp(32)),
                                      ),
                                    ),
                                    element.tagList!.length > 0
                                        ? Wrap(
                                            spacing: width(9),
                                            runSpacing: width(10),
                                            children: [
                                              ...element.tagList!.map((e) =>
                                                  InkWell(
                                                    onTap: () {
                                                      controller.chooseTag(e);
                                                    },
                                                    child: Container(
                                                      width: width(170),
                                                      height: width(60),
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      width(
                                                                          10))),
                                                          color: controller
                                                                  .selectTag
                                                                  .contains(
                                                                      e.name)
                                                              ? controller
                                                                  .currentCustomThemeData()
                                                                  .colors0xEDDCFF
                                                              : controller
                                                                  .currentCustomThemeData()
                                                                  .colors0xF7F7F7),
                                                      child: Text(
                                                        e.name ?? "",
                                                        style: TextStyle(
                                                            color: controller
                                                                    .selectTag
                                                                    .contains(
                                                                        e.name)
                                                                ? controller
                                                                    .currentCustomThemeData()
                                                                    .colors0x9F44FF
                                                                : controller
                                                                    .currentCustomThemeData()
                                                                    .colors0x979797,
                                                            fontSize: sp(24)),
                                                      ),
                                                    ),
                                                  ))
                                            ],
                                          )
                                        : Container()
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ))
                  ],
                )));
  }
}
