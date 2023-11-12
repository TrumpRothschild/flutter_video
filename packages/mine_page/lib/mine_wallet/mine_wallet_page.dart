import 'package:base/app_config.dart';
import 'package:base/app_routes.dart';
import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_page/transaction_detail/transaction_detail_controller.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';
import 'package:services/api/common_apis.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/wallet/user_game_wallet_bean.dart';
import 'package:services/models/res/wallet/user_wallet_model.dart';
import 'package:services/provider/common_provider.dart';

import 'game_transfer/game_transfer_page.dart';
import 'widgets/balance_item.dart';
import 'widgets/coin_item.dart';
import 'widgets/diamond_item.dart';
import 'widgets/game_item.dart';

part 'mine_wallet_binding.dart';
part 'mine_wallet_controller.dart';

class MineWalletPage extends GetView<MineWalletController> {
  const MineWalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Obx(
            () => SmartRefresher(
              controller: controller.refreshController,
              onRefresh: controller.onRefresh,
              header: const WaterDropHeader(),
              child: ListView.separated(
                itemCount: controller.userWallets.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 20);
                },
                itemBuilder: (BuildContext context, int index) {
                  final wallet = controller.userWallets[index];
                  return Column(
                    children: [
                      AppConfig.isVideo ? Container() :  BalanceItem(
                        customTheme: controller.currentCustomThemeData(),
                        toTransferList: () {
                          controller
                              .toTransferList(TransactionPageType.balance);
                        },
                        toExchangeCoin: controller.toExchangeCoin,
                        toExchangeDiamond: controller.toExchangeDiamond,
                        toRecharge: () {
                          controller.toRecharge(1);
                        },
                        wallet: wallet,
                      ),
                      AppConfig.isVideo ? Container() : const SizedBox(height: 15),
                      CoinItem(
                        controller: controller,
                        wallet: wallet,
                      ),
                      Obx(
                        () => controller.isCoinExpand
                            ? Column(
                                children: List.generate(
                                  controller.userGameWallets.length,
                                  (index) {
                                    final gameWallet =
                                        controller.userGameWallets[index];
                                    return GameItem(
                                      customTheme:
                                          controller.currentCustomThemeData(),
                                      toGameTransferIn: () {
                                        controller.toGameTransferIn(
                                          controller.userWallets[0],
                                          gameWallet,
                                        );
                                      },
                                      toGameRollOut: () {
                                        controller.toGameRollOut(
                                          controller.userWallets[0],
                                          gameWallet,
                                        );
                                      },
                                      gameWallet: gameWallet,
                                    );
                                  },
                                ),
                              )
                            : const SizedBox(),
                      ),
                      const SizedBox(height: 15),
                      DiamondItem(
                        controller: controller,
                        wallet: wallet,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
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
      centerTitle: true,
      title: Text(
        "钱包",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: controller.currentCustomThemeData().colors0x000000,
        ),
      ),
    );
  }
}
