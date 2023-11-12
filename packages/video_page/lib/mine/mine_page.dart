import 'package:base/app_routes.dart';
import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/screen.dart';
import 'package:base/commons/widgets/ol_select_actionsheet_widget.dart';
import 'package:base/translations/zh-Hans/zh_cn_video_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/image/ol_image.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:video_page/mine/mine_controller.dart';

class MinePage extends GetView<MineController> {
  const MinePage({Key? key}) : super(key: key);

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      titleSpacing: 0,
      backgroundColor: Colors.transparent,
      title: Text(videoPageTranslations['personal_center'].toString(),
          style: TextStyle(
              color: controller.currentCustomThemeData().colors0x000000,
              fontSize: sp(32),
              fontWeight: FontWeight.w600)),
      actions: [
        Obx(
          () => UnconstrainedBox(
            child: Center(
              child: InkWell(
                onTap: controller.toMsg,
                child: Stack(
                  children: [
                    Image.asset(
                      // AppConfig.isVideo
                      //     ? Assets.minePage.videoSysMsg.path
                      //     :
                      Assets.minePage.sysMsg.path,
                      width: width(40),
                      height: width(40),
                    ),
                    if (controller.hasUnReadMsg.value)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: ShapeDecoration(
                            color: controller
                                .currentCustomThemeData()
                                .colors0xFF0000,
                            shape: const CircleBorder(),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.setUp);
          },
          child: UnconstrainedBox(
            child: Center(
              child: Container(
                margin: EdgeInsets.only(right: width(20), left: width(20)),
                child: Image.asset(
                  Assets.videoPage.vSetting.path,
                  width: width(40),
                  height: width(40),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: controller.currentCustomThemeData().colors0xFFFFFF,
        extendBodyBehindAppBar: true,
        appBar: buildAppBar(),
        body: GetX<MineController>(
            init: controller,
            builder: (_) => SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: width(560),
                        padding: EdgeInsets.only(
                            left: width(40), right: width(20), top: width(204)),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(Assets.videoPage.mineBgBg.path),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildHeader(),
                            buildNumInfo(),
                          ],
                        ),
                      ),
                      Container(
                        transform:
                            Matrix4.translationValues(0.0, -width(100), 0.0),
                        child: Column(
                          children: [
                            buildFunctions(),
                            Container(
                              alignment: Alignment.center,
                              height: width(20),
                              color: controller
                                  .currentCustomThemeData()
                                  .colors0xF5F5F5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(width(12)))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: width(20),
                                        bottom: width(16),
                                        left: width(22)),
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: controller
                                                    .currentCustomThemeData()
                                                    .colors0xE9E9E9,
                                                width: width(2)))),
                                    child: Text(
                                        videoPageTranslations['common_unctions']
                                            .toString(),
                                        style: TextStyle(
                                            color: controller
                                                .currentCustomThemeData()
                                                .colors0x000000,
                                            fontSize: sp(32))),
                                  ),
                                  // buildFuns(),

                                  SizedBox(
                                    height: width(10),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: InkWell(
                                        onTap: () {
                                          Get.toNamed("/myLike");
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              Assets.videoPage.vIcon1.path,
                                              width: width(76),
                                              height: width(60),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: width(8)),
                                              child: Text(
                                                  videoPageTranslations[
                                                          'my_like2']
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: controller
                                                          .currentCustomThemeData()
                                                          .colors0x333333,
                                                      fontSize: sp(28))),
                                            )
                                          ],
                                        ),
                                      )),
                                      Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              // Get.toNamed("/offlineCache");

                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  Assets.videoPage.vIcon2.path,
                                                  width: width(76),
                                                  height: width(60),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: width(8)),
                                                  child: Text(
                                                      videoPageTranslations[
                                                      'personal_cache']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: controller
                                                              .currentCustomThemeData()
                                                              .colors0x333333,
                                                          fontSize: sp(28))),
                                                )
                                              ],
                                            ),
                                          )),
                                      Expanded(
                                          child: InkWell(
                                        onTap: () {
                                          Get.toNamed("/record");
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              Assets.videoPage.vIcon3.path,
                                              width: width(76),
                                              height: width(60),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: width(8)),
                                              child: Text(
                                                  videoPageTranslations[
                                                          'watch_the_record2']
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: controller
                                                          .currentCustomThemeData()
                                                          .colors0x333333,
                                                      fontSize: sp(28))),
                                            )
                                          ],
                                        ),
                                      )),
                                      Expanded(
                                          child: InkWell(
                                        onTap: () {
                                          Get.toNamed("/accountSafety");
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              Assets.videoPage.vIcon6.path,
                                              width: width(76),
                                              height: width(60),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: width(8)),
                                              child: Text(
                                                  videoPageTranslations[
                                                          'mobile_phone_authentication']
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: controller
                                                          .currentCustomThemeData()
                                                          .colors0x333333,
                                                      fontSize: sp(28))),
                                            )
                                          ],
                                        ),
                                      )),
                                      /*Expanded(
                                          child: InkWell(
                                        onTap: () {
                                          Get.toNamed("/personalizedChannel");
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              Assets.videoPage.vIcon4.path,
                                              width: width(76),
                                              height: width(60),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: width(8)),
                                              child: Text(
                                                  videoPageTranslations[
                                                          'personalized_channel2']
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: controller
                                                          .currentCustomThemeData()
                                                          .colors0x333333,
                                                      fontSize: sp(28))),
                                            )
                                          ],
                                        ),
                                      )),*/

                                    ],
                                  ),
                                  SizedBox(
                                    height: width(40),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Get.bottomSheet(
                                                  SelectActionSheetWidgetAlert(
                                                    controller: controller,
                                                    callBack: (type) async {
                                                      String? urlLink = "";
                                                      if (type == 1) {
                                                        urlLink = UserManagerCache
                                                            .shared.config?.potato;
                                                      } else {
                                                        urlLink = UserManagerCache
                                                            .shared.config?.telegram;
                                                      }
                                                      String newUrl =
                                                          "https://$urlLink";
                                                      if (urlLink!
                                                          .contains("http://") ||
                                                          urlLink
                                                              .contains("https://")) {
                                                        newUrl = urlLink;
                                                      }
                                                      await launch(newUrl);
                                                    },
                                                  ));
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  Assets.videoPage.vIcon5.path,
                                                  width: width(76),
                                                  height: width(60),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: width(8)),
                                                  child: Text(
                                                      videoPageTranslations[
                                                      'official_communication_group']
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: controller
                                                              .currentCustomThemeData()
                                                              .colors0x333333,
                                                          fontSize: sp(28))),
                                                )
                                              ],
                                            ),
                                          )),
                                      Expanded(
                                          child: InkWell(
                                        onTap: () {
                                          Get.toNamed("/feedback");
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              Assets.videoPage.vIcon7.path,
                                              width: width(76),
                                              height: width(60),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: width(8)),
                                              child: Text(
                                                  videoPageTranslations[
                                                          'feedback2']
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: controller
                                                          .currentCustomThemeData()
                                                          .colors0x333333,
                                                      fontSize: sp(28))),
                                            )
                                          ],
                                        ),
                                      )),
                                      Expanded(
                                          child: InkWell(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.inviteFriends);
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              Assets.videoPage.vIcon12.path,
                                              width: width(76),
                                              height: width(60),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: width(8)),
                                              child: Text(
                                                  videoPageTranslations[
                                                          'invite_friends']
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: controller
                                                          .currentCustomThemeData()
                                                          .colors0x333333,
                                                      fontSize: sp(28))),
                                            )
                                          ],
                                        ),
                                      )),
                                      Expanded(
                                          child: InkWell(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.inviteFriends);
                                        },
                                        child: Container(),
                                      )),
                                      // Expanded(
                                      //     child: InkWell(
                                      //   onTap: () {
                                      //     Get.toNamed(AppRoutes.inviteFriends);
                                      //   },
                                      //   child: Container(),
                                      // ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: width(34),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )));
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Stack(
              //overflow: Overflow.visible,// 该属性已经废弃
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: width(130),
                  height: width(130),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: controller
                            .currentCustomThemeData()
                            .colors0x000000_20!,
                        offset: const Offset(2, 4),
                        blurRadius: 6,
                      ),
                    ],
                    border: Border.all(
                      color: controller.currentCustomThemeData().colors0xFFFFFF,
                      width: 2,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: OLImage(
                        imageUrl: controller.userInfo.value.avatar ?? ""),
                  ),
                ),
                Positioned(
                  left: width(5),
                  bottom: -width(6),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.editInformation);
                    },
                    child: Container(
                      width: width(120),
                      height: width(34),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(width(17))),
                          color: controller
                              .currentCustomThemeData()
                              .colors0x9F44FF),
                      alignment: Alignment.center,
                      child: Text(videoPageTranslations['edit_data'].toString(),
                          style: TextStyle(
                              color: controller
                                  .currentCustomThemeData()
                                  .colors0xFFFFFF,
                              fontSize: sp(24))),
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: width(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      (controller.userInfo.value.nickName?.isEmpty ?? true)
                          ? controller.userInfo.value.userAccount ?? ""
                          : controller.userInfo.value.nickName ?? "",
                      style: TextStyle(
                          color: controller
                              .currentCustomThemeData()
                              .colors0x000000,
                          fontWeight: FontWeight.bold,
                          fontSize: sp(32))),
                  Container(
                    margin: EdgeInsets.only(top: width(6)),
                    child: Text("ID:${controller.userInfo.value.accno ?? ""}",
                        style: TextStyle(
                            color: controller
                                .currentCustomThemeData()
                                .colors0x626262,
                            fontSize: sp(24))),
                  )
                ],
              ),
            )
          ],
        ),
        Row(
          children: const [],
        )
      ],
    );
  }

  Widget buildNumInfo() {
    var watchNum = int.tryParse(controller.limitWatchCount.value) ?? 0;
    var watchValue = "";
    if (watchNum >= 999) {
      watchValue = controller.videoPageString("watch_no_limit");
    } else {
      watchValue =
          "${controller.watchCount.value}/${controller.limitWatchCount.value}";
    }

    return Container(
      margin: EdgeInsets.only(top: width(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(watchValue,
                      style: TextStyle(
                          color: controller
                              .currentCustomThemeData()
                              .colors0x000000,
                          fontWeight: FontWeight.bold,
                          fontSize: sp(32))),
                  Container(
                    margin: EdgeInsets.only(top: width(12)),
                    child: Text(
                        videoPageTranslations['free_viewing'].toString(),
                        style: TextStyle(
                            color: controller
                                .currentCustomThemeData()
                                .colors0xB9B5C2,
                            fontWeight: FontWeight.bold,
                            fontSize: sp(28))),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("0/0",
                      style: TextStyle(
                          color: controller
                              .currentCustomThemeData()
                              .colors0x000000,
                          fontWeight: FontWeight.bold,
                          fontSize: sp(32))),
                  Container(
                    margin: EdgeInsets.only(top: width(12)),
                    child: Text(
                        videoPageTranslations['number_of_caches'].toString(),
                        style: TextStyle(
                            color: controller
                                .currentCustomThemeData()
                                .colors0xB9B5C2,
                            fontWeight: FontWeight.bold,
                            fontSize: sp(28))),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("0",
                      style: TextStyle(
                          color: controller
                              .currentCustomThemeData()
                              .colors0x000000,
                          fontWeight: FontWeight.bold,
                          fontSize: sp(32))),
                  Container(
                    margin: EdgeInsets.only(top: width(12)),
                    child: Text(
                        videoPageTranslations['viewing_ticket'].toString(),
                        style: TextStyle(
                            color: controller
                                .currentCustomThemeData()
                                .colors0xB9B5C2,
                            fontWeight: FontWeight.bold,
                            fontSize: sp(28))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFunctions() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(Assets.videoPage.mineBgs.path),
        ),
      ),
      height: width(208),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: InkWell(
            onTap: () {
              Get.toNamed("/mineWallet");
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.videoPage.vIcon8.path,
                  width: width(96),
                  height: width(96),
                ),
                Container(
                  margin: EdgeInsets.only(top: width(6)),
                  child: Text(videoPageTranslations['wallet'].toString(),
                      style: TextStyle(
                          color: controller
                              .currentCustomThemeData()
                              .colors0x333333,
                          fontSize: sp(24))),
                )
              ],
            ),
          )),
          Expanded(
              child: InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.withdraw);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.videoPage.vIcon9.path,
                  width: width(96),
                  height: width(96),
                ),
                Container(
                  margin: EdgeInsets.only(top: width(6)),
                  child: Text(videoPageTranslations['withdrawal'].toString(),
                      style: TextStyle(
                          color: controller
                              .currentCustomThemeData()
                              .colors0x333333,
                          fontSize: sp(24))),
                )
              ],
            ),
          )),
          Expanded(
              child: InkWell(
            onTap: () {
              Get.toNamed("/activityCenter");
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.videoPage.vIcon10.path,
                  width: width(96),
                  height: width(96),
                ),
                Container(
                  margin: EdgeInsets.only(top: width(6)),
                  child: Text(
                      videoPageTranslations['activity_center'].toString(),
                      style: TextStyle(
                          color: controller
                              .currentCustomThemeData()
                              .colors0x333333,
                          fontSize: sp(24))),
                )
              ],
            ),
          )),
          Expanded(
              child: InkWell(
            onTap: () async {
              //Get.toNamed("/customerService");
              String url = UserManagerCache.shared.getNewOnlineUrl();
              await launchUrl(Uri.parse(url),
                mode: LaunchMode.externalApplication,);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.videoPage.vIcon11.path,
                  width: width(96),
                  height: width(96),
                ),
                Container(
                  margin: EdgeInsets.only(top: width(6)),
                  child: Text(
                      videoPageTranslations['exclusive_customer_service']
                          .toString(),
                      style: TextStyle(
                          color: controller
                              .currentCustomThemeData()
                              .colors0x333333,
                          fontSize: sp(24))),
                )
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget buildFuns() {
    final items = controller.functions.value;
    return GridView.count(
      crossAxisCount: 4,
      children: items.map((e) => Text("data111")).toList(),
    );
  }
}
