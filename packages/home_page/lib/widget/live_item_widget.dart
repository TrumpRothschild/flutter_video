import 'package:base/app_routes.dart';
import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/utils/permission_utils.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/image/ol_image.dart';
import 'package:services/models/res/home/home_live_bean.dart';

/// 直播列表item
class LiveHomeWidget extends StatelessWidget {
  final GetXBaseController controller;
  final HomeLiveBean? item;

  const LiveHomeWidget({Key? key, required this.controller, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // 获取权限
          PermissionUtils.of().livePerms().then(
              (value) => {
                    // 进入直播间
                    Get.toNamed(AppRoutes.live, arguments: item?.studioNum)
                  }, onError: (err) {
            OLEasyLoading.showToast(
                controller.homePageString('permissions_fail'));
          });
        },
        child: Container(
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                OLImage(
                    imageUrl: item?.studioThumbImage ?? "",
                    width: double.infinity,
                    height: double.infinity),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ticketInfoWidget(),
                    const Expanded(child: Text("")),
                    _liveInfoWidget()
                  ],
                )
              ],
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.w_10))));
  }

  ///彩票信息
  Widget _ticketInfoWidget() {
    var textColor = controller.currentCustomThemeData().colors0xFFFFFF;
    return Container(
        margin: const EdgeInsets.only(top: AppDimens.h_8, left: AppDimens.w_5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 彩票名称
            Visibility(
              child: Container(
                height: AppDimens.h_20,
                width: AppDimens.w_90,
                alignment: const Alignment(-0.5, -1),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image:
                            AssetImage(Assets.homePage.icHomeTicketBg.path))),
                child: Text(
                  item?.gameName ?? "",
                  style: TextStyle(
                      color: textColor, fontSize: FontDimens.fontSp12),
                ),
              ),
              visible: GetUtils.isNullOrBlank(item?.gameName) == false,
            ),
            // 收费类型
            _chargeWidget(controller, item, textColor),
            // 收费价格
            _chargeWidget(controller, item, textColor, type: 2),
          ],
        ));
  }

  /// 收费组件
  /// type =1 收费类型 2 收费价格
  Widget _chargeWidget(
      GetXBaseController controller, HomeLiveBean? item, var textColor,
      {int type = 1}) {
    var msg = item?.chargeType == 6
        ? controller.homePageString('charge_time')
        : controller.homePageString('charge_site');
    if (type == 2) {
      msg = item?.chargeType == 6
          ? "${item?.price}${controller.homePageString('diamonds_minute')}"
          : "${item?.price}${controller.homePageString('diamonds_site')}";
    }
    return Visibility(
        child: Container(
          margin: const EdgeInsets.only(top: AppDimens.h_6),
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.w_8),
          child: Text(
            msg,
            style: TextStyle(color: textColor, fontSize: FontDimens.fontSp11),
          ),
          decoration: ShapeDecoration(
              color: controller.currentCustomThemeData().colors0x000000_30,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.w_20))),
        ),
        visible: item?.isCharge == true);
  }

  /// 直播信息
  Widget _liveInfoWidget() {
    var textColor = controller.currentCustomThemeData().colors0xFFFFFF;
    // 处理文本不居中
    var strutStyle =
        const StrutStyle(leading: 0, height: 1, forceStrutHeight: true);
    return Container(
        padding: const EdgeInsets.symmetric(
            vertical: AppDimens.h_8, horizontal: AppDimens.w_5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.w_5),
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x00000000),
                  Color(0x80010101),
                ],
                stops: [
                  0,
                  1,
                ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(
                  item?.studioTitle ?? "",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: textColor, fontSize: FontDimens.fontSp12),
                )),
                Visibility(
                    child: AssetGenImage(Assets.homePage.icHomeToy.path)
                        .image(width: AppDimens.w_20, height: AppDimens.w_20),
                    visible: item?.isRelateToy == true)
              ],
            ),
            const SizedBox(height: AppDimens.h_2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                    child: AssetGenImage(Assets.homePage.icHomeLocal.path)
                        .image(width: AppDimens.w_10, height: AppDimens.h_12),
                    visible:
                        GetUtils.isNullOrBlank(item?.countryName) == false),
                Visibility(
                    child: const SizedBox(width: AppDimens.w_4),
                    visible:
                        GetUtils.isNullOrBlank(item?.countryName) == false),
                Text(item?.countryName ?? "",
                    style: TextStyle(
                        color: textColor, fontSize: FontDimens.fontSp11),
                    strutStyle: strutStyle),
                const Expanded(child: Text("")),
                AssetGenImage(Assets.homePage.icHomeHeat.path)
                    .image(width: AppDimens.w_10, height: AppDimens.h_12),
                const SizedBox(width: AppDimens.w_4),
                Text(item?.studioHeat.toString() ?? "0",
                    style: TextStyle(
                        color: textColor, fontSize: FontDimens.fontSp11),
                    strutStyle: strutStyle)
              ],
            )
          ],
        ));
  }
}
