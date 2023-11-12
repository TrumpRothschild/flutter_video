import 'package:base/assets.gen.dart';
import 'package:base/res/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_page/live/widgets/recent_game_result.dart';

import '../live_page.dart';

/// 开奖和主播名片
class LiveDrawCard extends StatelessWidget {
  LiveDrawCard({Key? key}) : super(key: key);
  final LiveController _controller = Get.find<LiveController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.w_10)
            .copyWith(top: AppDimens.h_5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 彩票开奖结果
            _drawResult(),
            // 主播名片
            _anchorCard(),
          ],
        ));
  }

  /// 彩票开奖结果
  Widget _drawResult() {
    return Obx(() {
      return RecentGameResult(
        ticketMessage: _controller.ticketMessage.value,
        customTheme: _controller.currentCustomThemeData(),
      );
    });
  }

  /// 主播名片
  Widget _anchorCard() {
    // 主播信息
    var liveAnchorVO = _controller.roomDetailData.value?.liveAnchorVO;
    return Visibility(
        child: InkWell(
          onTap: () {
             _controller.getAnchorCard(liveAnchorVO);
          },
          child: Assets.livePage.anchorCard.image(
            width: AppDimens.w_100,
            height: AppDimens.h_70,
          ),
        ),
        visible: liveAnchorVO?.cardEnabled == true);
  }
}
