import 'dart:developer';
import 'package:base/app_routes.dart';
import 'package:base/assets.gen.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../exchange_coins_controller.dart';

class ExchangeCoinsWalletView extends StatelessWidget {
  final ExchangeCoinsController controller = Get.find();

  ExchangeCoinsWalletView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 9, 10, 9),
      child: Container(
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
          padding: const EdgeInsets.fromLTRB(15, 16, 0, 25),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    return Text(
                      "${controller.walletPageString("余额:")}${controller.wallet.value?.balance ?? ""}",
                      style: TextStyle(
                        color:
                            controller.currentCustomThemeData().colors0xFFFFFF,
                        fontSize: FontDimens.fontSp20,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    return Text(
                      title(),
                      style: TextStyle(
                        color:
                            controller.currentCustomThemeData().colors0xFFFFFF,
                        fontSize: FontDimens.fontSp20,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }),
                ],
              ),
              Expanded(child: Container()),
              MaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.zero,
                minWidth: 0,
                onPressed: () {
                  log("充值金币");
                  if (controller.exType.value == 0) {
                    Get.toNamed(AppRoutes.walletRoot,
                        arguments: {"accountType": "2"});
                  } else {
                    Get.toNamed(AppRoutes.walletRoot);
                  }
                },
                child: Image.asset(
                  controller.exType.value == 0
                      ? Assets.walletPage.exRechargeCoin.path
                      : Assets.walletPage.exRecharge.path,
                  width: 80,
                  height: 108,
                ),
              ),
              const SizedBox(
                width: 31,
              ),
            ],
          ),
        ),
      ),
    );
  }

  title() {
    return (controller.exType.value == 1)
        ? "${controller.walletPageString("钻石:")}${controller.wallet.value?.silverBean ?? ""}"
        : "${controller.walletPageString("金币:")}${controller.wallet.value?.amount ?? ""}";
  }
}
