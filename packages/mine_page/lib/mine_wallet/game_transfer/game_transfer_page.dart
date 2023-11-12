import 'package:base/app_routes.dart';
import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine_page/mine_wallet/game_transfer/widget/coin_no_enough_dialog.dart';
import 'package:services/api/common_apis.dart';
import 'package:services/api/wallet_apis.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/wallet/diamond_model.dart';
import 'package:services/models/res/wallet/user_wallet_model.dart';

import 'widget/balance_header.dart';
import 'widget/balance_input.dart';
import 'widget/balance_no_enough_dialog.dart';
import 'widget/balance_quick_items.dart';

part 'game_transfer_binding.dart';
part 'game_transfer_controller.dart';

class GameTransferPage extends GetView<GameTransferInController> {
  const GameTransferPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            BalanceHeader(
              controller: controller,
            ),
            const SizedBox(height: 18),
            BalanceInput(controller: controller),
            if (controller.showQuickBalance)
              BalanceQuickItems(
                controller: controller,
              ),
            InkWell(
              onTap: controller.onConfirm,
              child: FittedBox(
                child: Container(
                  margin: const EdgeInsets.only(top: 100),
                  constraints:
                      const BoxConstraints(minHeight: 35, minWidth: 200),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        controller.currentCustomThemeData().colors0x6129FF,
                        controller.currentCustomThemeData().colors0xD96CFF,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      '确 认',
                      style: TextStyle(
                        color:
                            controller.currentCustomThemeData().colors0xFFFFFF,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
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
      title: Text(
        controller.pageType.title,
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
