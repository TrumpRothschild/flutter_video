import 'package:agora_rtm/agora_rtm.dart';
import 'package:base/app_config.dart';
import 'package:base/commons/utils/log_utils.dart';

/// RTM 帮助类
class RTMUtils {
  static late AgoraRtmClient _rtmClient;

  static final Map<String, AgoraRtmChannel> _channels = <String, AgoraRtmChannel>{};

  /// 初始化rtm
  static Future<void> initRtm() async {
    try {
      // sdk版本
      // String sdkVersion = await AgoraRtmClient.getSdkVersion();
      ///Log.d("RTM版本：$sdkVersion");
      //创建rtm实例
      _rtmClient = await AgoraRtmClient.createInstance(AppConfig.appId);
      // 设置日志级别
      //_rtmClient?.setLog(15, 512, "/bball/rtm.log");
      Log.d("初始化RTM成功！");
    } catch (error) {
      Log.e("初始化RTM失败！【$error】");
    }
  }

  /// 登录rtm
  static void login(String? token, String userId) async {
    try {
       await _rtmClient.login(token, userId);
      Log.d("RTM登录成功!");
    } catch (e) {
      Log.d("RTM登录失败：${e.toString()}");
    }
  }

  /// 退出登录
  static void logout() async {
    try {
      var res = await _rtmClient.logout();
      Log.d("RTM退出登录：${res.toString()}");
    } catch (e) {
      Log.d("RTM退出登录失败：${e.toString()}");
    }
  }

  /// 加入IM频道
  static void joinChannel({required String channelId,required Function(String) callback}) async {
    try {
      if (channelId.isEmpty) {
        Log.e("频道id不能为空！");
        return;
      }
      AgoraRtmChannel? _channel = _channels[channelId];
      if (_channel == null) {
        //创建频道
        _channel = await _rtmClient.createChannel(channelId);
        if (_channel == null) {
          Log.e("加入im频道失败！");
          return;
        }
        _channels[channelId] = _channel;
      }
      // 加入频道
      await _channel.join();
      // 加入
      _channel.onMemberJoined = (AgoraRtmMember member) {
        Log.d("加入im频道：userId：${member.userId}，channelId：${member.channelId}");
      };
      // 离开
      _channel.onMemberLeft = (AgoraRtmMember member) {
        Log.d("离开im频道：userId：${member.userId}，channelId：${member.channelId}");
      };
      // 接收消息
      _channel.onMessageReceived = (AgoraRtmMessage message, AgoraRtmMember member) {
        // Log.d("收到im消息：userId：${member.userId}，text：${message.text}");
        callback(message.text);
      };
    } catch (e) {
      Log.e("加入im频道失败【${e.toString()}】");
    }
  }

  /// 发送文本消息
  static void sendMessage(String channelId, String text) async {
    if (text.isEmpty) {
      Log.e("消息内容不能为空！");
      return;
    }
    try {
      AgoraRtmChannel? _channel = _channels[channelId];
      if (_channel == null) {
        Log.e("【$channelId】未加入频道");
        return;
      }
      await _channel.sendMessage(AgoraRtmMessage.fromText(text));
    } catch (error) {
      Log.e("发送【$channelId】频道消息失败！【$error】");
    }
  }

  /// 发送json消息
  static void sendJsonMessage(
      String channelId, Map<dynamic, dynamic> text) async {
    if (text.isEmpty) {
      Log.e("消息内容不能为空！");
      return;
    }
    try {
      AgoraRtmChannel? _channel = _channels[channelId];
      if (_channel == null) {
        Log.e("【$channelId】未加入频道");
        return;
      }
      await _channel.sendMessage(AgoraRtmMessage.fromJson(text));
    } catch (error) {
      Log.e("发送【$channelId】频道消息失败！【$error】");
    }
  }

  /// 离开RTM频道
  static void leaveChannel(String? channelId) async {
    try {
      if (channelId == null || channelId.isEmpty) {
        // 离开所有频道
        _channels.forEach((key, value) async {
          await value.leave();
        });
        _channels.clear();
      } else {
        // 离开指定频道
        await _channels[channelId]?.leave();
        _channels.remove(channelId);
      }
    } catch (error) {
      Log.e("离开RTM频道失败！【$error】");
    }
  }

  /// 释放资源
  static void releaseChannel(String channelId) async {
    if (channelId.isEmpty) {
      Log.e("频道id不能为空！");
      return;
    }
    await _rtmClient.releaseChannel(channelId);
  }
}
