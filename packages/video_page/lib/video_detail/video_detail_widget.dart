import 'dart:developer';

import 'package:base/app_routes.dart';
import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/screen.dart';
import 'package:base/commons/widgets/ol_blank_view.dart';
import 'package:base/commons/widgets/ol_operate_dialog_widget.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/translations/zh-Hans/zh_cn_video_image.dart';
import 'package:base_page/ad/ol_ad_controller.dart';
import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_tv/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';
import 'package:services/image/ol_image.dart';
import 'package:services/models/res/video/video_page_list_model.dart';
import 'package:video_page/components/MarqueeWidget.dart';
import 'package:video_page/components/card_item/card_item_page.dart';
import 'package:video_page/components/video_label.dart';
import 'package:video_page/video_detail/video_detail_controller.dart';
import 'package:video_page/video_utils.dart';

class VideoDetailWidget {
  static VideoDetailWidget of() => VideoDetailWidget();

  Widget buildCommentInputWidget(VideoDetailController controller,
      {required BuildContext context}) {
    String tip = controller.videoPageString("what_do_you_want_to_say");
    String replay = "";
    if ((controller.replayInfo.value.nickName ?? "").isNotEmpty) {
      String nickName = controller.replayInfo.value.nickName ?? "";
      replay = controller.videoPageString("reply").toString();
      tip = nickName;
    } else if ((controller.replayInfo2.value.nickName ?? "").isNotEmpty) {
      String nickName = controller.replayInfo2.value.nickName ?? "";
      replay = controller.videoPageString("reply").toString();
      tip = nickName;
    }

    if (controller.content.value.isNotEmpty) {
      replay = "";
    }

    log("refresh count ${controller.refreshCount.value}");

    return Row(
      children: [
        Expanded(
          child: Container(
            height: width(70),
            padding: EdgeInsets.symmetric(horizontal: width(20)),
            decoration: BoxDecoration(
                color: controller.currentCustomThemeData().colors0xF4F4F4,
                borderRadius: BorderRadius.all(Radius.circular(width(40)))),
            child: Row(
              children: [
                Container(
                    width: width(28),
                    height: width(28),
                    margin: EdgeInsets.only(right: width(20)),
                    child: Image.asset(Assets.videoPage.vWrite.path,
                        fit: BoxFit.cover)),
                if (replay.isNotEmpty) ...[
                  Text(replay),
                  const SizedBox(width: 8),
                ],
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
                    decoration: InputDecoration(
                      // contentPadding: const EdgeInsets.only(bottom: 14),
                      border: InputBorder.none,
                      hintText: tip,
                      isCollapsed: true,
                      hintStyle: const TextStyle(
                          color: Color(0xff979797), fontSize: 14.0),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    focusNode: controller.titleFocus,
                    controller: controller.titleCtr,
                    onChanged: (String text) {
                      // controller.refreshCount.value = controller.refreshCount.value + 1;
                      controller.setTitle(text);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            controller.sendComment();
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            width: width(120),
            height: width(70),
            margin: EdgeInsets.only(left: width(12)),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: controller.currentCustomThemeData().colors0x9F44FF,
                borderRadius: BorderRadius.all(Radius.circular(width(40)))),
            child: Text(
              videoPageTranslations['send'].toString(),
              style: TextStyle(
                  color: controller.currentCustomThemeData().colors0xFFFFFF,
                  fontSize: sp(32)),
            ),
          ),
        )
      ],
    );
  }

  Widget buildDetailOne(VideoDetailController controller,
      {required BuildContext context}) {
    List<String> tags = [];
    String? tagStr = controller.videoInfo.value.tagList;
    if (tagStr != null && tagStr.isNotEmpty == true) {
      tags = tagStr.split(",");
    }

    return Expanded(
      child:

          /// 详情
          SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: width(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  panelWidget(controller, controller.detailPanel.value),
                  SizedBox(height: width(10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          controller.videoInfo.value.title ?? '',
                          style: TextStyle(
                            color: controller
                                .currentCustomThemeData()
                                .colors0x000000,
                            fontSize: sp(31),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: width(10)),
                    child: Text(
                      " ${controller.videoInfo.value.playNumber ?? '0'}" +
                          videoPageTranslations['second'].toString() +
                          videoPageTranslations['play'].toString() +
                          " · ${controller.filterTime(controller.videoInfo.value.createTime.toString())}",
                      style: TextStyle(
                          color: controller
                              .currentCustomThemeData()
                              .colors0x979797,
                          fontSize: sp(24)),
                    ),
                  ),
                  tags.isNotEmpty
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ...tags.asMap().keys.map((index) => VideoLabel(
                                controller: controller, title: tags[index])),
                          ],
                        )
                      : Container(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width(0))
                        .copyWith(top: width(48), bottom: width(26)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              // Get.toNamed("/myLike");
                              // Get.toNamed("/offlineCache");
                              controller.videoCollect();
                            },
                            child: Container(
                              width: 60,
                              height: 35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  controller.videoInfo.value.likeFlag == true
                                      ? Container(
                                          width: width(40),
                                          height: width(30),
                                          margin:
                                              EdgeInsets.only(right: width(10)),
                                          child: Image.asset(
                                              Assets.videoPage.vCollectT.path,
                                              fit: BoxFit.fitWidth))
                                      : Container(
                                          width: width(40),
                                          height: width(30),
                                          margin:
                                              EdgeInsets.only(right: width(10)),
                                          child: Image.asset(
                                              Assets.videoPage.vLove.path,
                                              fit: BoxFit.fitWidth)),
                                  Text(
                                    VideoUtils.formatLikes(
                                        controller.videoInfo.value.likeNumber ??
                                            0),
                                    style: TextStyle(
                                        color: controller
                                            .currentCustomThemeData()
                                            .colors0x979797,
                                        fontSize: sp(24)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              // controller.shareLink();
                              Get.toNamed(AppRoutes.inviteFriends);
                            },
                            child: Container(
                              width: 60,
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width: width(40),
                                      height: width(30),
                                      margin: EdgeInsets.only(right: width(10)),
                                      child: Image.asset(
                                          Assets.videoPage.vShareLink.path,
                                          fit: BoxFit.fitWidth)),
                                  Text(
                                    videoPageTranslations['share'].toString(),
                                    style: TextStyle(
                                        color: controller
                                            .currentCustomThemeData()
                                            .colors0x979797,
                                        fontSize: sp(24)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            // arguments: {
                            //   "categoryId": 0,
                            // 'extra': extra,
                            // },
                            Get.toNamed(AppRoutes.feedback, arguments: {
                              "feedbackType": "1",
                              "videoId":
                                  controller.videoInfo.value.id.toString(),
                              "videoTitle":
                                  controller.videoInfo.value.title.toString(),
                            });
                          },
                          child: Container(
                            width: 60,
                            height: 35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: width(40),
                                    height: width(30),
                                    margin: EdgeInsets.only(right: width(10)),
                                    child: Image.asset(
                                      Assets.videoPage.vOpinion.path,
                                    )),
                                Text(
                                  videoPageTranslations['feedback'].toString(),
                                  style: TextStyle(
                                      color: controller
                                          .currentCustomThemeData()
                                          .colors0x979797,
                                      fontSize: sp(24)),
                                ),
                              ],
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: width(2),
              color: controller.currentCustomThemeData().colors0xE7E7E7,
            ),
            Container(
              margin: EdgeInsets.only(
                  top: width(26), bottom: width(10), left: width(15)),
              child: Text(
                videoPageTranslations['guess_you'].toString() +
                    videoPageTranslations['like'].toString(),
                style: TextStyle(
                    color: controller.currentCustomThemeData().colors0x262626,
                    fontWeight: FontWeight.bold,
                    fontSize: sp(30)),
              ),
            ),
            ...controller.recommendList.map((e){
              List<String> tags = [];
              String? tagStr = e.tagList;
              if (tagStr != null && tagStr.isNotEmpty == true) {
                tags = tagStr.split(",");
              }
              return InkWell(
                onTap: () {
                  int ids = e.videoId as int;
                  controller.play(ids);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: width(15))
                      .copyWith(bottom: width(30)),
                  child: Row(
                    children: [
                      CardView(
                        num: e.priceType as int,
                        cover: e.cover.toString(),
                        time: e.duration.toString(),
                        likes: VideoUtils.formatLikes(e.likeNumber ?? 0),
                        title: e.title.toString(),
                        flag: false,
                        videoId: 0,
                      ),
                      const SizedBox(
                        width: 7.5,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            // Get.to(const VideoDetailPage());
                            int ids = e.videoId as int;
                            controller.play(ids);
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: width(192),
                            padding:
                            EdgeInsets.symmetric(vertical: width(15)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  e.title ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: controller
                                          .currentCustomThemeData()
                                          .colors0x000000,
                                      fontSize: sp(30)),
                                ),
                                tags.isNotEmpty
                                    ? ExtendedWrap(
                                  alignment: WrapAlignment.center,
                                  maxLines: 1,
                                  children: [
                                    ...tags
                                        .asMap()
                                        .keys
                                        .map((index) => VideoLabel(controller: controller,title: tags[index])),
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
            })
          ],
        ),
      ),
    );
  }

  Widget buildDetailTwo(VideoDetailController controller,
      {required BuildContext context}) {
    return Expanded(
        child: Stack(
      children: [
        Column(children: [
          panelWidget(controller, controller.commentPanel.value),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: width(28)),
              child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: WaterDropHeader(
                    refresh: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Color(0xff999999))),
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
                              color: const Color(0xff999999), fontSize: sp(28)),
                        );
                      } else if (mode == LoadStatus.loading) {
                        body = const CupertinoActivityIndicator();
                      } else if (mode == LoadStatus.failed) {
                        body = Text(
                          videoPageTranslations['loading_failed_try_again'].toString(),
                          style: TextStyle(
                              color: const Color(0xff999999), fontSize: sp(28)),
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
                              color: const Color(0xff999999), fontSize: sp(28)),
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
                    controller.getComment(1);
                  },
                  onLoading: () {
                    controller.getComment(controller.page.value + 1);
                  },
                  child: controller.commentList.isEmpty
                      ? GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            controller.getComment(1);
                          },
                          child: controller.isLoading.value
                              ? const Center(
                                  child: CupertinoActivityIndicator(),
                                )
                              : OLBlankView(),
                        )
                      : SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: width(20))
                                .copyWith(bottom: width(130)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...controller.commentList.map((e) => Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: width(20)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(
                                                  right: width(20)),
                                              clipBehavior: Clip.hardEdge,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              width(80)))),
                                              child: OLImage(
                                                imageUrl: e.userAvatar ?? '',
                                                width: width(80),
                                                height: width(80),
                                              )),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          e.nickName ?? '',
                                                          style: TextStyle(
                                                              color: controller
                                                                  .currentCustomThemeData()
                                                                  .colors0x979797,
                                                              height: 1.0,
                                                              fontSize: sp(24)),
                                                        ),
                                                        // 内容
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: width(
                                                                      16)),
                                                          width: MediaQuery.of(context).size.width - AppDimens.w_180,
                                                          child: Text(
                                                            e.content ?? '',
                                                            style: TextStyle(
                                                                color: controller
                                                                    .currentCustomThemeData()
                                                                    .colors0x000000,
                                                                height: 1.0,
                                                                fontSize:
                                                                    sp(28)),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            controller
                                                                .report(e);
                                                          },
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: width(
                                                                        20)),
                                                            child: Column(
                                                              children: [
                                                                e.report == true
                                                                    ? Image
                                                                        .asset(
                                                                        Assets
                                                                            .videoPage
                                                                            .vReport
                                                                            .path,
                                                                        width: width(
                                                                            34),
                                                                        height:
                                                                            width(30),
                                                                      )
                                                                    : Image
                                                                        .asset(
                                                                        Assets
                                                                            .videoPage
                                                                            .vPush
                                                                            .path,
                                                                        width: width(
                                                                            34),
                                                                        height:
                                                                            width(30),
                                                                      ),
                                                                Container(
                                                                  margin: EdgeInsets.only(
                                                                      top: width(
                                                                          8)),
                                                                  child: Text(
                                                                    videoPageTranslations[
                                                                            'report']
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        color: controller
                                                                            .currentCustomThemeData()
                                                                            .colors0x979797,
                                                                        height:
                                                                            1.0,
                                                                        fontSize:
                                                                            sp(20)),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            controller
                                                                .follow(e);
                                                          },
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: width(
                                                                        20)),
                                                            child: Column(
                                                              children: [
                                                                e.likes == true
                                                                    ? Image
                                                                        .asset(
                                                                        Assets
                                                                            .videoPage
                                                                            .vFollowed
                                                                            .path,
                                                                        width: width(
                                                                            40),
                                                                        height:
                                                                            width(30),
                                                                      )
                                                                    : Image
                                                                        .asset(
                                                                        Assets
                                                                            .videoPage
                                                                            .vUnFollow
                                                                            .path,
                                                                        width: width(
                                                                            40),
                                                                        height:
                                                                            width(30),
                                                                      ),
                                                                Container(
                                                                  margin: EdgeInsets.only(
                                                                      top: width(
                                                                          8)),
                                                                  child: Text(
                                                                    videoPageTranslations[
                                                                            'give_the_thumbs-up']
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        color: controller
                                                                            .currentCustomThemeData()
                                                                            .colors0x979797,
                                                                        height:
                                                                            1.0,
                                                                        fontSize:
                                                                            sp(20)),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: width(16),
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right: width(24)),
                                                      child: Text(
                                                        e.timeText ?? '',
                                                        style: TextStyle(
                                                            color: controller
                                                                .currentCustomThemeData()
                                                                .colors0x979797,
                                                            height: 1.0,
                                                            fontSize: sp(20)),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        controller.replay(e);
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            right: width(24)),
                                                        child: Text(
                                                          videoPageTranslations[
                                                                  'reply']
                                                              .toString(),
                                                          style: TextStyle(
                                                              height: 1.0,
                                                              color: controller
                                                                  .currentCustomThemeData()
                                                                  .colors0x555555,
                                                              fontSize: sp(20)),
                                                        ),
                                                      ),
                                                    ),
                                                    e.createBy ==
                                                            controller.userInfo
                                                                .value.id
                                                        ? InkWell(
                                                            onTap: () {
                                                              final deleteInfo =
                                                                  videoPageTranslations[
                                                                          'comment_delete_info']
                                                                      .toString();

                                                              Get.dialog(
                                                                  OperatDialogWidgetAlert(
                                                                controller:
                                                                    controller,
                                                                content:
                                                                    deleteInfo,
                                                                callBack: () {
                                                                  controller
                                                                      .delete(
                                                                          e);
                                                                },
                                                              ));
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right: width(
                                                                          24)),
                                                              child: Text(
                                                                videoPageTranslations[
                                                                        'delete']
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    height: 1.0,
                                                                    color: controller
                                                                        .currentCustomThemeData()
                                                                        .colors0x555555,
                                                                    fontSize:
                                                                        sp(20)),
                                                              ),
                                                            ),
                                                          )
                                                        : Container()
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: width(22),
                                                ),
                                                e.replyCount != 0
                                                    ? e.nextList != null
                                                        ? Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              ...?e.nextList?.map(
                                                                  (element) =>
                                                                      Container(
                                                                        padding:
                                                                            EdgeInsets.symmetric(vertical: width(20)),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                                margin: EdgeInsets.only(right: width(20)),
                                                                                clipBehavior: Clip.hardEdge,
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(width(40)))),
                                                                                child: OLImage(
                                                                                  imageUrl: element.userAvatar ?? '',
                                                                                  width: width(40),
                                                                                  height: width(40),
                                                                                )),
                                                                            Expanded(
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Text(
                                                                                            element.nickName ?? '',
                                                                                            style: TextStyle(color: controller.currentCustomThemeData().colors0x979797, height: 1.0, fontSize: sp(24)),
                                                                                          ),
                                                                                          Container(
                                                                                            margin: EdgeInsets.only(top: width(16)),
                                                                                            child: Text(
                                                                                              element.content ?? '',
                                                                                              style: TextStyle(color: controller.currentCustomThemeData().colors0x000000, height: 1.0, fontSize: sp(28)),
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          InkWell(
                                                                                            onTap: () {
                                                                                              controller.report2(element);
                                                                                            },
                                                                                            child: Container(
                                                                                              margin: EdgeInsets.only(left: width(20)),
                                                                                              child: Column(
                                                                                                children: [
                                                                                                  element.report == true
                                                                                                      ? Image.asset(
                                                                                                          Assets.videoPage.vReport.path,
                                                                                                          width: width(34),
                                                                                                          height: width(30),
                                                                                                        )
                                                                                                      : Image.asset(
                                                                                                          Assets.videoPage.vPush.path,
                                                                                                          width: width(34),
                                                                                                          height: width(30),
                                                                                                        ),
                                                                                                  Container(
                                                                                                    margin: EdgeInsets.only(top: width(8)),
                                                                                                    child: Text(
                                                                                                      videoPageTranslations['report'].toString(),
                                                                                                      style: TextStyle(color: controller.currentCustomThemeData().colors0x979797, height: 1.0, fontSize: sp(20)),
                                                                                                    ),
                                                                                                  )
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          InkWell(
                                                                                            onTap: () {
                                                                                              controller.follow2(element);
                                                                                            },
                                                                                            child: Container(
                                                                                              margin: EdgeInsets.only(left: width(20)),
                                                                                              child: Column(
                                                                                                children: [
                                                                                                  element.likes == true
                                                                                                      ? Image.asset(
                                                                                                          Assets.videoPage.vFollowed.path,
                                                                                                          width: width(40),
                                                                                                          height: width(30),
                                                                                                        )
                                                                                                      : Image.asset(
                                                                                                          Assets.videoPage.vUnFollow.path,
                                                                                                          width: width(40),
                                                                                                          height: width(30),
                                                                                                        ),
                                                                                                  Container(
                                                                                                    margin: EdgeInsets.only(top: width(8)),
                                                                                                    child: Text(
                                                                                                      videoPageTranslations['give_the_thumbs-up'].toString(),
                                                                                                      style: TextStyle(color: controller.currentCustomThemeData().colors0x979797, height: 1.0, fontSize: sp(20)),
                                                                                                    ),
                                                                                                  )
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: width(16),
                                                                                  ),
                                                                                  Row(
                                                                                    children: [
                                                                                      Container(
                                                                                        margin: EdgeInsets.only(right: width(24)),
                                                                                        child: Text(
                                                                                          element.timeText ?? '',
                                                                                          style: TextStyle(color: controller.currentCustomThemeData().colors0x979797, height: 1.0, fontSize: sp(20)),
                                                                                        ),
                                                                                      ),
                                                                                      InkWell(
                                                                                        onTap: () {
                                                                                          controller.replay2(element);
                                                                                        },
                                                                                        child: Container(
                                                                                          margin: EdgeInsets.only(right: width(24)),
                                                                                          child: Text(
                                                                                            videoPageTranslations['reply'].toString(),
                                                                                            style: TextStyle(height: 1.0, color: controller.currentCustomThemeData().colors0x555555, fontSize: sp(20)),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      element.createBy == controller.userInfo.value.id
                                                                                          ? InkWell(
                                                                                              onTap: () {
                                                                                                final deleteInfo = videoPageTranslations['comment_delete_info'].toString();

                                                                                                Get.dialog(OperatDialogWidgetAlert(
                                                                                                  controller: controller,
                                                                                                  content: deleteInfo,
                                                                                                  callBack: () {
                                                                                                    controller.delete2(element);
                                                                                                  },
                                                                                                ));
                                                                                              },
                                                                                              child: Container(
                                                                                                margin: EdgeInsets.only(right: width(24)),
                                                                                                child: Text(
                                                                                                  videoPageTranslations['delete'].toString(),
                                                                                                  style: TextStyle(height: 1.0, color: controller.currentCustomThemeData().colors0x555555, fontSize: sp(20)),
                                                                                                ),
                                                                                              ),
                                                                                            )
                                                                                          : Container()
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: width(22),
                                                                                  ),
                                                                                  element.replyCount != 0
                                                                                      ? InkWell(
                                                                                          onTap: () {
                                                                                            controller.showNext(e);
                                                                                          },
                                                                                          child: Row(
                                                                                            children: [
                                                                                              Container(
                                                                                                width: width(70),
                                                                                                height: width(2),
                                                                                                margin: EdgeInsets.only(right: width(8)),
                                                                                                color: controller.currentCustomThemeData().colors0x979797,
                                                                                              ),
                                                                                              Container(
                                                                                                margin: EdgeInsets.only(right: width(8)),
                                                                                                child: Text(
                                                                                                  videoPageTranslations['develop'].toString() + "${element.replyCount ?? ''}" + videoPageTranslations['twig'].toString() + videoPageTranslations['reply'].toString(),
                                                                                                  style: TextStyle(color: controller.currentCustomThemeData().colors0x979797, fontSize: sp(24)),
                                                                                                ),
                                                                                              ),
                                                                                              Container(width: width(12), height: width(10), margin: EdgeInsets.only(right: width(8)), child: Image.asset(Assets.videoPage.vDownIcon.path, fit: BoxFit.cover)),
                                                                                            ],
                                                                                          ),
                                                                                        )
                                                                                      : Container(),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ))
                                                            ],
                                                          )
                                                        : InkWell(
                                                            onTap: () {
                                                              controller
                                                                  .showNext(e);
                                                            },
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  width:
                                                                      width(70),
                                                                  height:
                                                                      width(2),
                                                                  margin: EdgeInsets.only(
                                                                      right:
                                                                          width(
                                                                              8)),
                                                                  color: controller
                                                                      .currentCustomThemeData()
                                                                      .colors0x979797,
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets.only(
                                                                      right:
                                                                          width(
                                                                              8)),
                                                                  child: Text(
                                                                    videoPageTranslations['develop'].toString() +
                                                                        "${e.replyCount ?? ''}" +
                                                                        videoPageTranslations['twig']
                                                                            .toString() +
                                                                        videoPageTranslations['reply']
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        color: controller
                                                                            .currentCustomThemeData()
                                                                            .colors0x979797,
                                                                        fontSize:
                                                                            sp(24)),
                                                                  ),
                                                                ),
                                                                Container(
                                                                    width:
                                                                        width(
                                                                            12),
                                                                    height:
                                                                        width(
                                                                            10),
                                                                    margin: EdgeInsets.only(
                                                                        right: width(
                                                                            8)),
                                                                    child: Image.asset(
                                                                        Assets
                                                                            .videoPage
                                                                            .vDownIcon
                                                                            .path,
                                                                        fit: BoxFit
                                                                            .cover)),
                                                              ],
                                                            ),
                                                          )
                                                    : Container(),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        )),
            ),
          ),
        ]),
        Positioned(
          left: 0,
          bottom: 0,
          height: width(130),
          width: width(750),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(
                horizontal: width(28), vertical: width(30)),
            decoration: BoxDecoration(
                color: controller.currentCustomThemeData().colors0xFFFFFF,
                border: Border(
                    top: BorderSide(
                  width: width(2),
                  color: controller.currentCustomThemeData().colors0xF4F4F4,
                ))),
            child: VideoDetailWidget.of()
                .buildCommentInputWidget(controller, context: context),
          ),
        ),
      ],
    ));
  }

  Widget buildDetailWidget(VideoDetailController controller,
      {required BuildContext context}) {
    return controller.currentType.value == 1
        ? buildDetailOne(controller, context: context)
        : buildDetailTwo(controller, context: context);
  }

  Widget panelWidget(controller, VideoPageListModel item) {
    return Wrap(
      spacing: width(10),
      runSpacing: width(10),
      children: [
        ...?item.contentList?.map((e) {
          return e.refrenceType == 4
              ? CardView(
                  cW: (690 - 10 * (int.parse(e.columnNum.toString()) - 1)) /
                      int.parse(e.columnNum.toString()),
                  cH: ((690 - 10 * (int.parse(e.columnNum.toString()) - 1)) /
                          int.parse(e.columnNum.toString())) *
                      (192 / 340),
                  num: e.video?.priceType as int,
                  cover: e.video?.cover as String,
                  time: e.video?.duration.toString() as String,
                  likes: VideoUtils.formatLikes(e.video?.likeNumber ?? 0),
                  title: e.video?.title.toString() as String,
                  videoId: e.video?.videoId as int,
                  flag: e.columnNum == 1 ? false : true,
                )
              : e.refrenceType == 2
                  ? Container(
                      height: width(332),
                      width: width(750),
                      margin: EdgeInsets.only(top: width(20)),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              String url = e
                                  .bannerList![int.parse(index.toString())]
                                  .bannerImage
                                  .toString();
                              return InkWell(
                                onTap: () async {
                                  final adItem = e
                                      .bannerList![int.parse(index.toString())];

                                  var type = adItem.type ?? 0;
                                  if (type == OLAdType.video.index) {
                                    var videoController =
                                        controller as VideoDetailController;
                                    videoController.play(
                                        int.parse(adItem.skipValue.toString()));
                                    return;
                                  }

                                  OLAdController.shared.click(
                                      adItem.type ?? 0,
                                      adItem.skipModel ?? 0,
                                      adItem.skipValue ?? "",
                                      adItem.extraParams ?? "");
                                },
                                child: Container(
                                    clipBehavior: Clip.hardEdge,
                                    height: width(332),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(width(10)))),
                                    child: OLImage(
                                      imageUrl: url,
                                      fit: BoxFit.cover,
                                    )),
                              );
                            },
                            itemCount: e.bannerList?.length as int,
                            viewportFraction: 0.90,
                            scale: 0.95,
                            autoplay: true,
                          )
                        ],
                      ),
                    )
                  : e.refrenceType == 1
                      ? SizedBox(
                          height: width(60),
                          width: width(750),
                          // margin:EdgeInsets.only(top: width(20)),
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: width(30)),
                            color: controller
                                .currentCustomThemeData()
                                .colors0xF0EAFF,
                            child: Row(
                              children: [
                                Container(
                                    width: width(30),
                                    height: width(30),
                                    margin: EdgeInsets.only(right: width(20)),
                                    child: Image.asset(
                                        Assets.videoPage.vNotice.path)),
                                Expanded(
                                  child: buildMarqueeWidget(controller,
                                      e.noticeList as List<NoticeList>),
                                )
                              ],
                            ),
                          ))
                      : e.refrenceType == 3
                          ? InkWell(
                              onTap: () async {
                                String adUrl =
                                    e.banner?.skipValue.toString() as String;

                                final adItem = e.banner!;

                                var type = adItem.type ?? 0;
                                if (type == OLAdType.video.index) {
                                  var videoController =
                                      controller as VideoDetailController;
                                  videoController.play(
                                      int.parse(adItem.skipValue.toString()));
                                  return;
                                }

                                OLAdController.shared.click(
                                    adItem.type ?? 0,
                                    adItem.skipModel ?? 0,
                                    adItem.skipValue ?? "",
                                    adItem.extraParams ?? "");
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: width(15)),
                                clipBehavior: Clip.hardEdge,
                                width: width((720 -
                                        10 *
                                            (int.parse(e.columnNum.toString()) -
                                                1)) /
                                    int.parse(e.columnNum.toString())),
                                /*height: width(((720 -
                                            10 *
                                                (int.parse(e.columnNum
                                                        .toString()) -
                                                    1)) /
                                        int.parse(e.columnNum.toString())) *
                                    (70 / 360)),*/
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(width(10))),
                                ),
                                child: OLImage(
                                  imageUrl: e.banner?.bannerImage.toString()
                                      as String,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              height: 0,
                            );
        })
      ],
    );
  }

  MarqueeWidget buildMarqueeWidget(controller, List<NoticeList> loopList) {
    ///上下轮播 安全提示
    return MarqueeWidget(
      scrollDirection: Axis.horizontal,
      //子Item构建器
      itemBuilder: (BuildContext context, int index) {
        String itemStr = loopList[index].content.toString();
        //通常可以是一个 Text文本
        return Container(
          height: width(60),
          alignment: Alignment.centerLeft,
          child: Text(
            itemStr,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
                color: controller.currentCustomThemeData().colors0x000000,
                fontSize: sp(24)),
          ),
        );
      },
      //循环的提示消息数量
      count: loopList.length,
    );
  }
}
