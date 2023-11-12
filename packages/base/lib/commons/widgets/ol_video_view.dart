import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:video_player_skin/fijkplayer_skin.dart';

import '../palyer/fijkplayer_panel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:io';
import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_page/video_cache/server.dart';
// import 'package:video_player/video_player.dart';
import 'package:video_page/video_cache/video_cache_server.dart';
import 'package:video_page/video_cache/cache_preview.dart';

const String PLAYER_FIJKPLAYER = 'fijkplayer';
const String PLAYER_VIDEOPLAYER = 'video_player';


typedef VideoPlayDurationCallback = Function(Duration duration);
typedef VideoBeginPlayStateCallback = Function(FijkState? state);

/// 视频播放视图 提供简单的播放控制 如果需要特殊需求 请按照这个方式进行处理
class OLVideoView extends StatefulWidget {
  OLVideoView({Key? key, this.durationCallback,this.bgIconUrl,this.titleName, this.playerStateCallback}) : super(key: key);
  String? videoUrl;
 final String? bgIconUrl;
 final String? titleName;
  _OLVideoViewState? state;
  final VideoPlayDurationCallback? durationCallback;
  final VideoBeginPlayStateCallback? playerStateCallback;
  @override
  _OLVideoViewState createState() => _OLVideoViewState();

  /// 设置播放地址
  void setVideoUrl(String url) {
    state?.setVideoUrl(url);
  }

  /// 开始播放
  Future<void> play() async {
    await state?.play();
  }

  /// 暂停播放
  Future<void> pause() async {
    await state?.pause();
  }

  /// 停止播放
  Future<void> stop() async {
    await state?.stop();
  }

  /// 重置播放
  Future<void> reset() async {
    await state?.reset();
  }

  /// 全屏设置
  void fullScreen(bool isFull) {
    state?.fullScreen(isFull);
  }

}

// 定制UI配置项
class PlayerShowConfig implements ShowConfigAbs {
  @override
  bool drawerBtn = false;
  @override
  bool nextBtn = false;
  @override
  bool speedBtn = true;
  @override
  bool topBar = true;
  @override
  bool lockBtn = false;
  @override
  bool autoNext = false;
  @override
  bool bottomPro = true;
  @override
  bool stateAuto = true;
  @override
  bool isAutoPlay = true;
  @override
  bool buyLock = false;
}

class _OLVideoViewState extends State<OLVideoView> {
  FijkPlayer? player;
  Timer? _timer;
  String playerType = PLAYER_FIJKPLAYER;
  VideoCacheServer? server;
  String? proxyUrl;

  ShowConfigAbs videoConfig = PlayerShowConfig();
  late final BaseCacheManager _cacheManager;

  @override
  void initState() {
    /// 设置日志模式
    FijkLog.setLevel(FijkLogLevel.Silent);
    super.initState();
    widget.state = this;
    super.initState();
    player = FijkPlayer();

    player?.addListener(() {
      log("======= player ${player?.state}");
      if (widget.playerStateCallback != null) {
          widget.playerStateCallback!(player?.state);
      }
    });

    player?.onCurrentPosUpdate.listen((event) {
      if (widget.durationCallback != null) {
        widget.durationCallback!(event);
      }
      log("======= player onCurrentPosUpdate ${event}");
    });

  }


