// import 'package:device_info_plus/device_info_plus.dart';
import 'dart:developer';

import 'package:base/app_doamin.dart';
import 'package:base/app_event_bus.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/commons/widgets/ol_video_view.dart';
import 'package:base/translations/zh-Hans/zh_cn_video_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';
import 'package:services/api/video_apis.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/models/event/video_paly_event.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/user/user_detail_model.dart';
import 'package:services/models/res/video/comment_model.dart';
import 'package:services/models/res/video/video_detail_model.dart';
import 'package:services/models/res/video/video_page_list_model.dart';
import 'package:services/provider/user_provider.dart';
import 'package:wakelock/wakelock.dart';

/// 播放器状态
enum VideoPlayState {
  init, // 初始化状态
  prepare,
  playing,
  pause,
}

class VideoDetailController extends GetXBaseController
    with WidgetsBindingObserver {
  RxString titleString = "home".obs;

  RxInt currentType = 1.obs;
  RxBool playing = false.obs;

  /// 播放器状态
  var playState = VideoPlayState.init.obs;

  var isReport = false;
  var videoInfo = Rx<VideoDetailModel>(VideoDetailModel());
  var detailPanel = Rx<VideoPageListModel>(VideoPageListModel());
  var commentPanel = Rx<VideoPageListModel>(VideoPageListModel());

  // 判断当前是否是忙状态 主要处理多次点击使用
  var isBusyForCollect = false;

  /// 强制刷新
  var refreshCount = 0.obs;
  RxList<Video> recommendList = RxList<Video>();
  RxList<CommentModel> commentList = RxList<CommentModel>();
  var replayInfo = Rx<CommentModel>(CommentModel());
  var replayInfo2 = Rx<NextList>(NextList());
  RxString content = "".obs;
  final titleCtr = TextEditingController();
  final FocusNode titleFocus = FocusNode();
  var userInfo = UserDetailModel().obs;
  RxString limitWatchCount = "0".obs;
  OLVideoView? videoBox;

  /// 限制观看次数
  RxString watchCount = "0".obs;

  /// 当天观看次数
  RxInt surplusTime = 0.obs;

  /// 剩余播放次数

  /// 当天观看次数
  RxInt videoId = 2.obs;
  RxInt currentUrlType = 1.obs;
  RxString currentUrl =
      "https://8.thehanju.com/file/bz2022/2022/snxq/snxq02/playlista.m3u8".obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  RxBool isLoading = false.obs;
  RxBool isDetailLoading = true.obs;
  RxInt page = 1.obs;
  RxString bgIconString = "0".obs;



  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    Log.d('后台拉起 app：$state');
    if (state == AppLifecycleState.resumed) {
      Log.d('后台拉起 app：播放视频');
      if (playState.value == VideoPlayState.pause) {
        Log.d('后台拉起 app1：播放视频');
        videoBox?.play();
      }
    } else if (state == AppLifecycleState.paused) {
      Log.d('app 进入后台：暂停视频');
      if (playState.value == VideoPlayState.playing) {
        Log.d('app 进入后台1：暂停视频');
        videoBox?.pause();
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void onInit() {
    // videoId.value = int.parse(Get.arguments?["id"].toString());
    Wakelock.enable();
    WidgetsBinding.instance?.addObserver(this);
    super.onInit();
  }

  @override
  void onReady() {
    int id1 = Get.arguments?["id"] ?? 0;
    play(id1);
  }

  @override
  void onClose() {
    WidgetsBinding.instance?.removeObserver(this);
    Wakelock.disable();
  }

  void play(int ids) {
    if (videoBox != null) {
      videoBox?.reset();
      playState.value = VideoPlayState.init;
    }
    videoId.value = ids;
    playing.value = false;
    // 调用
    getInit();
    getTime();
    getUserInfo();
    getDetailPanel();
    getVideoRecommend();
    getComment(1);
  }

  getTime() async {
    try {
      BaseResponse response =
          await VideoApis.of.call().videoWatchRecordStatistics();
      log('火星黑洞');
      log(response.data.toString());
      limitWatchCount.value =
          response.data["limitWatchCount"].toString() != 'null'
              ? response.data["limitWatchCount"].toString()
              : '0';
      watchCount.value = response.data["watchCount"].toString() != 'null'
          ? response.data["watchCount"].toString()
          : '0';
      surplusTime.value =
          int.parse(limitWatchCount.value) - int.parse(watchCount.value);
      update();
    } catch (e) {
      log(e.toString());
    }
  }

  getUserInfo() async {
    UserProvider.getUserInfo().then((value) {
      if (value == null) {
        Log.e("用户信息为空！");
        return;
      }
      userInfo.value = value;
      update();
      UserManagerCache.shared.setUserDetail(value);
    });
  }

  /// 关键字搜索
  setTitle(String text) {
    content.value = text;
    update();
  }

  getDetailPanel() async {
    try {
      BaseResponse response = await VideoApis.of.call().detailPanel();
      log('面板');
      log(response.data.toString());
      final commentPanels = response.data["commentPanel"];
      final detailPanels = response.data["detailPanel"];
      if (commentPanels != null) {
        commentPanel.value =
            VideoPageListModel.fromJson(response.data["commentPanel"]);
      }
      if (detailPanels != null) {
        detailPanel.value =
            VideoPageListModel.fromJson(response.data["detailPanel"]);
      }
      isDetailLoading.value = false;
      log('面板2');
    } catch (e) {
      isDetailLoading.value = false;
      log(e.toString());
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        update();
      });
    }
  }

  filterTime(String time) {
    if (time == 'null') {
      return "";
    } else {
      return time.split("T")[0].replaceAll("T", " ");
    }
  }

  replay(CommentModel item) {
    replayInfo2 = Rx<NextList>(NextList());
    replayInfo.value = item;
    refreshCount.value = refreshCount.value + 1;
    log(replayInfo.value.toString());
  }

  replay2(NextList item) {
    replayInfo = Rx<CommentModel>(CommentModel());
    refreshCount.value = refreshCount.value + 1;
    replayInfo2.value = item;
    log(replayInfo2.value.commentId.toString());
  }

  delete(CommentModel item) async {
    try {
      BaseResponse response = await VideoApis.of.call().deleteComment({
        "videoId": videoId.value,
        "commentId": item.id,
      });
      log('评论内容');
      log(response.data.toString());
      log('评论内容2');
      if (response.code == 200) {
        deleteComment();
        getComment(1);
      }
      update();
    } catch (e) {
      log(e.toString());
    }
  }

  addComment() {
    final videoInfo1 = videoInfo.value;
    int count = (videoInfo1.commentNumber ?? 0) + 1;
    if (count <= 0) {
      count = 0;
    }
    videoInfo1.commentNumber = count;
    videoInfo.value = videoInfo1;
  }

  deleteComment() {
    final videoInfo1 = videoInfo.value;
    int count = (videoInfo1.commentNumber ?? 0) - 1;
    if (count <= 0) {
      count = 0;
    }
    videoInfo1.commentNumber = count;
    videoInfo.value = videoInfo1;
  }

  delete2(NextList item) async {
    try {
      BaseResponse response =
          await VideoApis.of.call().videoCommentReplyDelete({
        "replyId": item.id,
        "commentId": item.commentId,
      });
      log('评论内容');
      log(response.data.toString());
      log('评论内容2');
      if (response.code == 200) {
        // deleteComment();
        getComment(1);
      }
      update();
    } catch (e) {
      log(e.toString());
    }
  }

  showNext(CommentModel item) async {
    try {
      item.nextList = RxList<NextList>();
      BaseResponse response = await VideoApis.of.call().videoCommentReplyList({
        "videoId": videoId.value,
        "pageSize": 10,
        "commentId": item.id,
        "replyId": 0
      });
      log('评论回复');
      log(response.data.toString());
      log('火星黑洞9');
      log(item.nextList.toString());
      var list =
          (response.data as List).map((e) => NextList.fromJson(e)).toList();
      log(list.toString());
      item.nextList?.addAll(list);
      log(item.nextList.toString());
      commentList.refresh();
      update();
    } catch (e) {
      log(e.toString());
    }
  }

  sendComment() async {
    if (content.value.isNotEmpty) {
      final _isNotEmpty1 = (replayInfo.value.userAvatar ?? "").isNotEmpty;
      final _isNotEmpty2 = (replayInfo2.value.userAvatar ?? "").isNotEmpty;

      if (_isNotEmpty1 || _isNotEmpty2) {
        var commentId = replayInfo.value.userAvatar.toString().isNotEmpty &&
                replayInfo.value.userAvatar.toString() != 'null'
            ? replayInfo.value.id
            : replayInfo2.value.commentId;
        var replyNickName = replayInfo.value.userAvatar.toString().isNotEmpty &&
                replayInfo.value.userAvatar.toString() != 'null'
            ? replayInfo.value.nickName
            : replayInfo2.value.replyNickName;
        var replyUserId = replayInfo.value.userAvatar.toString().isNotEmpty &&
                replayInfo.value.userAvatar.toString() != 'null'
            ? replayInfo.value.createBy
            : replayInfo2.value.createBy;
        try {
          BaseResponse response = await VideoApis.of.call().replyComment({
            "videoId": videoId.value,
            'videoTitle': videoInfo.value.title ?? '',
            "content": content.value,
            "commentId": commentId,
            "pid": replayInfo.value.userAvatar.toString().isNotEmpty &&
                    replayInfo.value.userAvatar.toString() != 'null'
                ? 0
                : replayInfo2.value.pid,
            "replyNickName": replyNickName,
            "replyUserId": replyUserId,
          });
          log('评论内容');
          log(response.data.toString());
          log('评论内容2');
          if (response.code == 200) {
            if (response.data == -1) {
              OLEasyLoading.showToast('内容包含敏感词，请调整');
              return;
            }
            replayInfo = Rx<CommentModel>(CommentModel());
            content.value = "";
            titleCtr.text = "";
            // addComment();
            getComment(1);
          }
          update();
        } catch (e) {
          log(e.toString());
        }
      } else {
        try {
          BaseResponse response = await VideoApis.of.call().comment({
            "videoId": videoId.value,
            "content": content.value,
            'videoTitle': videoInfo.value.title ?? '',
          });
          log('评论内容');
          log(response.data.toString());
          log('评论内容2');
          if (response.code == 200) {
            if (response.data == -1) {
              OLEasyLoading.showToast('内容包含敏感词，请调整');
              return;
            }
            content.value = "";
            titleCtr.text = "";
            getComment(1);
            addComment();
          }
          update();
        } catch (e) {
          log(e.toString());
        }
      }
    } else {
      OLEasyLoading.showToast(
          videoPageTranslations['please_do_you_want_to_say'].toString());
    }
  }

  follow(CommentModel item) async {
    if (item.likes == true) {
      try {
        BaseResponse response = await VideoApis.of
            .call()
            .videoCommentLike({"videoId": videoId.value, "commentId": item.id});
        log('评论');
        log(response.data.toString());
        log('火星黑洞3');
        item.likes = false;
        commentList.refresh();
      } catch (e) {
        log(e.toString());
      }
    } else {
      try {
        BaseResponse response = await VideoApis.of
            .call()
            .videoCommentLike({"videoId": videoId.value, "commentId": item.id});
        log('评论');
        log(response.data.toString());
        log('火星黑洞3');
        item.likes = true;
        commentList.refresh();
      } catch (e) {
        log(e.toString());
      }
    }
  }

  follow2(NextList item) async {
    if (item.likes == true) {
      try {
        BaseResponse response = await VideoApis.of.call().videoCommentReplyLike(
            {"videoId": videoId.value, "replyId": item.id});
        log('评论');
        log(response.data.toString());
        log('火星黑洞3');
        item.likes = false;
        commentList.refresh();
      } catch (e) {
        log(e.toString());
      }
    } else {
      try {
        BaseResponse response = await VideoApis.of.call().videoCommentReplyLike(
            {"videoId": videoId.value, "replyId": item.id});
        log('评论');
        log(response.data.toString());
        log('火星黑洞3');
        item.likes = true;
        commentList.refresh();
      } catch (e) {
        log(e.toString());
      }
    }
  }

  report2(NextList item) async {
    if (item.report == true) {
      try {
        BaseResponse response = await VideoApis.of
            .call()
            .videoCommentReplyReport(
                {"videoId": videoId.value, "replyId": item.id});
        log('评论');
        log(response.data.toString());
        log('火星黑洞3');
        item.report = false;
        commentList.refresh();
      } catch (e) {
        log(e.toString());
      }
    } else {
      try {
        BaseResponse response = await VideoApis.of
            .call()
            .videoCommentReplyReport(
                {"videoId": videoId.value, "replyId": item.id});
        log('评论');
        log(response.data.toString());
        log('火星黑洞3');
        item.report = true;
        commentList.refresh();
      } catch (e) {
        log(e.toString());
      }
    }
  }

  report(CommentModel item) async {
    if (item.report == true) {
      try {
        BaseResponse response = await VideoApis.of.call().videoCommentReport(
            {"videoId": videoId.value, "commentId": item.id});
        log('评论');
        log(response.data.toString());
        log('火星黑洞3');
        item.report = false;
        commentList.refresh();
      } catch (e) {
        log(e.toString());
      }
    } else {
      try {
        BaseResponse response = await VideoApis.of.call().videoCommentReport(
            {"videoId": videoId.value, "commentId": item.id});
        log('评论');
        log(response.data.toString());
        log('火星黑洞3');
        item.report = true;
        commentList.refresh();
      } catch (e) {
        log(e.toString());
      }
    }
  }

  getComment(int pageNum) async {
    try {
      isLoading.value = true;
      page.value = pageNum;
      if (pageNum == 1) {
        commentList.clear();
      }
      BaseResponse response = await VideoApis.of.call().videoComment({
        "videoId": videoId.value,
        "pageSize": 10,
        "commentId": pageNum == 1 ? null : commentList.last.id
      });
      log('评论');
      log(response.data.toString());
      log('火星黑洞3');
      var list =
          (response.data as List).map((e) => CommentModel.fromJson(e)).toList();
      commentList.addAll(list);
      refreshController.refreshCompleted();
      refreshController.loadComplete();
      if (list.length < 10) {
        refreshController.loadNoData();
      }
      isLoading.value = false;
      update();
    } catch (e) {
      log(e.toString());
    }
  }

  getInit() async {
    try {
      BaseResponse response =
          await VideoApis.of.call().videoDetail({"videoId": videoId.value});
      Log.d("视频详情：【${response.data.toString()}】");
      var res = VideoDetailModel.fromJson(response.data);
      videoInfo.value = res;
      log(videoInfo.value.title.toString());
      videoInfo.value.resolutionRatios?.forEach((element) {
        currentUrl.value = element.url.toString();
        currentUrlType.value = element.type as int;
      });
      bgIconString.value = res.cover.toString();
      titleString.value = res.title.toString();
      log('视频名字${titleString}');
      // var list = (response.data as List).map((e) => VideoCategoryModel.fromJson(e)).toList();
      update();
    } catch (e) {
      Log.e("视频详情异常：【${e.toString()}】");
    }
  }

  getVideoRecommend() async {
    try {
      recommendList.clear();
      BaseResponse response =
          await VideoApis.of.call().videoRecommend({"videoId": videoId.value});
      log('火星黑洞2');
      log(response.data.toString());
      var list = (response.data as List).map((e) => Video.fromJson(e)).toList();
      recommendList.addAll(list);
      update();
    } catch (e) {
      log(e.toString());
    }
  }

  videoCollect() async {
    if (isBusyForCollect) {
      return;
    }
    if (videoInfo.value.likeFlag == false) {
      isBusyForCollect = true;

      /// 收藏
      try {
        BaseResponse response = await VideoApis.of.call().videoCollect(
            {"videoId": videoId.value, "title": videoInfo.value.title});
        log('火星黑洞3');
        log(response.data.toString());
        if (response.data) {
          videoInfo.value.likeFlag = true;
          videoInfo.value.likeNumber =
              int.parse(videoInfo.value.likeNumber.toString()) + 1;
          videoInfo.refresh();
          isBusyForCollect = false;
        }
        update();
      } catch (e) {
        log(e.toString());
      }
    } else {
      /// 取消收藏
      try {
        isBusyForCollect = true;
        BaseResponse response = await VideoApis.of
            .call()
            .videoUnCollect({"videoIds": videoId.value});
        log('火星黑洞3');
        log(response.data.toString());
        if (response.data) {
          videoInfo.value.likeFlag = false;
          int likeNum = int.parse(videoInfo.value.likeNumber.toString()) - 1;
          if (likeNum < 0) {
            likeNum = 0;
          }
          videoInfo.value.likeNumber = likeNum;
          videoInfo.refresh();
          isBusyForCollect = false;
        }
        update();
      } catch (e) {
        log(e.toString());
      }
    }
  }

  download() async {
    try {
      BaseResponse response =
          await VideoApis.of.call().download({"videoId": videoId.value});
      log('火星黑洞4');
      log(response.data.toString());
      if (response.data) {
        OLEasyLoading.showToast(
            videoPageTranslations['cache_success'].toString());
      }
      update();
    } catch (e) {
      log(e.toString());
    }
  }

  shareLink() {
    Clipboard.setData(
        ClipboardData(text: videoInfo.value.linkAddress.toString()));
    OLEasyLoading.showToast(
        videoPageTranslations['share_link_copy'].toString());
  }

  setCurrentType(int index) {
    currentType.value = index;
    update();
  }

  changePlay(box) async {
    if (surplusTime.value > 0) {
      playState.value = VideoPlayState.prepare;
      if (playing.value == false) {
        videoWatch(box);
      }
    } else {
      OLEasyLoading.showToast(
          videoPageTranslations['you_have_run_out_of_movie_viewing_times']
              .toString());
    }
  }

  videoWatch(box) async {
    try {
      var params = {
        "videoId": videoId.value,
        "resoRatioType": currentUrlType.value,
      };
      BaseResponse response = await VideoApis.of.call().videoWatch(params);
      log(response.data.toString());
      if (response.code == 200) {
        currentUrl.value =
            AppDomain.baseUrl + "/upload/v1/play/${response.data}";
        // currentUrl.value = "https://8.thehanju.com/file/bz2022/2022/snxq/snxq03/playlista.m3u8";
        playing.value = true;
        eventBus.fire(VideoPlayEvent(
          videoInfo.value.id!,
          videoInfo.value.cover!,
          videoInfo.value.title!,
        ));
        await box.state?.pause();
        box.state?.setVideoUrl(currentUrl.value);
        log('火星黑洞 播放地址:${currentUrl.value}');
        await box.state?.play();
        update();
      }
    } catch (e) {
      Log.e("播放异常【${e.toString()}】");
    }
  }

  recordWatch() async {
    try {
      isReport = true;
      BaseResponse response = await VideoApis.of.call().recordWatch({
        "videoId": videoId.value,
        "resoRatioType": currentUrlType.value,
      });
      log('火星黑洞4');
      log(response.data.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}
