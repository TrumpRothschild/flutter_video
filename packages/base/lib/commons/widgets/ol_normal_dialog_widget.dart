import 'dart:ui';
import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef NormalDialogWidgetAlertFunc = Function(int type);

class NormalDialogWidgetAlert extends StatelessWidget {
  final GetXBaseController controller;
  final String title;
  final String content;
  final String cancelTitle;
  final String sureTitle;
  final NormalDialogWidgetAlertFunc callBack;

  const NormalDialogWidgetAlert(
      {Key? key,
      required this.controller,
      this.title = "温馨提示",
      required this.content,
      this.cancelTitle = "取消",
      this.sureTitle = "前往绑定",
      required this.callBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var customTheme = controller.currentCustomThemeData();
    return Center(
        child: Container(
      padding: const EdgeInsets.only(top: AppDimens.h_13),
      width: AppDimens.w_280,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimens.w_10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: FontDimens.fontSp18,
                fontWeight: FontWeight.w400,
                color: Colors.black),
          ),
          const SizedBox(height: AppDimens.h_18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.w_28),
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: FontDimens.fontSp15,
                  color: customTheme.colors0x979797),
            ),
          ),
          const SizedBox(height: AppDimens.h_18),
          Image.asset(Assets.basePage.icDivider.path,
              width: double.infinity,
              height: AppDimens.h_1,
              fit: BoxFit.fitWidth),
          _footer()
        ],
      ),
    ));
  }

  Widget _footer() {
    var customTheme = controller.currentCustomThemeData();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          child: Text(
            cancelTitle,
            style: TextStyle(
                fontSize: FontDimens.fontSp15,
                color: customTheme.colors0xADADAD),
          ),
          onPressed: () {
            Get.back();
            callBack(0);
          },
        ),
        Container(
          width: AppDimens.w_1,
          height: AppDimens.h_16,
          color: customTheme.colors0x9F44FF,
        ),
        TextButton(
          child: Text(
            sureTitle,
            style: TextStyle(
                fontSize: FontDimens.fontSp15,
                color: customTheme.colors0x9F44FF),
          ),
          onPressed: () {
            Get.back();
            callBack(1);
          },
        )
      ],
    );
  }
}
