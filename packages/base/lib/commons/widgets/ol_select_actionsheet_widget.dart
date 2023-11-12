import 'dart:ui';
import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef SelectActionSheetWidgetAlertFunc(int btnType); // 1 - potato 2 - telegram

class SelectActionSheetWidgetAlert extends StatelessWidget {
  final GetXBaseController controller;
  final String content = "欢迎关注粉丝群";
  final String cancleTitle = "取消";
  final SelectActionSheetWidgetAlertFunc callBack;

  SelectActionSheetWidgetAlert({
    Key? key,
    required this.controller,
    required this.callBack
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimens.design_w,
      height: AppDimens.h_240,
      child: Container(
        width: double.infinity,
        height: AppDimens.h_240,
        margin: EdgeInsets.only(top: 5),
        decoration: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppDimens.w_10),
                    topRight: Radius.circular(AppDimens.w_10)
                ))),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                content,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 55,
                        height: 55,
                        child: IconButton(
                            onPressed: () {
                              Get.back();
                              callBack(1);
                            },
                            icon: Image.asset(
                              Assets.minePage.welPotato.path,
                            )),
                      ),
                      SizedBox(height: 5,),
                      Text("Potato")
                    ],
                  ),
                  SizedBox(width: 120),
                  Column(
                    children: [
                      Container(
                        width: 55,
                        height: 55,
                        child: IconButton(
                            onPressed: () {
                              Get.back();
                              callBack(2);
                            },
                            icon: Image.asset(
                              Assets.minePage.welTelegram.path,
                            )),
                      ),
                      SizedBox(height: 5,),
                      Text("Telegram")
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30,),
              MaterialButton(
                padding: EdgeInsets.zero,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                height: 38,
                minWidth: 234,
                onPressed: () {
                  Get.back();
                },
                child: Container(
                  width: 234,
                  height: 38,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(19)),
                    color: controller.currentCustomThemeData().colors0xF0F0F0,
                  ),
                  child: Center(
                    child: Text(
                      controller.basePageString(cancleTitle),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
