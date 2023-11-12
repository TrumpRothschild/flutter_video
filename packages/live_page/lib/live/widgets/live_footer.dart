import 'package:base/assets.gen.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_page/live/live_page.dart';

/// 直播间底部菜单区域
class LiveFooter extends StatelessWidget {
  final LiveController _controller = Get.find<LiveController>();

  LiveFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var customTheme = _controller.currentCustomThemeData();
    var sizedBox = const SizedBox(width: AppDimens.w_5);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.w_10)
            .copyWith(bottom: AppDimens.h_10, top: AppDimens.h_4),
        child: Row(
          children: [
            Expanded(child: _msgWidget(customTheme)),
            sizedBox,
            // 礼物
            _iconWidget(
                _controller.showGifts, Assets.livePage.icLiveGift.path),
            sizedBox,
            // 游戏
            _iconWidget(
                _controller.showGames, Assets.livePage.icLiveGame.path),
            sizedBox,
            // 活动中心
            _iconWidget(_controller.getRoomActList,
                Assets.livePage.icLiveActionCenter.path),
            sizedBox,
            // 分享
            _iconWidget(
                _controller.openShare, Assets.livePage.icLiveShare.path),

            sizedBox,
            //关闭
            _iconWidget(
                _controller.exitRoom, Assets.livePage.icLiveClose.path),
          ],
        ));
  }

  /// 发送消息组件
  Widget _msgWidget(CustomTheme customTheme) {
    return Container(
      height: AppDimens.h_40,
      decoration: BoxDecoration(
        color: customTheme.colors0x000000_40,
        borderRadius: BorderRadius.circular(AppDimens.w_20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.w_5),
      child: InkWell(
        onTap: () {
          OLEasyLoading.showToast("发送消息弹框");
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("说点什么叭~~~~",
                style: TextStyle(
                  color: customTheme.colors0xFFFFFF_60,
                  fontSize: FontDimens.fontSp14,
                )),
            const Icon(
              Icons.send,
              color: Colors.white,
              size: AppDimens.w_16,
            )
          ],
        ),
      ),
    );
  }

  /// 通用icon
  Widget _iconWidget(GestureTapCallback? callback, String path) {
    return InkWell(
        onTap: callback,
        child: AssetGenImage(path)
            .image(width: AppDimens.w_35, height: AppDimens.w_35));
  }
}
