import 'dart:ui';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/res/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef OperatDialogWidgetAlertFunc();

class OperatDialogWidgetAlert extends StatelessWidget {
  final GetXBaseController controller;
  String content = "";
  String cancleTitle = "";
  String sureTitle = "";
  bool isShowClose;
  final OperatDialogWidgetAlertFunc callBack;

  OperatDialogWidgetAlert({
    Key? key,
    required this.controller,
    required this.content,
    this.cancleTitle = "取消",
    this.sureTitle = "确认",
    this.isShowClose = true,
    required this.callBack
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Center(
        child: SizedBox(
          width: AppDimens.w_280,
          height: AppDimens.h_100,
          child: Container(
            width: double.infinity,
            height: AppDimens.h_100,
            margin: EdgeInsets.only(top: 5),
            decoration: const ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(AppDimens.w_10)))),
            child: Column(
              children: [
                isShowClose == true ? Row(
                  children: [
                    SizedBox(
                      width: 255
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.cancel,
                        color: controller.currentCustomThemeData().colors0xC2C2C2,
                        size: 20,
                      ),
                    ),
                  ],
                ) : SizedBox(height: 12,),
                Padding(
                  padding: EdgeInsets.only(left: 20,right: 20, top: 5),
                  child: Text(
                    content,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14)),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 35,
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            padding: EdgeInsets.zero,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            height: 30,
                            minWidth: 120,
                            onPressed: () {
                              Get.back();
                            },
                            child: Container(
                              width: 120,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: controller.currentCustomThemeData().colors0x9F44FF,
                                    width: 0.5),
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Center(
                                child: Text(
                                  controller.basePageString(cancleTitle),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: controller.currentCustomThemeData().colors0x9F44FF,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          InkWell(
                            onTap: () {
                              Get.back();
                              callBack();
                            },
                            child: Container(
                              width: 120,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                gradient: LinearGradient(
                                  colors: [
                                    controller.currentCustomThemeData().colors0x6129FF,
                                    controller.currentCustomThemeData().colors0xD96CFF,
                                  ],
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  sureTitle,
                                  style: TextStyle(
                                    color: controller.currentCustomThemeData().colors0xFFFFFF,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
