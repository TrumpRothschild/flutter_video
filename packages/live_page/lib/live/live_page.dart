import 'dart:async';

import 'package:base/app_contant.dart';
import 'package:base/app_routes.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/utils/aes_utils.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/res/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_page/anchor_card_dialog/anchor_card_dialog_page.dart';
import 'package:live_page/exit_room_dialog/exit_room_dialog_page.dart';
import 'package:live_page/gift_list/gift_list_page.dart';
import 'package:live_page/live/widgets/live_action_center.dart';
import 'package:live_page/live/widgets/live_charge.dart';
import 'package:live_page/live/widgets/live_charge_dialog.dart';
import 'package:live_page/live/widgets/live_draw_card.dart';
import 'package:live_page/live/widgets/live_footer.dart';
import 'package:live_page/live/widgets/live_header.dart';
import 'package:live_page/live/widgets/live_message.dart';
import 'package:live_page/live/widgets/live_message_enter.dart';
import 'package:live_page/live/widgets/live_recommend.dart';
import 'package:live_page/live/widgets/live_recommend_drawer.dart';
import 'package:live_page/live/widgets/live_report.dart';
import 'package:live_page/live/widgets/live_user_info.dart';
import 'package:live_page/live/widgets/live_video.dart';
import 'package:live_page/live_game/live_game_page.dart';
import 'package:live_page/live_game/utils/ticket_utils.dart';
import 'package:live_page/live_game_center/live_game_center_page.dart';
import 'package:live_page/live_game_follow_bet/live_game_follow_bet_page.dart';
import 'package:live_page/utils/im_constant.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/models/res/game/game_tab_model.dart';
import 'package:services/models/res/game/niu_niu/niu_niu_model.dart';
import 'package:services/models/res/home/home_live_bean.dart';
import 'package:services/models/res/live/anchor_card_bean.dart';
import 'package:services/models/res/live/im_enter_room_bean.dart';
import 'package:services/models/res/live/im_message_bean.dart';
import 'package:services/models/res/live/live_action_list_bean.dart';
import 'package:services/models/res/live/live_anchor_bean.dart';
import 'package:services/models/res/live/live_online_list_bean.dart';
import 'package:services/models/res/live/live_room_detail.dart';
import 'package:services/models/res/live/live_top50_user_bean.dart';
import 'package:services/models/res/live/live_user_detail_bean.dart';
import 'package:services/models/res/live/live_video_list_bean.dart';
import 'package:services/provider/common_provider.dart';
import 'package:services/provider/live_provider.dart';
import 'package:synchronized/synchronized.dart';
import '../agora/rtc_utils.dart';
import '../agora/rtm_utils.dart';
import '../utils/im_msg_utils.dart';
import 'widgets/live_online_user_list.dart';
import 'widgets/loading_placeholder.dart';

part 'live_controller.dart';

class LivePage extends GetView<LiveController> {
  const LivePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      LiveRoomDetail? roomDetail = controller.roomDetailData.value;
      // 背景图
      var coverPlaceholder =
          LoadingPlaceholder(controller, roomDetail?.studioThumbImage ?? "");
      return Scaffold(
        key: controller.scaffoldKey,
        body: controller.isChargeEnd.value
            ? coverPlaceholder
            : Stack(
                children: [
                  coverPlaceholder,
                  // 直播/视频视图
                  LiveVideo(),
                  PageView(
                      controller: PageController(initialPage: 1),
                      children: [
                        // 空白页
                        const SizedBox(),
                        // 内容区域
                        _liveCoverWidget(roomDetail)
                      ])
                ],
              ),
        endDrawer: LiveRecommendDrawer(),
      );
    });
  }

  /// 内容遮罩层
  Widget _liveCoverWidget(LiveRoomDetail? roomDetail) {
    return Container(
      margin: const EdgeInsets.only(top: AppDimens.h_28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header
          LiveHeader(),
          //贡献榜 为您推荐
          LiveRecommend(),
          //收费提示信息
          Visibility(
              child: LiveCharge(), visible: roomDetail?.isCharge == true),
          //彩票中奖弹框主播名片
          LiveDrawCard(),
          Expanded(child: LiveMessage()),
          //进入直播间的消息
          LiveMessageEnter(),
          //bottom
          LiveFooter()
        ],
      ),
    );
  }
}
