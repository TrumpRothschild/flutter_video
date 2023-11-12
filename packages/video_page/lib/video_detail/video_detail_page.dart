import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/screen.dart';
import 'package:base/commons/widgets/ol_video_view.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:base/translations/zh-Hans/zh_cn_video_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/image/ol_image.dart';
import 'package:video_page/video_detail/video_detail_controller.dart';
import 'package:video_page/video_utils.dart';
import 'video_detail_widget.dart';
import 'package:fijkplayer/fijkplayer.dart';

class VideoDetailPage extends GetView<VideoDetailController> {
  const VideoDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const videoKey = Key("videoPlayer");
    final videoView = OLVideoView(
      bgIconUrl: controller.bgIconString.value,
      titleName: controller.titleString.value,
      key: videoKey,
      durationCallback: (duration) {
        final config = UserManagerCache.shared.config;
        final freeWatch = config?.freeWatch ?? 10;
        if (duration.inSeconds > freeWatch && !controller.isReport) {
          controller.recordWatch();
        }
      },
      playerStateCallback: (state) {
        if (state == FijkState.started) {
          controller.playState.value = VideoPlayState.playing;
        }
      },
    );

    controller.videoBox = videoView;

    return Scaffold(
        backgroundColor: controller.currentCustomThemeData().colors0xFFFFFF,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: GetX<VideoDetailController>(
            init: controller,
            builder: (_) => Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// 播放器
                      buildPlayerView(controller, videoView),

                      /// tabbar
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          videoPageTranslations['details']
                                              .toString(),
                                          style: TextStyle(
                                              color: controller
                                                  .currentCustomThemeData()
                                                  .colors0x000000,
                                              fontSize: sp(28)),
                                        ),
                                      ),
                                      controller.currentType.value == 1
                                          ? Container(
                                              width: width(32),
                                              height: width(4),
                                              margin: EdgeInsets.only(
                                                  top: width(6)),
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4)),
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
                                              width: width(32),
                                              height: width(4),
                                              margin: EdgeInsets.only(
                                                  top: width(6)),
                                            )
                                    ],
                                  )),
                            ),
                            Expanded(
                              child: InkWell(
                                  onTap: () {
                                    controller.setCurrentType(2);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            videoPageTranslations['comment']
                                                .toString(),
                                            style: TextStyle(
                                                color: controller
                                                    .currentCustomThemeData()
                                                    .colors0x979797,
                                                fontSize: sp(28)),
                                          ),
                                          Container(
                                            margin:
                                                EdgeInsets.only(top: width(4)),
                                            child: Text(
                                              "(${controller.videoInfo.value.commentNumber ?? '0'})",
                                              style: TextStyle(
                                                  color: controller
                                                      .currentCustomThemeData()
                                                      .colors0x979797,
                                                  fontSize: sp(20)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      controller.currentType.value == 2
                                          ? Container(
                                              width: width(32),
                                              height: width(4),
                                              margin: EdgeInsets.only(
                                                  top: width(6)),
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(4)),
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
                                              width: width(32),
                                              height: width(4),
                                              margin: EdgeInsets.only(
                                                  top: width(6)),
                                            )
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ),

                      controller.isDetailLoading.value == true
                          ? _videoEmpty()
                          : VideoDetailWidget.of()
                              .buildDetailWidget(controller, context: context),

                      /// 评论
                    ],
                  ),
                )));
  }

  Widget buildVideoCoverWidget(VideoDetailController controller) {
    return Obx(() {
      String videoPath = Assets.videoPage.videoCover.path;
      String videoCover = (controller.videoInfo.value.cover ?? "");
      var isShowCover = (controller.playState.value == VideoPlayState.init ||
          controller.playState.value == VideoPlayState.prepare);
      var isShowLoading = false;
      if (controller.playState.value == VideoPlayState.prepare) {
        isShowLoading = true;
      }
      return isShowCover
          ? Positioned(
              left: width(0),
              width: width(750),
              height: width(420),
              top: width(0),
              child: Stack(
                children: [
                  SizedBox(
                    height: width(420),
                    width: width(750),
                    child: OLImage(
                      imageUrl: videoCover,
                      placeholderPath: videoPath,
                      height: width(420),
                      width: width(750),
                    ),
                  ),
                  SizedBox(
                    height: width(420),
                    width: width(750),
                    child: Container(color: const Color.fromRGBO(0, 0, 0, 0.5)),
                  ),
                  isShowLoading
                      ? const Center(
                          child: SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white)),
                        ))
                      : Container(),
                ],
              ),
            )
          : Container();
    });
  }

  Widget buildPlayButton(
      VideoDetailController controller, OLVideoView videoView) {
    var isPlayInit = controller.playState.value == VideoPlayState.init;
    var limitWatch = int.parse(controller.limitWatchCount.value);
    return isPlayInit
        ? Container(
            padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: InkWell(
                  onTap: () async {
                    final box = videoView;
                    controller.changePlay(box);
                  },
                  child: Image.asset(
                    Assets.videoPage.vPlayIcon.path,
                    fit: BoxFit.cover,
                    width: 40,
                    height: 40,
                  ),
                )),
                SizedBox(height: width(12)),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "${controller.videoPageString("today_watch_num")}：",
                      style: TextStyle(
                          color: controller
                              .currentCustomThemeData()
                              .colors0xFFFFFF,
                          fontSize: sp(24)),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      limitWatch >= 999
                          ? controller.videoPageString("watch_no_limit")
                          : controller.surplusTime.value.toString(),
                      style: TextStyle(
                          color: controller
                              .currentCustomThemeData()
                              .colors0xFFC700,
                          fontSize: sp(24)),
                    ),
                  ),
                ])
              ],
            ),
          )
        : Container();
  }

  Widget buildBackButton() {
    return Positioned(
      left: width(10),
      top: width(12),
      child: InkWell(
        onTap: () {
          Get.back();
        },
        child: Container(
            width: width(80),
            height: width(80),
            padding: EdgeInsets.only(right: 10),
            child: Image.asset(Assets.videoPage.vVideoBack.path,
                width: width(16), height: width(30))),
      ),
    );
  }

  Widget _videoEmpty() {
    return Expanded(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(Assets.videoPage.icVideoEmpty.path,
              width: AppDimens.w_126, height: AppDimens.h_100),
          const SizedBox(height: AppDimens.h_16),
          Text("正在加载中...",
              style: TextStyle(
                  color: controller.currentCustomThemeData().colors0xD6D6D6,
                  fontSize: FontDimens.fontSp12,
                  fontWeight: FontWeight.w400))
        ],
      ),
    ));
  }

  Widget buildPlayerView(
      VideoDetailController controller, OLVideoView videoView) {
    return SizedBox(
        width: width(750),
        height: width(420),
        child: Stack(
          children: [
            SizedBox(
              child: videoView,
            ),
            buildVideoCoverWidget(controller),
            buildBackButton(),
            buildPlayButton(controller, videoView),
          ],
        ));
  }
}
