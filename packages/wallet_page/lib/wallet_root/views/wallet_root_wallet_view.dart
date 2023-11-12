import 'dart:developer';

import 'package:base/app_config.dart';
import 'package:base/app_routes.dart';
import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/number_util.dart';
import 'package:base/commons/utils/screen.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base/app_config.dart';
import '../wallet_root_controller.dart';

class WalletRootWalletView extends GetView<WalletRootController> {

  const WalletRootWalletView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 9),
      child: Container(
          height: width(200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              Assets.walletPage.beiJin.path,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 0, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                var value = "${controller.walletPageString("余额:")}${NumberUtil.formatNum(double.parse(controller.wallet.value?.balance ?? "0.00"), 2)}";
                if (AppConfig.isVideo) {
                  value = "";
                }
                return value.isEmpty ? Container() : Text(
                  value,
                  style: TextStyle(
                    color: controller.currentCustomThemeData().colors0xFFFFFF,
                    fontSize: FontDimens.fontSp20,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }),
              AppConfig.isVideo ?   Container() :  const SizedBox(
                height: 20,
              ),
              AppConfig.isVideo ? Container() : row(1),
              AppConfig.isVideo ?  Container() : Container(),
              const SizedBox(
                height: 0,
              ),
              row(2),
            ],
          ),
        ),
      ),
    );
  }

  row(int index) {
    return Row(
      children: [
        Obx(() {
          return Padding(
            padding: EdgeInsets.only(top: width(50)),
            child: Text(
              title(index),
              style: TextStyle(
                color: controller.currentCustomThemeData().colors0xFFFFFF,
                fontSize: FontDimens.fontSp20,
                fontWeight: FontWeight.w500,
              ),
            ),


          );
        }),
        const SizedBox(
          width: 11,
        ),
        index == 2
            ? MaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.zero,
                minWidth: 0,
                onPressed: () {
                  log("去充值金币"); // 跳转的是同一个界面，暂时注释，如果有其他业务在改回来（jim）
                  Get.toNamed(AppRoutes.walletRoot, arguments: {
                    'accountType': 2,
                  });
                },
                child: controller.accountType.value == 2
                    ? Container()
                    : Container(
                        width: 50,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: controller
                              .currentCustomThemeData()
                              .colors0xFFFFFF,
                        ),
                        child: Center(
                          child: Text(
                            controller.walletPageString("充值"),
                            style: TextStyle(
                              color: controller
                                  .currentCustomThemeData()
                                  .colors0x7032FF,
                              fontSize: FontDimens.fontSp12,
                            ),
                          ),
                        ),
                      ),
              )
            : Container(),
        Expanded(child: Container()),
        AppConfig.isVideo ? Container() :  MaterialButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.zero,
          minWidth: 0,
          onPressed: () {
            if (index == 1) {
              log("兑换金币");
              Get.toNamed(AppRoutes.exchangeCoins, arguments: 1);
            } else {
              log("兑换砖石");
              Get.toNamed(AppRoutes.exchangeCoins, arguments: 0);
            }
          },
          child: Container(
            width: 79,
            height: 25,
            margin: EdgeInsets.only(right: width(5)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  Assets.walletPage.duiHuan.path,
                ),
              ),
            ),
            child: Center(
              child: Text(
                btnTitle(index),
                style: TextStyle(
                  color: controller.currentCustomThemeData().colors0xFFFFFF,
                  fontSize: FontDimens.fontSp14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  title(int index) {
    return (index == 1)
        ? "${controller.walletPageString("钻石: ")}${NumberUtil.formatNum(double.parse(controller.wallet.value?.silverBean ?? "0.00"), 2)}"
        : "${controller.walletPageString("金币: ")}${NumberUtil.formatNum(double.parse(controller.wallet.value?.amount ?? "0.00"), 2)}";
  }

  btnTitle(int index) {
    return (index == 1)
        ? controller.walletPageString("兑换钻石")
        : controller.walletPageString("兑换金币");
  }
}
