import 'package:base/assets.gen.dart';
import 'package:base/res/app_dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:services/image/ol_image.dart';

import '../live_page.dart';

/// 直播见背景图
class LoadingPlaceholder extends StatelessWidget {
  final LiveController controller;
  final String thumbImage;

  const LoadingPlaceholder(
    this.controller,
    this.thumbImage, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return thumbImage.isEmpty ? _placeholder() : _thumbImage();
  }

  /// 默认背景
  Widget _placeholder() {
    return SizedBox.expand(
        child: Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: AppDimens.h_74),
          child: Assets.livePage.liveLoadBg.image(
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CupertinoActivityIndicator(
              radius: 20,
            ),
            const SizedBox(height: 22),
            Text(
              '不要着急\n小姐姐换好衣服就来',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: controller.currentCustomThemeData().colors0x000000_40,
                fontSize: 16,
                height: 20 / 16,
              ),
            ),
          ],
        )
      ],
    ));
  }

  /// 加载背景图
  Widget _thumbImage() {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(
          width: double.infinity, height: double.infinity), // 自适应屏幕
      child: OLImage(
        imageUrl: thumbImage,
        fit: BoxFit.cover,
      ),
    );
  }
}
