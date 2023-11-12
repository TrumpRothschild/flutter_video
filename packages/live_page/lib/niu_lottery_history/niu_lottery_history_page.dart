import 'package:base/bases/get_base_controller.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_page/live_game/live_game_provider.dart';
import 'package:live_page/live_game/widgets/brnn/brnn_lottery_item.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';
import 'package:services/models/res/game/niu_niu/niu_niu_model.dart';

part 'niu_lottery_history_controller.dart';

class NiuLotteryHistoryPage extends StatelessWidget {
  const NiuLotteryHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NiuLotteryHistoryController>(
      init: NiuLotteryHistoryController(),
      builder: (controller) {
        final CustomTheme customTheme = controller.currentCustomThemeData();
        return Container(
          decoration: BoxDecoration(
            color: customTheme.colors0x000000_80,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
          ),
          constraints: BoxConstraints(
              maxHeight: 450 + MediaQuery.of(context).padding.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Center(
                  child: Text(
                    '开奖历史',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SmartRefresher(
                  controller: controller.refreshController,
                  enablePullUp: true,
                  onRefresh: controller.onRefresh,
                  onLoading: controller.onLoading,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: controller.lotteryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final model = controller.lotteryList[index];
                      return BRNNLotteryItem(
                        model: model,
                        customTheme: customTheme,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
