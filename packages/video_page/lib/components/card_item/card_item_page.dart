import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/image/ol_image.dart';
import 'package:video_page/components/card_item/card_item_controller.dart';
import 'package:video_page/video_utils.dart';

class CardView extends GetView<CardItemController> {
  final int num;
  final int videoId;

  /// 左上角icon类型 默认1=免费,2=VIP,3=收费(金币)
  final double cW;

  /// 卡片宽度
  final double cH;

  /// 卡片高度
  final String cover;

  /// 封面
  final String time;

  /// 时间
  final String likes;

  /// 点赞量
  final String title;

  /// 标题 最多8个字
  final bool flag;

  /// 是否展示底部title模块
  const CardView({
    Key? key,
    this.num = 1,
    this.cW = 340.0,
    this.cH = 195.0,
    this.cover = "",
    this.time = "",
    this.likes = "",
    this.title = "",
    this.flag = true,
    this.videoId = 1,
  }) : super(key: key);

  List<Widget> buildChildWidget(BuildContext context) {
    var controller = Get.put(CardItemController());
    if (videoId == 0) {
      return [
        Container(
            alignment: Alignment.centerLeft,
            clipBehavior: Clip.hardEdge,
            decoration: flag
                ? BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(width(10)),
                        topRight: Radius.circular(width(10))))
                : BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(width(10)))),
            child: Stack(
              children: [
                SizedBox(
                    width: width(double.parse(cW.toString())),
                    height: width(double.parse(cH.toString())),
                    child: OLImage(
                      imageUrl: cover,
                      fit: BoxFit.cover,
                      placeholderPath: Assets.videoPage.videoDefaultBanner.path,
                      errorBuilder: (context, error, stacktrace) =>
                          Assets.videoPage.videoDefaultBanner.image(
                        width: width(87),
                        height: width(87),
                      ),
                    )),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Assets.videoPage.videoDefaultBanner.image(
                    height: width(22),
                  ),
                ),
                Positioned(
                  left: -1,
                  top: -1,
                  child: SizedBox(
                      width: width(70),
                      height: width(28),
                      child: num == 2
                          ? Image.asset(Assets.videoPage.vipType.path)
                          : num == 3
                              ? Image.asset(Assets.videoPage.ff.path)
                              : Container()),
                ),
                Positioned(
                  left: 0,
                  bottom: 4,
                  child: Container(
                    width: width(double.parse(cW.toString())),
                    padding: EdgeInsets.symmetric(horizontal: width(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          time != 'null'
                              ? controller.formatDuration(int.parse(time))
                              : "",
                          style: TextStyle(
                              color: controller
                                  .currentCustomThemeData()
                                  .colors0xFFFFFF,
                              fontSize: sp(20)),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: width(8)),
                          height: width(26),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(width(40))),
                              color: controller
                                  .currentCustomThemeData()
                                  .colors0x000000_30,
                              border:
                                  Border.all(color: Colors.white, width: 1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: width(12),
                                  height: width(10),
                                  child: Image.asset(
                                      Assets.videoPage.vThumbs.path,
                                      fit: BoxFit.cover)),
                              Container(
                                margin: EdgeInsets.only(left: width(4)),
                                child: Text(
                                  likes,
                                  // + videoPageTranslations['ten_thousand'].toString(),
                                  style: TextStyle(
                                      color: controller
                                          .currentCustomThemeData()
                                          .colors0xFFFFFF,
                                      fontSize: sp(16)),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
        flag
            ? Container(
                height: width(50),
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: width(8), right: width(14)),
                decoration: BoxDecoration(
                    color: controller.currentCustomThemeData().colors0x18191D,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(width(10)),
                        bottomRight: Radius.circular(width(10)))),
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: height(34),
                  child: Text(
                    title,
                    maxLines: 2,
                    softWrap: true,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color:
                            controller.currentCustomThemeData().colors0xFFFFFF,
                        fontSize: sp(24)),
                  ),
                ),
              )
            : Container()
      ];
    }
    return [
      InkWell(
        onTap: () {
          Get.toNamed("/videoDetailPage", arguments: {"id": videoId});
        },
        child: Container(
            alignment: Alignment.centerLeft,
            clipBehavior: Clip.hardEdge,
            decoration: flag
                ? BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(width(10)),
                        topRight: Radius.circular(width(10))))
                : BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(width(10)))),
            child: Stack(
              children: [
                SizedBox(
                    width: width(double.parse(cW.toString())),
                    height: width(double.parse(cH.toString())),
                    child: OLImage(
                      imageUrl: cover,
                      fit: BoxFit.cover,
                      placeholderPath: Assets.videoPage.videoDefaultBanner.path,
                      errorBuilder: (context, error, stacktrace) =>
                          Assets.videoPage.videoDefaultBanner.image(
                        width: width(87),
                        height: width(87),
                      ),
                    )),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    /*child: Assets.videoPage.videoBlackBg.image(
                     height: width(42),
                     fit: BoxFit.cover,
                   ),*/
                    child: Container(
                      height: width(44),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(width(10)),
                              topRight: Radius.circular(width(10))),
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Color(0x7f000000), Color(0x00000000)])),
                    )),
                Positioned(
                  left: -1,
                  top: -1,
                  child: SizedBox(
                      width: width(70),
                      height: width(28),
                      child: num == 2
                          ? Image.asset(Assets.videoPage.vipType.path)
                          : num == 3
                              ? Image.asset(Assets.videoPage.ff.path)
                              : Container()),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 4,
                  child: Container(
                    width: width(double.parse(cW.toString())),
                    padding: EdgeInsets.symmetric(horizontal: width(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          time != 'null'
                              ? controller.formatDuration(int.parse(time))
                              : "",
                          style: TextStyle(
                              color: controller
                                  .currentCustomThemeData()
                                  .colors0xFFFFFF,
                              fontSize: sp(20)),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: width(8)),
                          height: width(26),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(width(40))),
                              color: controller
                                  .currentCustomThemeData()
                                  .colors0x000000_30,
                              border:
                                  Border.all(color: Colors.white, width: 1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: width(12),
                                  height: width(10),
                                  child: Image.asset(
                                      Assets.videoPage.vThumbs.path,
                                      fit: BoxFit.cover)),
                              Container(
                                margin: EdgeInsets.only(left: width(4)),
                                child: Text(
                                  likes,
                                  // + videoPageTranslations['ten_thousand'].toString(),
                                  style: TextStyle(
                                      color: controller
                                          .currentCustomThemeData()
                                          .colors0xFFFFFF,
                                      fontSize: sp(16)),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
      flag
          ? Container(
              height: width(50),
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: width(8), right: width(14)),
              decoration: BoxDecoration(
                  color: controller.currentCustomThemeData().colors0x18191D,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(width(10)),
                      bottomRight: Radius.circular(width(10)))),
              child: Container(
                alignment: Alignment.centerLeft,
                height: height(34),
                child: Text(
                  title,
                  maxLines: 2,
                  softWrap: true,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: controller.currentCustomThemeData().colors0xFFFFFF,
                      fontSize: sp(24)),
                ),
              ),
            )
          : Container()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Obx(() => SizedBox(
            width: width(cW),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: buildChildWidget(context),
            ),
          )),
    );
  }
}
