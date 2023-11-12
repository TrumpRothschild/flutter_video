import 'package:base/commons/utils/log_utils.dart';
import 'package:base/commons/widgets/ol_video_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:services/models/res/live/live_room_detail.dart';
import 'package:services/models/res/live/live_video_list_bean.dart';

import '../../agora/rtc_utils.dart';
import '../live_page.dart';
import 'loading_placeholder.dart';

/// 直播间直播+视频区域
class LiveVideo extends StatelessWidget {
   LiveVideo({Key? key}) : super(key: key);

  final LiveController _controller = Get.find<LiveController>();

  @override
  Widget build(BuildContext context) {
    LiveRoomDetail? roomDetail =_controller.roomDetailData.value;
    if (roomDetail?.studioType == 1) {
      // 真直播
      int remoteUid = _controller.remoteUid.value;
      if (remoteUid > 0) {
        return RTCUtils.remoteVideo(
            channelId: _controller.studioNum,
            remoteUid: _controller.remoteUid.value);
      } else {
        Log.d("直播加载中...");
        return LoadingPlaceholder(
            _controller, roomDetail?.studioThumbImage ?? "");
      }
    } else if (roomDetail?.studioType == 2) {
      // 伪直播
      // List<VideoList>? videoList = roomDetail?.videoList;
      List<LiveVideoListBean>? videoList;
      if (GetUtils.isNull(videoList) || videoList?.isEmpty == true) {
        Log.e("伪装直播内容为空...");
        return LoadingPlaceholder(
            _controller, roomDetail?.studioThumbImage ?? "");
      } else {
        LiveVideoListBean? videoBean = videoList?[0];
        var startPos = _controller.getLiveStartPosition(
            roomDetail?.sysTime ?? 0, roomDetail?.startTime ?? 0, videoBean);
        final videoView = OLVideoView(
          key: const Key("liveVideoPlayer"),
        );
        videoView.state?.setVideoUrl(videoBean?.url ?? "");
        // 全屏
        videoView.state?.fullScreen(true);
        // 开始位置
        videoView.state?.seekTo(startPos);
        // 无限循环
        videoView.state?.setLoop(0);
        videoView.state?.play();
        return SizedBox(child: videoView);
      }
    } else {
      // 无人直播
      var studioLivePath = roomDetail?.studioLivePath ?? "";
      if (studioLivePath.isEmpty == true) {
        Log.e("无人直播内容为空...");
        return LoadingPlaceholder(
            _controller, roomDetail?.studioThumbImage ?? "");
      } else {
        final videoView = OLVideoView(
          key: const Key("liveVideoPlayer"),
        );
        videoView.state?.setVideoUrl(studioLivePath);
        // 全屏
        videoView.state?.fullScreen(true);
        // 无限循环
        videoView.state?.setLoop(0);
        videoView.state?.play();
        return SizedBox(child: videoView);
      }
    }
  }
}
