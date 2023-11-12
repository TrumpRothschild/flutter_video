import 'dart:convert';

import 'package:base/commons/utils/log_utils.dart';
import 'package:get/get.dart';
import 'package:services/models/res/game/follow_bet_model.dart';
import 'package:services/models/res/game/niu_niu/niu_niu_model.dart';
import 'package:services/models/res/live/im_barrage_bean.dart';
import 'package:services/models/res/live/im_chat_bean.dart';
import 'package:services/models/res/live/im_enter_room_bean.dart';
import 'package:services/models/res/live/im_follow_bean.dart';
import 'package:services/models/res/live/im_gift_bean.dart';
import 'package:services/models/res/live/im_message_bean.dart';
import 'package:services/models/res/live/live_online_list_bean.dart';
import 'package:services/models/res/live/live_top50_user_bean.dart';

import '../live/live_page.dart';
import 'im_constant.dart';

/// im消息处理相关utils
class ImMsgUtils {
  static ImMsgUtils of() => ImMsgUtils();

  /// 消息转换为body
  ImMessageBody? convertToBody(String text) {
    ImMessageBean imMessageBean = ImMessageBean.fromJsonStr(text);
    if (imMessageBean.code != 200) {
      return null;
    }
    return imMessageBean.body;
  }

  GameTicketModel? convertTicket(String jsonStr) {
    if (jsonStr.isEmpty) return null;
    try {
      return GameTicketModel.fromJson(
        json.decode(jsonStr),
      );
    } catch (e) {
      return null;
    }
  }

  FollowBetModel? convertFollowBet(String jsonStr) {
    if (jsonStr.isEmpty) return null;
    try {
      return FollowBetModel.fromJson(
        json.decode(jsonStr),
      );
    } catch (e) {
      return null;
    }
  }

  /// 处理IM消息的body
  void handleImBody(ImMessageBody? msgBody) {
    var operatorType = msgBody?.operatorType;
    if (operatorType == null) {
      return;
    }
    // 消息内容
    var content = msgBody?.content ?? "";
    LiveController _controller = LiveController.of;
    switch (operatorType) {
      case ImConstant.operatorChat:
        // 聊天
        var chatBean = ImChatBean.fromJson(json.decode(content));
        _controller.message[operatorType] = chatBean;
        break;
      case ImConstant.operatorInRoom:
        // 进入房间
        var enterRoomBean = ImEnterRoomBean.fromJson(json.decode(content));
        _controller.msgEnterRoom.add(enterRoomBean);
        break;
      case ImConstant.operatorKick:
        //踢人
        Get.back();
        break;
      case ImConstant.operatorFollow:
      case ImConstant.operatorCancelFollow:
        //关注、取消关注
        var barrageBean = ImFollowBean.fromJson(json.decode(content));
        _controller.message[operatorType] = barrageBean;
        break;
      case ImConstant.operatorGift:
        //礼物
        Log.d("礼物【$content】");
        var giftBean = ImGiftBean.fromJson(json.decode(content));
        _controller.message[operatorType] = giftBean;
        break;
      case ImConstant.operatorDanmu:
        //弹幕
        var barrageBean = ImBarrageBean.fromJson(json.decode(content));
        _controller.message[operatorType] = barrageBean;
        break;
      case ImConstant.operatorDown:
        //下播,3秒后进入下一个直播间
        _controller.toNextLive("studioNum");
        break;
      case ImConstant.operatorServerNotice:
        //管理系统推送消息
        var messageBean = json.decode(content);
        _controller.message[operatorType] = messageBean;
        break;
      case ImConstant.operatorUserList:
        //直播间用户列表
        Log.d("直播间用户列表【$content】");
        var userListBean = LiveTop50UserBean.fromJson(json.decode(content));
        var inrOnlineNum = userListBean.num ?? 0;
        var inrUserList = userListBean.list ?? [];
        if (inrUserList.isNotEmpty) {
          // 原来的用户列表
          List<LiveOnlineListBean> _tmpOnLineUsers = _controller.onlineUserData;
          _tmpOnLineUsers.addAll(inrUserList);
          //倒叙排序
          _tmpOnLineUsers.sort((a, b) {
            return (b.silver ?? 0).compareTo(a.silver ?? 0);
          });
          if (_tmpOnLineUsers.length < 5) {
            _controller.onlineUserData.value = _tmpOnLineUsers;
          } else {
            _controller.onlineUserData.value = _tmpOnLineUsers.sublist(0, 5);
          }
          //更新在线用户数
          _controller.onlineNum.value += inrOnlineNum;
        }
        break;
      case ImConstant.operatorLatestGrade:
        //最新用户等级
        Log.d("最新用户等级【$content】");
        break;
    }
  }
}
