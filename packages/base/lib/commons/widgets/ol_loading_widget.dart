import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

/// 公共需要loading的组件
class OLEasyLoading {


  static void init() {
    EasyLoading.init();
  }

  static void config() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.white.withAlpha(122)
      ..backgroundColor = Colors.black
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.white
      ..maskColor = Colors.white.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false
      ..customAnimation = OLLoadingAnimation();
  }

  /// 显示loading
  static void showLoading(String msg) {
    EasyLoading.show(
      status: msg,
    );
  }

  /// 显示toast
  static showToast(String msg) async {
    await EasyLoading.showToast(
      msg,
    );
  }

  static void dismiss() {
    EasyLoading.dismiss();
  }
}

class OLLoadingAnimation extends EasyLoadingAnimation {
  OLLoadingAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}
