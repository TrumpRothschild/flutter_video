import 'dart:developer';

import 'package:base/assets.gen.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:url_launcher/url_launcher.dart';

import 'exchange_coins_controller.dart';
import 'views/exchange_coins_please_moeny_view.dart';
import 'views/exchange_coins_wallet_view.dart';

class ExchangeCoinsPage extends GetView<ExchangeCoinsController> {
  ExchangeCoinsPage({Key? key}) : super(key: key);

  final TextEditingController zhanghao = TextEditingController();
  final TextEditingController mima = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get.put(WalletRootController());
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Get.back();
            },
            icon: Image.asset(
              Assets.basePage.backBlack.path,
              width: 10,
              height: 20,
            ),
          ),
          actions: [
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
                log("去客服中心");
                String url = UserManagerCache.shared.getNewOnlineUrl();
                await launchUrl(
                  Uri.parse(url),
                  mode: LaunchMode.externalApplication,
                );
                // Get.toNamed(
                //   AppRoutes.onlineService,
                //   arguments: url,
                // );
              },
              icon: Image.asset(
                Assets.minePage.navKf.path,
                width: 26,
                height: 26,
              ),
            ),
          ],
          centerTitle: true,
          title: Obx(() {
            return Text(
              controller.exType.value == 0
                  ? controller.walletPageString("兑换金币")
                  : controller.walletPageString("兑换钻石"),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: FontDimens.fontSp18,
                color: controller.currentCustomThemeData().colors0x000000,
              ),
            );
          })),
      body: ListView.builder(
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return ExchangeCoinsWalletView();
            } else {
              return ExchangeCoinsPleaseMoney();
            }
          }),
    );
  }
}