  @override
  Widget build(BuildContext context) {
    // if(server == null) {
    //   return CircularProgressIndicator();
    // }
    return Container(
      alignment: Alignment.center,
      child: FijkView(
        player: player!,
        panelBuilder: (FijkPlayer player, FijkData data, BuildContext context,
            Size viewSize, Rect texturePos) {
          return FIJKPlayerPanel(player:player,buildContext: context,viewSize:viewSize,texturePos:texturePos);
        },
        fit: FijkFit.fitWidth,
        color: Colors.black,
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     alignment: Alignment.center,
  //     child: FijkView(
  //       color: Colors.black,
  //       fit: FijkFit.fitWidth,
  //       player: player!,
  //       panelBuilder: (
  //           FijkPlayer player,
  //           FijkData data,
  //           BuildContext context,
  //           Size viewSize,
  //           Rect texturePos,
  //           ) {
  //         /// 使用自定义的布局
  //         /// 精简模式，可不传递onChangeVideo
  //         return CustomFijkPanel(
  //           player: player!,
  //           viewSize: viewSize,
  //           texturePos: texturePos,
  //           pageContent: context,
  //           // 标题 当前页面顶部的标题部分
  //           playerTitle: "",
  //           // 当前视频源tabIndex
  //           curTabIdx: 0,
  //           // 当前视频源activeIndex
  //           curActiveIdx: 0,
  //           // 显示的配置
  //           showConfig: videoConfig,
  //
  //         );
  //       },
  //     ),
  //   );
  // }

  void setVideoUrl(String url) {
    widget.videoUrl = url;

    play();
  }

  Future<void> play() async {
    try {
      if (widget.videoUrl != null) {
        getTemporaryDirectory().then((tmpDir) {
          log("======= 拿到代理路经 ${tmpDir.path}/video_cache_server/");
          server = VideoCacheServer(httpClient: HttpClient(),port: 50007, cacheDir: '${tmpDir.path}/video_cache_server/')
            ..start().then((object) {
              var proxyUrl = object.getProxyUrl(widget.videoUrl!);
              playeStart(proxyUrl);
              log("======= 拿到路经 ${object}");
            });
        });

      }
    } catch(e) {
      log("视频播放出错");
    }
    if(widget.videoUrl != null) {
      log("走进缓存");
      Future.delayed(const Duration(milliseconds: 1000), () {

        //延时执行的代码
        CachePreview(widget.videoUrl!,widget.bgIconUrl,widget.titleName,server!,40);

      });
    }

  }

  getCachedForVideo(String url) async {
    final fileInfo = await _cacheManager.getFileFromCache(url);
    log("人才播放器地址${url}");
    if (fileInfo == null) {
      if (kDebugMode) {
        print('[VideoControllerService]: No video in cache');
      }

      if (kDebugMode) {
        print('[VideoControllerService]: Saving video to cache');
      }

      unawaited(_cacheManager.downloadFile(url));

      return "";
    } else {
      if (kDebugMode) {
        print('[VideoControllerService]: Loading video from cache');
      }

      log(' 视频缓存路经${fileInfo.file}');

      return fileInfo.file;
    }
  }
  void playeStart(String videoUrl) async {
    proxyUrl = videoUrl;
    await player?.setDataSource(videoUrl ?? "", autoPlay: true);
    await player?.prepareAsync();
    await player?.start();
    setState(() {

    });

  }
  Future<void> pause() async {
    if (proxyUrl != null) {
      final state = player?.state ?? FijkState.completed;
      if (state == FijkState.paused ||
          state == FijkState.completed ||
          state == FijkState.end ||
          state == FijkState.stopped ||
          state == FijkState.idle) {
        return;
      }
      await player?.pause();
    }
  }

  Future<void> stop() async {
    if (proxyUrl != null) {
      await player?.stop();
    }
  }

  Future<void> reset() async {
    if (proxyUrl != null) {
      await player?.reset();
    }
  }

  Future<void> seekTo(int msec) async {
    if (widget.videoUrl != null) {
      await player?.seekTo(msec);
    }
  }

  Future<void> setLoop(int count) async {
    if (proxyUrl != null) {
      await player?.setLoop(count);
    }
  }

  void fullScreen(bool isFull) {
    if (isFull) {
      player?.enterFullScreen();
    } else {
      player?.exitFullScreen();
    }
  }

  @override
  void dispose() {
    super.dispose();
    player?.release();
    // server?.stop();
    // server?.clear();
  }


}
