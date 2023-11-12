import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../live_page.dart';

/// 收费直播弹框
class LiveChargeDialog extends StatelessWidget {
  LiveChargeDialog(this.chargeType, {Key? key}) : super(key: key);
  final String chargeType;
  final LiveController _controller = Get.find<LiveController>();

  @override
  Widget build(BuildContext context) {
    var customTheme = _controller.currentCustomThemeData();
    return Center(
      child: Container(
        width: AppDimens.w_250,
        padding: const EdgeInsets.symmetric(vertical: AppDimens.h_14),
        constraints: const BoxConstraints(minHeight: AppDimens.h_160),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.w_10),
            color: Colors.white),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text("付费直播",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: FontDimens.fontSp20)),
          const SizedBox(height: AppDimens.h_10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.w_30),
            child: Text("主播开启了付费直播，$chargeType，是否付费进入？",
                style: TextStyle(
                    color: customTheme.colors0x979797,
                    fontSize: FontDimens.fontSp14),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(height: AppDimens.h_10),
          Divider(
            color: customTheme.colors0xD9D9D9,
            height: AppDimens.h_1,
          ),
          const SizedBox(height: AppDimens.h_14),
          _footerWidget(customTheme)
        ]),
      ),
    );
  }

  /// 底部按钮区域
  Widget _footerWidget(customTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: InkWell(
          onTap: () {
            Get.back();
            _controller.toNextLive("1");
          },
          child: Center(
            child: Text("跳过",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: customTheme.colors0xD6D6D6,
                  fontSize: FontDimens.fontSp16,
                )),
          ),
        )),
        ColoredBox(
          color: customTheme.colors0xD9D9D9,
          child: const SizedBox(
            width: AppDimens.w_1,
            height: AppDimens.h_20,
          ),
        ),
        Expanded(
            child: InkWell(
          onTap: () {
            Get.back();
            OLEasyLoading.showToast("确定");
          },
          child: Center(
            child: Text("确定",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: customTheme.colors0x9F44FF,
                  fontSize: FontDimens.fontSp16,
                )),
          ),
        ))
      ],
    );
  }
}
