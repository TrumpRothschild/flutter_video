import 'package:base/assets.gen.dart';
import 'package:base/bases/get_base_view.dart';
import 'package:base/commons/utils/extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:game_page/game_transaction/widgets/alive_extension.dart';
import 'package:get/get.dart';

import '../widgets/tab_indicator.dart';
import 'game_transaction_controller.dart';
import 'widgets/income_item.dart';
import 'widgets/transaction_list_view.dart';

/// GameTransaction
class GameTransactionPage extends GetBaseView<GameTransactionController> {
  const GameTransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: controller.currentCustomThemeData().colors0xF6F5FB,
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
        centerTitle: true,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          "充提记录",
          style: TextStyle(
              color: controller.currentCustomThemeData().colors0x000000,
              fontSize: 16),
        ),
      ),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: controller.currentCustomThemeData().colors0x9F44FF,
              child: TabBar(
                labelColor: controller.currentCustomThemeData().colors0xFFFFFF,
                unselectedLabelColor:
                    controller.currentCustomThemeData().colors0xFFFFFF,
                isScrollable: false,
                indicator: const TabBarIndicator(
                  height: 3,
                  gradient: LinearGradient(
                    colors:[Color(0xff3C00BA), Color(0xff3C00BA)],
                  ),
                ),
                tabs: controller.tabs.mapIndexed((item, index) {
                  return Tab(
                    child: Text(controller.tabs[index], style: const TextStyle(fontSize: 16)),
                  );
                }).toList(),
                controller: controller.tabController,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: List.generate(
                  controller.transactionControllers.length,
                  (index) => GetBuilder<TransactionListController>(
                    init: controller.transactionControllers[index],
                    global: false,
                    builder: (controller) =>
                        TransactionListView(controller: controller),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
