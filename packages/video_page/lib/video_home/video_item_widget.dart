import 'package:base/app_routes.dart';
import 'package:base/assets.gen.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:power_image/power_image.dart';
import 'package:services/image/ol_image.dart';
import 'package:services/models/res/video/video_bean.dart';
import 'package:video_page/video_home/video_home_controller.dart';

import '../video_utils.dart';

/// 视频item
class VideoItemWidget extends StatelessWidget {
  final double coverWidth;
  final double coverHeight;
  final VideoBean? video;

  final VideoHomeController _controller = Get.find<VideoHomeController>();

  VideoItemWidget({
    Key? key,
    required this.video,
    required this.coverWidth,
    required this.coverHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.videoDetailPage,
              arguments: {"id": video?.videoId});
        },
        child: SizedBox(
          width: coverWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: coverHeight,
                width: coverWidth,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppDimens.w_5)),
                child: Stack(
                  children: [
                    PowerImage.network(
                      video?.cover ?? "",
                      width: coverWidth,
                      height: coverHeight,
                      fit: BoxFit.cover,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 收费类型
                        _priceTypeWidget(video?.priceType ?? 1),
                        // 时长 点赞
                        _timeAndLikes()
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimens.h_4),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  ((video?.title?.isNotEmpty ?? false) &&
                          video?.title != 'null')
                      ? (video?.title ?? '')
                      : "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: FontDimens.fontSp14,
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget _priceTypeWidget(int priceType) {
    if (priceType == 2) {
      //2=VIP
      return Image.asset(Assets.videoPage.vipType.path,
          width: AppDimens.w_36, height: AppDimens.h_14);
    } else if (priceType == 3) {
      //3=收费(金币)
      return Image.asset(Assets.videoPage.ff.path,
          width: AppDimens.w_36, height: AppDimens.h_14);
    } else {
      //默认1=免费
      return const SizedBox();
    }
  }

  Widget _timeAndLikes() {
    var times = VideoUtils.formatDuration(video?.duration ?? 0);
    var likes = VideoUtils.formatLikes(video?.likeNumber ?? 0);
    var customTheme = _controller.currentCustomThemeData();
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.w_4, vertical: AppDimens.h_8),
      decoration: const BoxDecoration(
          borderRadius:
              BorderRadius.vertical(bottom: Radius.circular(AppDimens.w_5)),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0x00000000),
                Color(0x80000000),
              ],
              stops: [
                0,
                1,
              ])),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            times,
            style: const TextStyle(
                color: Colors.white, fontSize: FontDimens.fontSp12),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.w_4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.w_20),
                color: customTheme.colors0x000000_30,
                border: Border.all(color: Colors.white, width: 0.5)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Assets.videoPage.vThumbs.path,
                    fit: BoxFit.cover,
                    width: AppDimens.w_8,
                    height: AppDimens.w_8),
                Text(
                  likes,
                  style: const TextStyle(
                      color: Colors.white, fontSize: FontDimens.fontSp10),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
