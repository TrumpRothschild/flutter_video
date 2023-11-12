import 'package:base/commons/utils/log_utils.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:services/models/res/live/live_room_detail.dart';

import '../live_page.dart';

/// 直播间收费区
class LiveCharge extends StatelessWidget {
  LiveCharge({Key? key}) : super(key: key);

  final LiveController _controller = Get.find<LiveController>();

  @override
  Widget build(BuildContext context) {
    LiveRoomDetail? roomDetail = _controller.roomDetailData.value;
    var productPrice = roomDetail?.productPrice ?? 0;
    var chargeType = roomDetail?.chargeType ?? 0;
    if (chargeType == 6 || chargeType == 7) {
      // 按时收费 按场收费
      var chargeTypeTxt = _controller.getChargeTypeTxt(chargeType);
      String typeTxt = "按时直播$productPrice $chargeTypeTxt";
      _handleLookTime(roomDetail, chargeTypeTxt);
      return Padding(
          padding:
              const EdgeInsets.only(left: AppDimens.w_10, top: AppDimens.h_5),
          child: Row(
            children: [
              _chargeWidget(typeTxt),
              const SizedBox(width: AppDimens.w_4),
              Obx(() => Visibility(
                    child: _chargeWidget(_controller.chargeLookTxt.value),
                    visible: _controller.chargeLookTxt.isNotEmpty,
                  ))
            ],
          ));
    } else {
      // 免费
      return const SizedBox();
    }
  }

  /// 收费通用组件
  Widget _chargeWidget(String txt) {
    return Container(
      decoration: BoxDecoration(
        color: _controller.currentCustomThemeData().colors0xFFA15C,
        borderRadius: BorderRadius.circular(AppDimens.w_20),
      ),
      alignment: Alignment.center,
      constraints: const BoxConstraints(minHeight: AppDimens.w_20),
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.w_3),
      child: Text(txt,
          style: TextStyle(
              color: _controller.currentCustomThemeData().colors0xFFFFFF,
              fontSize: FontDimens.fontSp12),
          maxLines: 1),
    );
  }

  // 处理观看时长
  void _handleLookTime(LiveRoomDetail? roomDetail, String chargeTypeTxt) {
    //是否可用 -1:有试看时长 0:已经试看过不可以再试看 1:已经付费
    // var productUsable = roomDetail?.isProductUsable ?? 0;
    // 门票剩余时间秒
    var leftTime = roomDetail?.productLeftTime ?? 0;
    // 试看时长:超过时间后要付费
    var trySeeTime = roomDetail?.trySeeTime ?? 0;
    if (leftTime > 0) {
      _controller.handleTrySeeTime(
          time: leftTime, chargeTypeTxt: chargeTypeTxt);
    } else {
      _controller.handleTrySeeTime(
          time: trySeeTime, chargeTypeTxt: chargeTypeTxt, trySee: true);
    }
  }
}
