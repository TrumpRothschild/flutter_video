import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_gradient_button.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/models/res/notice/notice_bean.dart';

/// 公告弹框dialog
class NoticeDialogWidget extends StatelessWidget {

  final GetXBaseController controller;
  final NoticeBean? bean;

  const NoticeDialogWidget(
      {Key? key, required this.controller, required this.bean})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String noticeContent = bean?.noticeContent ?? "";
    String noticeName = bean?.noticeName ?? "";
    return Center(
        child: SizedBox(
          width: AppDimens.w_280,
          height: AppDimens.h_360,
          child: Column(
            children: [
              _topWidget(),
              Container(
                padding: const EdgeInsets.only(
                    top: AppDimens.h_10,
                    bottom: AppDimens.h_20,
                    left: AppDimens.w_28,
                    right: AppDimens.w_28),
                width: double.infinity,
                height: AppDimens.h_260,
                decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(AppDimens.w_10),
                            bottomRight: Radius.circular(AppDimens.w_10)))),
                child: Column(
                  children: [
                    Expanded(
                        child: Text(
                          noticeContent,
                          style: TextStyle(
                              color: controller.currentCustomThemeData().colors0x000000,
                              fontSize: FontDimens.fontSp15),
                        )),
                    Text(noticeName,
                        style: TextStyle(
                            color:
                            controller.currentCustomThemeData().colors0xA8AEB8,
                            fontSize: FontDimens.fontSp13)),
                    const SizedBox(height: AppDimens.h_10),
                    _goBtn()
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  /// 顶部标题
  Widget _topWidget() => Container(
      width: double.infinity,
      height: AppDimens.h_80,
      padding: const EdgeInsets.only(top: AppDimens.h_30),
      alignment: Alignment.center,
      child: Text(
        controller.homePageString('announcement'),
        style:
        const TextStyle(color: Colors.white, fontSize: FontDimens.fontSp17),
      ),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Assets.basePage.icHomeNoticeBg.path),
              fit: BoxFit.cover)));

  /// 我知道了按钮
  Widget _goBtn() => OlGradientButton(
      tapCallback: () {
        Get.back();
      },
      width: AppDimens.w_160,
      height: AppDimens.h_30,
      borderRadius: BorderRadius.circular(AppDimens.h_20),
      child: Text(
        controller.homePageString('go_it'),
        style: TextStyle(
            color: controller.currentCustomThemeData().colors0xFFFFFF,
            fontSize: FontDimens.fontSp16),
      ));
}


