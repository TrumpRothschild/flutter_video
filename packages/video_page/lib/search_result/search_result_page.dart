import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/screen.dart';
import 'package:base/commons/widgets/ol_appbar_backbtn_widget.dart';
import 'package:base/commons/widgets/ol_blank_view.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/translations/zh-Hans/zh_cn_video_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';
import 'package:services/models/res/video/video_page_list_model.dart';
import 'package:services/models/res/video/video_tag.dart';
import 'package:video_page/components/card_item/card_item_page.dart';
import 'package:video_page/search_result/search_result_controller.dart';
import 'package:extended_wrap/extended_wrap.dart';
import 'package:video_page/video_utils.dart';

import '../components/video_label.dart';

class SearchResultPage extends GetView<SearchResultPageController> {
  const SearchResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: controller.currentCustomThemeData().colors0xFFFFFF,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          titleSpacing: 0,
          // backgroundColor: Color(0xffF5F5F5),
          leading: AppBarBackButton(),
          title: Container(
            height: width(60),
            padding: EdgeInsets.symmetric(horizontal: width(16)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(width(40))),
                color: controller.currentCustomThemeData().colors0xF8F7F7,
                border: Border.all(
                    color: controller.currentCustomThemeData().colors0xCFCFCF,
                    width: width(1))),
            child: Row(
              children: [
                Container(
                    margin: EdgeInsets.only(right: width(20)),
                    width: width(26),
                    height: width(24),
                    child: Image.asset(Assets.videoPage.vSeachIcon.path)),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.text,
                    cursorColor:
                        controller.currentCustomThemeData().colors0x9F44FF,
                    style: TextStyle(
                        color:
                            controller.currentCustomThemeData().colors0x000000,
                        fontSize: sp(28)),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 12),
                      border: InputBorder.none,
                      hintText: "请输入影片名称",
                      hintStyle:
                          TextStyle(color: Color(0xff979797), fontSize: 14.0),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    focusNode: controller.titleFocus,
                    controller: controller.titleCtr,
                    textInputAction: TextInputAction.search,
                    onChanged: (String text) {
                      controller.setTitle(text);
                    },
                    onEditingComplete: () {
                      controller.getInit(1);
                    },
                  ),
                ),
                Obx(() {
                  return controller.keyWord.value.isNotEmpty
                      ? InkWell(
                          onTap: () {
                            controller.clearWord();
                          },
                          child: Container(
                              margin: EdgeInsets.only(left: width(20)),
                              width: width(36),
                              height: width(36),
                              child: Image.asset(Assets.videoPage.vClose.path)),
                        )
                      : Container(
                          margin: EdgeInsets.only(left: width(20)),
                          width: width(36),
                          height: width(36));
                  // Text(
                  //   videoPageTranslations['search_what_you_want_to_see'].toString(),
                  //   style: TextStyle(
                  //       color: controller.currentCustomThemeData().colors0x979797,
                  //       fontSize: sp(24)),
                  // ),
                }),
              ],
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                controller.getInit(1);
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
        body: GetX<SearchResultPageController>(
          init: controller,
          builder: (_) => Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: width(88),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: controller
                                    .currentCustomThemeData()
                                    .colors0xD9D9D9,
                                width: width(1)))),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                              onTap: () {
                                controller.setCurrentType(1);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      videoPageTranslations['default']
                                          .toString(),
                                      style: TextStyle(
                                          color: controller
                                              .currentCustomThemeData()
                                              .colors0x000000,
                                          fontSize: sp(28)),
                                    ),
                                  ),
                                  controller.sortType.value == 1
                                      ? Container(
                                          width: width(32),
                                          height: width(4),
                                          margin:
                                              EdgeInsets.only(top: width(12)),
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    Color(0xff6129FF),
                                                    Color(0xffD96CFF)
                                                  ])),
                                        )
                                      : Container(
                                          width: width(32),
                                          height: width(4),
                                          margin:
                                              EdgeInsets.only(top: width(12)),
                                        )
                                ],
                              )),
                        ),
                        Expanded(
                          child: InkWell(
                              onTap: () {
                                controller.setCurrentType(4);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        videoPageTranslations['time']
                                            .toString(),
                                        style: TextStyle(
                                            color: controller
                                                .currentCustomThemeData()
                                                .colors0x979797,
                                            fontSize: sp(28)),
                                      ),
                                    ],
                                  ),
                                  controller.sortType.value == 4
                                      ? Container(
                                          width: width(32),
                                          height: width(4),
                                          margin:
                                              EdgeInsets.only(top: width(12)),
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    Color(0xff6129FF),
                                                    Color(0xffD96CFF)
                                                  ])),
                                        )
                                      : Container(
                                          width: width(32),
                                          height: width(4),
                                          margin:
                                              EdgeInsets.only(top: width(12)),
                                        )
                                ],
                              )),
                        ),
                        Expanded(
                          child: InkWell(
                              onTap: () {
                                controller.setCurrentType(5);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        videoPageTranslations['heat']
                                            .toString(),
                                        style: TextStyle(
                                            color: controller
                                                .currentCustomThemeData()
                                                .colors0x979797,
                                            fontSize: sp(28)),
                                      ),
                                    ],
                                  ),
                                  controller.sortType.value == 5
                                      ? Container(
                                          width: width(32),
                                          height: width(4),
                                          margin:
                                              EdgeInsets.only(top: width(12)),
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4)),
                                              gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    Color(0xff6129FF),
                                                    Color(0xffD96CFF)
                                                  ])),
                                        )
                                      : Container(
                                          width: width(32),
                                          height: width(4),
                                          margin:
                                              EdgeInsets.only(top: width(12)),
                                        )
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: width(1),
                    color: controller.currentCustomThemeData().colors0xD9D9D9,
                  ),
                  InkWell(
                    onTap: () {
                      controller.changeFlag();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: width(30)),
                      margin: EdgeInsets.only(top: width(20)),
                      height: 30,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: width(24),
                                  height: width(20),
                                  margin: EdgeInsets.only(right: width(8)),
                                  child: Image.asset(
                                      Assets.videoPage.vDownIcon.path,
                                      fit: BoxFit.cover)),
                              Text(
                                videoPageTranslations['screen'].toString(),
                                style: TextStyle(
                                    color: controller
                                        .currentCustomThemeData()
                                        .colors0x979797,
                                    fontSize: sp(28)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: width(20)),
                        margin: EdgeInsets.only(top: width(30)),
                        child: SmartRefresher(
                            enablePullDown: true,
                            enablePullUp: true,
                            header: WaterDropHeader(
                              refresh: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation(
                                      Color(0xff999999))),
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
                              builder:
                                  (BuildContext context, LoadStatus? mode) {
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
                                    videoPageTranslations['loading_failed_try_again'].toString(),
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
                              controller.getInit(1);
                            },
                            onLoading: () {
                              controller.getInit(controller.page.value + 1);
                            },
                            child: controller.likeList.isEmpty
                                ? GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () {
                                      controller.getInit(1);
                                    },
                                    child: controller.isLoading.value
                                        ? const Center(
                                            child: CupertinoActivityIndicator(),
                                          )
                                        : OLBlankView(),
                                  )
                                : SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ...controller.likeList.map(
                                            (element) => videoItem(element))
                                      ],
                                    ),
                                  )),
                      ),
                    ),
                  )
                ],
              ),
              controller.filterFlag.value
                  ? Positioned(
                      left: 0,
                      top: width(155),
                      child: InkWell(
                        onTap: () {
                          controller.changeFlag();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: const Color.fromRGBO(0, 0, 0, 0.5),
                        ),
                      ),
                    )
                  : Container(),
              controller.filterFlag.value
                  ? Container(
                      margin: EdgeInsets.only(top: width(155), left: 0),
                      height: width(500),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(
                          top: width(0),
                          right: width(20),
                          bottom: width(40),
                          left: width(20)),
                      color: controller.currentCustomThemeData().colors0xFFFFFF,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: width(5),
                          ),
                          Text(
                            videoPageTranslations['default'].toString(),
                            style: TextStyle(
                                color: controller
                                    .currentCustomThemeData()
                                    .colors0x000000,
                                fontSize: sp(32)),
                          ),
                          SizedBox(
                            height: width(16),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Wrap(
                              spacing: width(10),
                              runSpacing: width(10),
                              children: [
                                ...controller.contentTypeList.map((element) =>
                                    InkWell(
                                      onTap: () {
                                        VideoTag tag = element;
                                        controller
                                            .changeCurrentType(tag.id as int);
                                      },
                                      child: Container(
                                        width: width(134),
                                        height: width(70),
                                        alignment: Alignment.center,
                                        decoration: controller
                                                    .contentType.value ==
                                                element.id
                                            ? BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(width(8))),
                                                color: controller
                                                    .currentCustomThemeData()
                                                    .colors0xEFDFFF,
                                                border: Border.all(
                                                    color:
                                                        const Color(0xff8E1EFF),
                                                    width: width(2)))
                                            : BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(width(8))),
                                                border: Border.all(
                                                    color:
                                                        const Color(0xffC7C7C7),
                                                    width: width(2))),
                                        child: Text(
                                          element.label ?? "",
                                          style: TextStyle(
                                              color: controller
                                                          .contentType.value ==
                                                      element.id
                                                  ? controller
                                                      .currentCustomThemeData()
                                                      .colors0x8E1EFF
                                                  : controller
                                                      .currentCustomThemeData()
                                                      .colors0xC7C7C7,
                                              fontSize: sp(28)),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: width(36),
                          ),
                          Text(
                            videoPageTranslations['sort'].toString(),
                            style: TextStyle(
                                color: controller
                                    .currentCustomThemeData()
                                    .colors0x000000,
                                fontSize: sp(32)),
                          ),
                          SizedBox(
                            height: width(16),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Wrap(
                              spacing: width(10),
                              runSpacing: width(10),
                              children: [
                                ...controller.sortList.map((element) => InkWell(
                                      onTap: () {
                                        controller
                                            .changeType(element.id as int);
                                      },
                                      child: Container(
                                        width: width(134),
                                        height: width(70),
                                        alignment: Alignment.center,
                                        decoration: controller
                                                    .sortType2.value ==
                                                element.id
                                            ? BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(width(8))),
                                                color: controller
                                                    .currentCustomThemeData()
                                                    .colors0xEFDFFF,
                                                border: Border.all(
                                                    color:
                                                        const Color(0xff8E1EFF),
                                                    width: width(2)))
                                            : BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(width(8))),
                                                border: Border.all(
                                                    color:
                                                        const Color(0xffC7C7C7),
                                                    width: width(2))),
                                        child: Text(
                                          element.label ?? "",
                                          style: TextStyle(
                                              color: controller
                                                          .sortType2.value ==
                                                      element.id
                                                  ? controller
                                                      .currentCustomThemeData()
                                                      .colors0x8E1EFF
                                                  : controller
                                                      .currentCustomThemeData()
                                                      .colors0xC7C7C7,
                                              fontSize: sp(28)),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: width(80),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.reset();
                                },
                                child: Container(
                                  width: width(320),
                                  height: width(70),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(width(40))),
                                      border: Border.all(
                                          color: const Color(0xff9F44FF),
                                          width: width(2))),
                                  child: Text(
                                    videoPageTranslations['reset'].toString(),
                                    style: TextStyle(
                                        color: controller
                                            .currentCustomThemeData()
                                            .colors0x9F44FF,
                                        fontSize: sp(32)),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  controller.makeSure();
                                },
                                child: Container(
                                  width: width(320),
                                  height: width(70),
                                  margin: EdgeInsets.only(left: width(20)),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(width(40))),
                                      color: controller
                                          .currentCustomThemeData()
                                          .colors0x9F44FF),
                                  child: Text(
                                    videoPageTranslations['make_sure']
                                        .toString(),
                                    style: TextStyle(
                                        color: controller
                                            .currentCustomThemeData()
                                            .colors0xFFFFFF,
                                        fontSize: sp(32)),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  : Container()
            ],
          ),
        ));
  }

  Widget videoItem(Video e) {
    List<String> tags = [];
    String? tagStr = e.tagList;
    if (tagStr != null && tagStr.isNotEmpty == true) {
      tags = tagStr.split(",");
    }
    return InkWell(
      child: Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(bottom: width(30)),
        child: Row(
          children: [
            CardView(
              num: e.priceType as int,
              cover: e.cover.toString(),
              time: e.duration.toString(),
              likes: VideoUtils.formatLikes(e.likeNumber ?? 0),
              title: e.title.toString(),
              flag: false,
              videoId: e.videoId as int,
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
                      tags.isNotEmpty
                          ? ExtendedWrap(
                              maxLines: 1,
                              children: [
                                ...tags.asMap().keys.map((index) => VideoLabel(
                                    controller: controller,
                                    title: tags[index])),
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

  Container _buildItem(Color color) => Container(
        alignment: Alignment.center,
        width: 100,
        height: 30,
        color: color,
        child: Text(
          "3",
          style: TextStyle(color: Colors.white, shadows: [
            Shadow(color: Colors.black, offset: Offset(.5, .5), blurRadius: 2)
          ]),
        ),
      );
}
