import 'package:base/app_routes.dart';
import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_view.dart';
import 'package:base/commons/utils/screen.dart';
import 'package:base/res/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/image/ol_image.dart';
import 'package:video_page/components/floatBtn.dart';
import 'package:video_page/video_home/video_home_controller.dart';
import 'package:video_page/video_home/video_home_widget.dart';

class VideoHomePage extends GetBaseView<VideoHomeController> {
  const VideoHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var customTheme = controller.currentCustomThemeData();
    return Obx(() {
      var tabData = controller.tabListData;
      return Scaffold(
        backgroundColor: customTheme.colors0xFFFFFF,
        appBar: AppBar(
            toolbarHeight: AppDimens.h_90,
            centerTitle: true,
            elevation: 0,
            titleSpacing: 0,
            title: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: VideoHomeWidget.of().searchWidget()),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.screen);
                      },
                      child: Padding(
                          padding: const EdgeInsets.only(
                              right: AppDimens.w_10, left: AppDimens.w_6),
                          child: Image.asset(Assets.videoPage.vChannel.path,
                              width: AppDimens.w_25, height: AppDimens.h_25)),
                    )
                  ],
                ),
                controller.tabController == null || tabData.isEmpty
                    ? const SizedBox()
                    : Align(
                        child: VideoHomeWidget.of().topTabBar(tabData),
                        alignment: Alignment.centerLeft)
              ],
            )),
        body: tabData.isEmpty
            ? VideoHomeWidget.of().videoEmpty()
            : Stack(
                fit: StackFit.expand,
                children: [
                  TabBarView(
                      controller: controller.tabController,
                      children: VideoHomeWidget.of().videoTabPages(tabData)),
                  controller.isCurrentVideo.value
                      ? Positioned(
                          left: 0,
                          bottom: width(32),
                          width: width(750),
                          height: width(116),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: width(95)),
                            alignment: Alignment.center,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(width(10))),
                              color: controller
                                  .currentCustomThemeData()
                                  .colors0xFFFFFF,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                    width: width(200),
                                    height: width(116),
                                    child: OLImage(
                                      imageUrl: controller.cover.value,
                                      fit: BoxFit.cover,
                                    )),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.only(left: width(10)),
                                    height: width(116),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: width(220),
                                          child: Text(
                                            controller.title.value,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: controller
                                                    .currentCustomThemeData()
                                                    .colors0x000000,
                                                fontSize: sp(28)),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            controller.jumpVideo();
                                          },
                                          child: Container(
                                              width: width(40),
                                              height: width(40),
                                              margin: EdgeInsets.only(
                                                  left: width(10)),
                                              child: Image.asset(
                                                Assets.videoPage.vPlayB.path,
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            controller.closeVideo();
                                          },
                                          child: Container(
                                              width: width(40),
                                              height: width(40),
                                              margin: EdgeInsets.only(
                                                  left: width(20)),
                                              child: Image.asset(
                                                Assets.videoPage.vCloseB.path,
                                                fit: BoxFit.cover,
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
        floatingActionButton: Obx(() => Visibility(
            visible: controller.buttonShow.value,
            child: SizedBox(
              width: width(100),
              height: width(100),
              child: FloatingActionButton(
                onPressed: () {
                  // controller.scrollToTop(context);
                },
                child: Image.asset(
                  Assets.videoPage.vBackTop.path,
                  width: width(100),
                  height: width(100),
                ),
              ),
            ))),
        floatingActionButtonLocation: CustomFloatingActionButtonLocation(
            FloatingActionButtonLocation.endFloat, -width(22), -width(312)),
      );
    });
  }
}
