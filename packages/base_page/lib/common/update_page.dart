import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/caches/sp/sp_cache_impl.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:services/models/res/app_version_baen.dart';
import 'package:url_launcher/url_launcher.dart';

/// 版本升级页面
class UpdatePage extends Dialog {
  final GetXBaseController controller;

  final AppVersionBean? bean;

  final bool? isForce;

  const UpdatePage(
      {Key? key,
      required this.controller,
      required this.bean,
      required this.isForce})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => (isForce ?? false) ? false : true,
        child: Center(
            child: Stack(
          children: [
            SizedBox(
              width: 320.0,
              height: 395.0,
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 15, top: 15),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(AppDimens.w_12)),
                ),
                child: Column(
                  children: [
                    _topWidget(bean?.showVersion ?? ''),
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
                                  bottomRight:
                                      Radius.circular(AppDimens.w_10)))),
                      child: Column(
                        children: [
                          SizedBox(
                              height: 180,
                              child: SingleChildScrollView(
                                  child: Text(
                                bean?.content ?? "",
                                style: TextStyle(
                                    color: controller
                                        .currentCustomThemeData()
                                        .colors0x000000,
                                    fontSize: FontDimens.fontSp15),
                              ))),
                          const SizedBox(height: AppDimens.h_10),
                          isForce ?? false
                              ? _goBtn(bean?.downUrl ?? '')
                              : _update2(bean?.downUrl ?? ''),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                top: 0,
                right: 0,
                child: (isForce ?? false) ? Container() : InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset(
                      Assets.basePage.whileX.path,
                      width: AppDimens.w_30,
                      height: AppDimens.w_30,
                    )))
          ],
        )));
  }

  /// 顶部标题
  Widget _topWidget(String version) {
    return Container(
        width: double.infinity,
        height: AppDimens.h_120,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 13),
            const Text(
              "新版本内测邀请",
              style:
                  TextStyle(color: Colors.white, fontSize: FontDimens.fontSp20),
            ),
            Text(
              version,
              style: const TextStyle(
                  color: Colors.white, fontSize: FontDimens.fontSp16),
            ),
          ],
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.basePage.icUpdateBg.path),
                fit: BoxFit.cover)));
  }

  /// 我知道了按钮
  Widget _goBtn(String url) => InkWell(
      onTap: () async {
        await launch(url);
      },
      child: Container(
          width: 160,
          height: 30,
          decoration: BoxDecoration(
            color: controller.currentCustomThemeData().colors0x7032FF,
            borderRadius:
                const BorderRadius.all(Radius.circular(AppDimens.w_20)),
          ),
          child: Center(
            child: Text(
              "立即更新",
              style: TextStyle(
                color: controller.currentCustomThemeData().colors0xFFFFFF,
              ),
            ),
          )));

  Widget _update2(String url) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            await launch(url);
          },
          child: Container(
            width: 107,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppDimens.w_20),
                    bottomLeft: Radius.circular(AppDimens.w_20)),
                color: controller.currentCustomThemeData().colors0x7032FF),
            child: Center(
              child: Text(
                "立即更新",
                style: TextStyle(
                  color: controller.currentCustomThemeData().colors0xFFFFFF,
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Get.back();
            SpCacheImpl.of().setLastVersionName(bean?.showVersion ?? '');
          },
          child: Container(
            width: 107,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(AppDimens.w_20),
                    bottomRight: Radius.circular(AppDimens.w_20)),
                border: Border.all(
                    color: controller.currentCustomThemeData().colors0x7032FF,
                    width: 1)),
            child: Center(
              child: Text(
                "下次再说",
                style: TextStyle(
                  color: controller.currentCustomThemeData().colors0x7032FF,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
