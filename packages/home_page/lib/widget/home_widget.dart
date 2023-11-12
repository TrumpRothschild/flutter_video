import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:services/image/ol_image.dart';
import 'package:services/models/res/home/home_top_game_bean.dart';
import 'package:services/models/res/home/home_video_bean.dart';

class HomeWidget {
  static HomeWidget of() => HomeWidget();

  /// 首页grid列数和间距
  SliverGridDelegate getGridDelegate([count = 2]) =>
      SliverGridDelegateWithFixedCrossAxisCount(
          //设置列数
          crossAxisCount: count,
          //设置横向间距
          crossAxisSpacing: AppDimens.w_5,
          //设置主轴间距
          mainAxisSpacing: AppDimens.h_5);

  /// 顶部游戏列表item
  Widget topGameItem(HomeTopGameBean? item) {
    return InkWell(
      onTap: () {
        // 进入视频播放
        OLEasyLoading.showToast("游戏");
      },
      child: OLImage(
          imageUrl: item?.iconUrl ?? "",
          height: AppDimens.h_38,
          width: AppDimens.w_70),
    );
  }

  Widget topGameItem2(HomeTopGameBean? item) {
    return InkWell(
        onTap: () {
          // 进入视频播放
          OLEasyLoading.showToast("游戏");
        },
        child: Container(
            height: AppDimens.h_38,
            width: AppDimens.w_70,
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.w_5, vertical: AppDimens.h_5),
            child: OLImage(
                imageUrl: item?.iconUrl ?? "",
                fit: BoxFit.fitHeight,
                height: AppDimens.h_38,
                width: AppDimens.w_70),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.w_10))));
  }

  /// 星秀视频列表item
  Widget videoItem(GetXBaseController controller, HomeVideoBean? item) {
    var textColor = controller.currentCustomThemeData().colors0xFFFFFF;
    return InkWell(
        onTap: () {
          // 进入视频播放
          OLEasyLoading.showToast("视频播放");
        },
        child: Container(
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                OLImage(
                    imageUrl: item?.thumbUrl ?? "",
                    width: double.infinity,
                    height: double.infinity),
                Positioned(
                    child: Text(
                      item?.title ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: textColor, fontSize: FontDimens.fontSp12),
                    ),
                    bottom: AppDimens.h_8,
                    left: AppDimens.w_4)
              ],
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.w_10))));
  }

  /// 热门视频列表item
  Widget hotVideoItem(HomeVideoBean? item) {
    return InkWell(
        onTap: () {
          // 进入视频播放
          OLEasyLoading.showToast("视频播放");
        },
        child: Container(
            clipBehavior: Clip.hardEdge,
            width: AppDimens.w_90,
            margin: const EdgeInsets.only(right: AppDimens.w_5),
            alignment: AlignmentDirectional.bottomStart,
            child:
                OLImage(imageUrl: item?.thumbUrl ?? "", width: double.infinity),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.w_10))));
  }

  /// 子标题
  Widget subtitle(GetXBaseController controller, String iconPath, String title,
          {bool changeData = false, VoidCallback? onPressed}) =>
      Row(children: [
        const SizedBox(width: AppDimens.w_10),
        AssetGenImage(iconPath)
            .image(width: AppDimens.w_24, height: AppDimens.w_24),
        const SizedBox(width: AppDimens.w_5),
        Text(controller.homePageString(title),
            style: TextStyle(
                color: controller.currentCustomThemeData().colors0x000000,
                fontSize: FontDimens.fontSp15)),
        const Expanded(
          flex: 1,
          child: Text(""),
        ),
        Visibility(
          child: Container(
            height: AppDimens.h_24,
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.w_10),
            alignment: AlignmentDirectional.center,
            child: OutlinedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                  textStyle: MaterialStateProperty.all(
                      const TextStyle(fontSize: FontDimens.fontSp14)),
                  foregroundColor: MaterialStateProperty.all(
                      controller.currentCustomThemeData().colors0x9F44FF),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimens.w_28))),
                  //圆角弧度
                  side: MaterialStateProperty.all(BorderSide(
                      color:
                          controller.currentCustomThemeData().colors0x9F44FF))),
              child: Text(controller.homePageString('change_data')),
            ),
          ),
          visible: changeData,
        ),
      ]);
}
