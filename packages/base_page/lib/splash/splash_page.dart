import 'package:base/app_config.dart';
import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_view.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:base_page/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/image/ol_image.dart';
import 'package:url_launcher/url_launcher.dart';

/// 广告页
class SplashPage extends GetBaseView<SplashController> {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      // 启动背景
      decoration: _splashBgWidget(),
      // 广告页
      child: controller.obx(
        (state) => GetUtils.isNull(state)
            ? const SizedBox()
            : InkWell(
                onTap: () async {
                  if (state?.link?.isNotEmpty == true) {
                    await launch(state?.link ?? "");
                  }
                },
                child: Stack(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints.expand(
                        width: double.infinity,
                        height: double.infinity,
                      ), // 自适应屏幕
                      child: OLImage(
                        imageUrl: state?.advImg ?? "",
                      ),
                    ),
                    GetBuilder<SplashController>(
                      id: 'count_down',
                      builder: (_) {
                        return controller.showCount &&
                                controller.adSeconds.value > 0
                            ? Positioned(
                                top: AppDimens.h_30,
                                right: AppDimens.w_10,
                                child: _countDownWidget(),
                              )
                            : const SizedBox();
                      },
                    )
                  ],
                ),
              ),
      ),
    ));
  }

  /// 启动背景
  BoxDecoration _splashBgWidget() {
    return BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: ExactAssetImage(AppConfig.isVideo
                ? Assets.basePage.icVideoSplash.path
                : Assets.basePage.icLiveSplash.path)));
  }

  /// 倒计时组件
  Widget _countDownWidget() {
    var controller = Get.put(SplashController());
    return Obx(() => Container(
          height: AppDimens.w_36,
          width: AppDimens.w_36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: controller.currentCustomThemeData().colors0x000000_30,
              borderRadius: BorderRadius.circular(AppDimens.w_18)),
          child: Text("${controller.adSeconds.value}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontSize: FontDimens.fontSp16)),
        ));
  }
}
