import 'dart:convert';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:base/app_config.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:flutter/cupertino.dart';

/// RTC 帮助类
class RTCUtils {
  static late RtcEngine _rtcEngine;

  /// 初始化rtc
  static Future<void> initRtc() async {
    try {
      //创建RtcEngine
      _rtcEngine = createAgoraRtcEngine();
      // 初始化
      await _rtcEngine.initialize(RtcEngineContext(
          appId: AppConfig.appId,
          // 频道使用场景，直播 BROADCASTING
          channelProfile: ChannelProfileType.channelProfileLiveBroadcasting));
      SDKBuildInfo buildInfo = await _rtcEngine.getVersion();
      Log.d("RTC版本：${buildInfo.version}");
      Log.d("初始化RTC成功！");
    } catch (error) {
      Log.e("初始化RTC失败！【$error】");
    }
  }

  /// 加入直播频道
  static Future<void> joinChannel(
      {required String token,
      required String channelId,
      required int uid,
      String encryptionKey = "",
      String encryptionSalt = "",
      int videoSize = 1,
      required Function(int) joinedCallback,
      required Function() offlineCallback}) async {
    try {
      // 注册回调事件handler
      _rtcEngine.registerEventHandler(
          _getEventHandler(joinedCallback, offlineCallback));
      // 设置角色,观众
      _rtcEngine.setClientRole(role: ClientRoleType.clientRoleAudience);
      // 设置分辨率
      await _rtcEngine.setVideoEncoderConfiguration(_getViewConfig(videoSize));
      // 启用视频模块
      await _rtcEngine.enableVideo();
      // 开启加密
      if (encryptionKey.isNotEmpty && encryptionSalt.isNotEmpty) {
        await _rtcEngine.enableEncryption(
            enabled: true,
            config: _encryptionConfig(encryptionKey, encryptionSalt));
      }
      // 加入频道
      await _rtcEngine.joinChannel(
          token: token,
          channelId: channelId,
          uid: uid,
          options: const ChannelMediaOptions());
    } catch (e) {
      Log.e("加入频道失败！【$e】");
    }
  }

  /// 设置视频分辨率
  static VideoEncoderConfiguration _getViewConfig(int size) {
    VideoDimensions dimensions = const VideoDimensions(width: 640, height: 360);
    if (size == 0) {
      // 1080p
      dimensions = const VideoDimensions(width: 1920, height: 1080);
    } else if (size == 1) {
      // 720p
      dimensions = const VideoDimensions(width: 960, height: 720);
    } else if (size == 2) {
      // 480p
      dimensions = const VideoDimensions(width: 640, height: 480);
    } else if (size == 3) {
      // 360p
      dimensions = const VideoDimensions(width: 640, height: 360);
    } else {
      // 720p
      dimensions = const VideoDimensions(width: 960, height: 720);
    }
    return VideoEncoderConfiguration(dimensions: dimensions);
  }

  /// 加密config
  static _encryptionConfig(String? encryptionKey, String encryptionSalt) {
    Uint8List uint8List = base64Decode(encryptionSalt);
    return EncryptionConfig(
        encryptionKdfSalt: uint8List,
        encryptionKey: encryptionKey,
        encryptionMode: EncryptionMode.aes128Gcm2);
  }

  /// 回调事件
  static RtcEngineEventHandler _getEventHandler(
      Function(int) joinedCallback, Function() offlineCallback) {
    return RtcEngineEventHandler(
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
      Log.d("用户RTC频道成功:【channel:${connection.toJson()}，remoteUid：$remoteUid】");
      joinedCallback(remoteUid);
    }, onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
      Log.d("加入RTC频道成功:【channel:${connection.toJson()} 】");
    }, onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
      Log.d(
          "离开RTC频道成功:【channel:${connection.toJson()}，remoteUid：$remoteUid, reason:$reason】");
      offlineCallback();
    }, onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
      Log.e("Token即将过期");
    }, onEncryptionError:
            (RtcConnection connection, EncryptionErrorType errorType) {
      var errorStr = "加密错误";
      switch (errorType) {
        case EncryptionErrorType.encryptionErrorInternalFailure:
          {
            errorStr = "内部原因";
          }
          break;
        case EncryptionErrorType.encryptionErrorDecryptionFailure:
          {
            errorStr = "解密错误";
          }
          break;
        default:
          {
            errorStr = "加密错误";
          }
          break;
      }
      Log.e("加密出错:【$errorStr】");
    });
  }

  ///释放资源
  static Future<void> release() async {
    await _rtcEngine.leaveChannel();
  }

  /// 设置远端视频
  static Widget remoteVideo(
      {required String channelId, required int remoteUid}) {
    return AgoraVideoView(
      controller: VideoViewController.remote(
        rtcEngine: _rtcEngine,
        canvas: VideoCanvas(uid: remoteUid),
        connection: RtcConnection(channelId: channelId),
      ),
    );
  }
}
