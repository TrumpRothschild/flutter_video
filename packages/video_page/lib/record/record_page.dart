import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/screen.dart';
import 'package:base/commons/widgets/ol_appbar_backbtn_widget.dart';
import 'package:base/commons/widgets/ol_appbar_title_widget.dart';
import 'package:base/commons/widgets/ol_blank_view.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/translations/zh-Hans/zh_cn_video_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';
import 'package:services/models/res/video/video_page_list_model.dart';
import 'package:video_page/components/card_item/card_item_page.dart';
import 'package:video_page/record/record_controller.dart';
import 'package:video_page/video_utils.dart';

class RecordPage extends GetView<RecordController> {
  const RecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          backgroundColor: controller.currentCustomThemeData().colors0xFFFFFF,
          extendBodyBehindAppBar: false,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            titleSpacing: 0,
            leading: AppBarBackButton(),
            title: AppBarCenterTitle(
                title: "watch_the_record", controller: controller),
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
                                .colors0x7A7A7A,
                            fontSize: sp(28),
                            fontWeight: FontWeight.w400)),
                  )))
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  // padding: EdgeInsets.symmetric(horizontal: width(28)),
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
                              videoPageTranslations['up_loading_more']
                                  .toString(),
                              style: TextStyle(
                                  color: const Color(0xff999999),
                                  fontSize: sp(28)),
                            );
                          } else if (mode == LoadStatus.loading) {
                            body = const CupertinoActivityIndicator();
                          } else if (mode == LoadStatus.failed) {
                            body = Text(
                              videoPageTranslations['loading_failed_try_again']
                                  .toString(),
                              style: TextStyle(
                                  color: const Color(0xff999999),
                                  fontSize: sp(28)),
                            );
                          } else if (mode == LoadStatus.canLoading) {
                            body = Text(
                                videoPageTranslations['release_loading_more']
                                    .toString(),
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
                          : GridView.count(
                              crossAxisCount: 2,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppDimens.w_10),
                              childAspectRatio: 170 / 146,
                              crossAxisSpacing: AppDimens.w_5,
                              mainAxisSpacing: AppDimens.w_10,
                              children: [
                                ...controller.likeList
                                    .map((element) => recordItem(element))
                              ],
                            )),
                ),
              ),
              controller.isEdit.value
                  ? Divider(
                      color: controller.currentCustomThemeData().colors0xF4F4F4,
                    )
                  : Container(),
              controller.isEdit.value
                  ? SizedBox(
                      height: width(80),
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
                                      ? videoPageTranslations['cancel_all']
                                          .toString()
                                      : videoPageTranslations['select_all']
                                          .toString(),
                                  style: TextStyle(
                                      color: controller
                                          .currentCustomThemeData()
                                          .colors0x000000,
                                      fontSize: sp(28),
                                      fontWeight: FontWeight.w400)),
                            ),
                          )),
                          Container(
                            width: width(1),
                            height: width(30),
                            color: controller
                                .currentCustomThemeData()
                                .colors0xF4F4F4,
                          ),
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              controller.deleteItems();
                            },
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
                                      color: controller.videoIds.isNotEmpty
                                          ? controller
                                              .currentCustomThemeData()
                                              .colors0xF82D2D
                                          : controller
                                              .currentCustomThemeData()
                                              .colors0xB6B6B6,
                                      fontSize: sp(28),
                                      fontWeight: FontWeight.w400)),
                            ),
                          )),
                        ],
                      ),
                    )
                  : Container()
            ],
          ));
    });
  }

  Widget recordItem(Video e) {
    return SizedBox(
      width: width(340),
      child: Column(
        children: [
          SizedBox(
            width: width(340),
            child: Stack(
              children: [
                CardView(
                  num: e.priceType as int,
                  cover: e.cover as String,
                  time: e.duration.toString(),
                  likes: VideoUtils.formatLikes(e.likeNumber ?? 0),
                  title: ((e.title?.isNotEmpty ?? false) && e.title != 'null')
                      ? (e.title ?? '')
                      : '',
                  flag: false,
                  videoId: e.videoId as int,
                ),
                controller.isEdit.value
                    ? Positioned(
                        left: 0,
                        top: 0,
                        width: width(340),
                        child: Container(
                          width: width(340),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(95, 0, 0, 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(width(10)))),
                        ),
                      )
                    : Container(),
                controller.isEdit.value
                    ? Positioned(
                        right: width(16),
                        top: width(22),
                        child: InkWell(
                          onTap: () {
                            controller.chooseItem(e);
                          },
                          child: SizedBox(
                              width: width(40),
                              height: width(40),
                              child: e.flag == true
                                  ? Image.asset(Assets.videoPage.vSelect.path,
                                      fit: BoxFit.cover)
                                  : Image.asset(Assets.videoPage.vUn.path,
                                      fit: BoxFit.cover)),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed("/videoDetailPage",
                  arguments: {"id": e.videoId as int});
            },
            child: Container(
              margin: EdgeInsets.only(top: width(10), bottom: width(48)),
              alignment: Alignment.centerLeft,
              height: height(68),
              child: Text(
                ((e.title?.isNotEmpty ?? false) && e.title != 'null')
                    ? (e.title ?? '')
                    : '',
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    color: controller.currentCustomThemeData().colors0x000000,
                    fontSize: sp(24)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
