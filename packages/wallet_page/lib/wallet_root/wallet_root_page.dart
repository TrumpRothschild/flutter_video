import 'dart:developer';

import 'package:base/app_config.dart';
import 'package:base/assets.gen.dart';
import 'package:base/datas/base_data_opear.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallet_page/wallet_root/views/wallet_root_please_choose_view.dart';

import 'views/wallet_root_channel_view.dart';
import 'views/wallet_root_please_channel_view.dart';
import 'views/wallet_root_please_moeny_view.dart';
import 'views/wallet_root_wallet_view.dart';
import 'wallet_root_controller.dart';

class WalletRootPage extends GetView<WalletRootController> {
  WalletRootPage({
    Key? key,
    this.showLeading = true,
  }) : super(key: key);

  final TextEditingController zhanghao = TextEditingController();
  final TextEditingController mima = TextEditingController();

  final bool showLeading;

  @override
  Widget build(BuildContext context) {
    final show = BaseDataOpear.type_charge;
    BaseDataOpear.type_charge = true;
    //controller.onInit();
    return Scaffold(
      appBar: AppBar(
          elevation: 0.2,
          toolbarHeight: 35,
          leading: (showLeading //根据类型是否显示返回按钮
              ? IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Get.back();
                  },
                  icon: Image.asset(
                    Assets.basePage.backBlack.path,
                    width: 10,
                    height: 20,
                  ),
                )
              : Container()),
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
              controller.accountType.value == 2
                  ? controller.walletPageString("充值金币")
                  : controller.walletPageString("充值余额"),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: FontDimens.fontSp18,
                color: controller.currentCustomThemeData().colors0x000000,
              ),
            );
          })),
      body: SmartRefresher(
          controller: controller.refreshController,
          onRefresh: controller.onRefresh,
          header: const WaterDropHeader(),
          child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return AppConfig.isVideo
                      ? Container(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  )
                      : announcement();
                } else if (index == 1) {
                  return const WalletRootWalletView();
                } else if (index == 2) {
                  return WalletRootChannel(
                    balance: const ["", "", "", "", "", "", "", ""],
                  );
                } else if (index == 3) {
                  return Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: WalletRootPleaseChoose(
                          tip: controller.walletPageString("请选择支付通道")));
                } else if (index == 4) {
                  return WalletRootPleaseChannel(
                    balance: const ["", "", "", "", "", ""],
                  );
                } else if (index == 5) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Divider(
                      color: controller.currentCustomThemeData().colors0xFAFAFC,
                      thickness: 5.0,
                    ),
                  );
                } else if (index == 6) {
                  return WalletRootPleaseChoose(
                      tip: controller.walletPageString("请选择充值金额"));
                } else if (index == 7) {
                  return WalletRootPleaseMoney(
                    onRecharge: () => controller.recharge(0),
                    balance: const ["", "", "", "", "", ""],
                  );
                } else if (index == 8) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 25, 10, 10),
                    child: Obx(() {
                      return Text(
                        controller.ways.isEmpty
                            ? ""
                            : controller
                            .ways[controller.seleWays.value]
                            .payChannelVOList?[controller.seleTongDao.value]
                            .tips ??
                            "",
                        maxLines: 1000,
                        style: TextStyle(
                          color: controller.currentCustomThemeData().colors0xFF3D3D,
                          fontSize: FontDimens.fontSp12,
                        ),
                      );
                    }),
                  );
                } else {
                  return Container();
                }
              }),
      ),
    );
  }

  ///公告
  announcement() {
    return const SizedBox();
    return Container(
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        image: DecorationImage(
          image: AssetImage(Assets.walletPage.gongGao.path),
        ),
      ),
    );
  }
}
