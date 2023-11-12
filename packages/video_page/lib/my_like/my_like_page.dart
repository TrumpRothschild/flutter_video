import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/screen.dart';
import 'package:base/commons/widgets/ol_appbar_backbtn_widget.dart';
import 'package:base/commons/widgets/ol_appbar_title_widget.dart';
import 'package:base/commons/widgets/ol_blank_view.dart';
import 'package:base/commons/widgets/ol_list_footer_widget.dart';
import 'package:base/translations/zh-Hans/zh_cn_video_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';
import 'package:services/models/res/video/video_page_list_model.dart';
import 'package:video_page/components/card_item/card_item_page.dart';
import 'package:video_page/my_like/my_like_controller.dart';
import 'package:video_page/video_utils.dart';

class MyLikePage extends GetView<MyLikeController> {
  const MyLikePage({Key? key}) : super(key: key);

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
          title: AppBarCenterTitle(title: "my_like2", controller: controller),
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
        body: GetX<MyLikeController>(
            init: controller,
            builder: (_) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width(25))
                          .copyWith(top: width(20), bottom: width(40)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                                height: width(60),
                                padding:
                                    EdgeInsets.symmetric(horizontal: width(30)),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(width(40))),
                                  color: controller
                                      .currentCustomThemeData()
                                      .colors0xF8F7F7,
                                ),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              right: controller.isSearchBarEdit
                                                          .value ==
                                                      false
                                                  ? width(220)
                                                  : width(520)),
                                          width: width(26),
                                          height: width(24),
                                          child: Image.asset(Assets
                                              .videoPage.vSeachIcon.path)),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: controller.isSearchBarEdit
                                                          .value ==
                                                      false
                                                  ? 20
                                                  : 30),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: TextField(
                                              textAlign: controller
                                                          .isSearchBarEdit
                                                          .value ==
                                                      true
                                                  ? TextAlign.left
                                                  : TextAlign.center,
                                              keyboardType: TextInputType.text,
                                              cursorColor: controller
                                                  .currentCustomThemeData()
                                                  .colors0x9F44FF,
                                              style: TextStyle(
                                                  color: controller
                                                      .currentCustomThemeData()
                                                      .colors0x000000,
                                                  fontSize: sp(28)),
                                              decoration: const InputDecoration(
                                                // contentPadding:
                                                //     EdgeInsets.symmetric(vertical: 1),
                                                border: InputBorder.none,
                                                isCollapsed: true,
                                                hintText: "请输入影片片名",
                                                hintStyle: TextStyle(
                                                    color: Color(0xff979797),
                                                    fontSize: 14.0),
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.never,
                                              ),
                                              focusNode: controller.titleFocus,
                                              controller: controller.titleCtr,
                                              onChanged: (String text) {
                                                controller.setTitle(text);
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                          InkWell(
                            onTap: () {
                              controller.getInit(1);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: width(22)),
                              child: Text(
                                videoPageTranslations['search'].toString(),
                                style: TextStyle(
                                    color: controller
                                        .currentCustomThemeData()
                                        .colors0x979797,
                                    fontSize: sp(32)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: width(28)),
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
                            footer: ListFooterWidget(),
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
                                        : OLBlankView(emptyTip: "快去找你喜欢的片吧~"),
                                  )
                                : SingleChildScrollView(
                                    child: Container(
                                        // padding: EdgeInsets.symmetric(
                                        //     horizontal: width(30)),
                                        alignment: Alignment.topLeft,
                                        child: Wrap(
                                          spacing: width(10),
                                          runSpacing: width(10),
                                          children: [
                                            ...controller.likeList.map(
                                                (element) => likeItem(element))
                                          ],
                                        )))),
                      ),
                    ),
                    controller.isEdit.value
                        ? Divider(
                            color: controller
                                .currentCustomThemeData()
                                .colors0xF4F4F4,
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
                                            color: controller
                                                    .videoIds.isNotEmpty
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
                )));
  }

  Widget likeItem(Video e) {
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
                  title: e.title.toString(),
                  flag: false,
                  videoId: e.videoId as int,
                ),
                controller.isEdit.value
                    ? Positioned(
                        left: 0,
                        top: 0,
                        width: width(340),
                        height: width(195),
                        child: Container(
                          width: width(340),
                          height: width(195),
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
              margin: EdgeInsets.only(top: width(10), bottom: width(10)),
              alignment: Alignment.centerLeft,
              child: Text(
                e.title.toString(),
                maxLines: 2,
                style: TextStyle(
                    color: controller.currentCustomThemeData().colors0x000000,
                    fontSize: sp(24)),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
    );
  }
}
