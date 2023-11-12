import 'package:base/res/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/models/res/live/live_room_detail.dart';

import '../live_page.dart';
import 'follow_bet.dart';
import 'live_game_count_down.dart';

/// 直播间消息区域组件
class LiveMessage extends StatelessWidget {
  final LiveController _controller = Get.find<LiveController>();

  LiveMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LiveRoomDetail? roomDetail = _controller.roomDetailData.value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.w_10)
          .copyWith(bottom: AppDimens.h_5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 消息列表
          _messageList(),
          // 游戏
          _gameIconWidget(roomDetail),
        ],
      ),
    );
  }

  /// 消息列表
  Widget _messageList() {
    return Obx(() {
      return Container(
        child: FollowBet(
          onFollowed: _controller.onFollowed,
          betFollowMessage: _controller.betFollowMessage.value,
          customTheme: _controller.currentCustomThemeData(),
        ),
      );
    });
  }

  /// 游戏图标
  Widget _gameIconWidget(LiveRoomDetail? roomDetail) {
    var gameId = roomDetail?.gameId ?? 0;
    return Visibility(
        child: InkWell(
          onTap: () => _controller.toGameBetBottom(gameId),
          child: LiveGameCountDown(
            gameIcon: roomDetail?.gameIcon ?? '',
          ),
        ),
        visible: gameId > 0);
  }
}
