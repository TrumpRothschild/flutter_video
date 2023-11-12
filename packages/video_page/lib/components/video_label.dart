import 'package:base/bases/get_base_controller.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/cupertino.dart';

/// 视频标签
class VideoLabel extends StatelessWidget {
  final GetXBaseController controller;
  final String title;

  const VideoLabel({Key? key, required this.controller, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 处理文本不居中
    var strutStyle =
        const StrutStyle(leading: 0, height: 1.3, forceStrutHeight: true);
    var currentCustom = controller.currentCustomThemeData();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.w_5,vertical: 0),
      margin: const EdgeInsets.only(right: AppDimens.w_5),
      height: AppDimens.h_20,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.w_4),
          color: currentCustom.colors0xF0F0F0),
      child: Text(title.trim(),
          textAlign: TextAlign.center,
          style: TextStyle(
              color: currentCustom.colors0x868686,
              fontSize: FontDimens.fontSp10),
          strutStyle: strutStyle),
    );
  }
}
