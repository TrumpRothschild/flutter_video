import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/utils/app_date_utils.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_page/live_game/live_game_provider.dart';
import 'package:live_page/live_game_bet_history/widgets/status_filter.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';
import 'package:services/models/res/game/game_bet_model.dart';
import 'package:services/models/res/game/game_statistics.dart';
import 'package:services/models/res/game/game_type_model.dart';
import 'widgets/filter_button.dart';
import 'widgets/game_filter.dart';
import 'widgets/niu_bet_item.dart';

part 'game_bet_history_controller.dart';

class GameBetHistoryPage extends StatelessWidget {
  final int ticketId;

  const GameBetHistoryPage({
    Key? key,
    required this.ticketId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GameBetHistoryController(ticketId));
    final CustomTheme customTheme = controller.currentCustomThemeData();

    return GetBuilder<GameBetHistoryController>(
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            color: controller.currentCustomThemeData().colors0xFFFFFF,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
          ),
          constraints: BoxConstraints(
              maxHeight: 450 + MediaQuery.of(context).padding.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [
                      customTheme.colors0x6129FF,
                      customTheme.colors0xD96CFF,
                    ],
                  ),
                ),
                child: const Text(
                  '投注记录',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: FilterButton(
                            filterText: controller.currentGameType,
                            onTap: (isExpanded) => controller.setGameFilter(),
                          ),
                        ),
                        Expanded(
                          child: FilterButton(
                            filterText: controller.currentStatus,
                            onTap: (isExpanded) => controller.setStatusFilter(),
                          ),
                        ),
                        Expanded(
                          child: FilterButton(
                            filterText: controller.tzDate ?? '选择日期',
                            onTap: (isExpanded) async {
                              final DateTime? selectedDate =
                                  await showDatePickerBottom(
                                          customTheme, context) ??
                                      DateTime.now();
                              if (selectedDate != null) {
                                controller.setDateFilter(selectedDate);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    Divider(
                        height: 1,
                        thickness: 1,
                        color: customTheme.colors0xE6E6E6),
                    Expanded(
                      child: SmartRefresher(
                        controller: controller.refreshController,
                        enablePullUp: true,
                        onRefresh: controller.onRefresh,
                        onLoading: controller.onLoading,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: controller.betList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = controller.betList[index];
                            return NiuBetItem(
                              item: item,
                              customTheme: customTheme,
                            );
                          },
                        ),
                      ),
                    ),
                    Divider(
                        height: 1,
                        thickness: 1,
                        color: customTheme.colors0xE6E6E6),
                    SafeArea(
                      minimum: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          _BottomChildItem(
                              name: '投注',
                              value: '${controller.statistics?.tzCount ?? 0}注'),
                          _BottomChildItem(
                              name: '中奖',
                              value: '${controller.statistics?.zjAmount ?? 0}注',
                              valueColor: customTheme.colors0xFF0000),
                          _BottomChildItem(
                              name: '盈利',
                              value:
                                  '￥${controller.statistics?.sbAmount ?? 0.00}',
                              valueColor: customTheme.colors0xFF0000),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<DateTime?> showDatePickerBottom(
    CustomTheme customTheme,
    BuildContext context,
  ) async {
    DateTime? selectedDate;
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext builderContext) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text(
                    '取消',
                    style: TextStyle(
                      color: customTheme.colors0x000000,
                      fontSize: 14,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: Text(
                    '确定',
                    style: TextStyle(
                      color: customTheme.colors0x000000,
                      fontSize: 14,
                    ),
                  ),
                  onPressed: () =>
                      Navigator.of(context).pop(selectedDate ?? DateTime.now()),
                ),
              ],
            ),
            Container(
              height: 125 + MediaQuery.of(context).padding.bottom,
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (DateTime dateTime) {
                  selectedDate = dateTime;
                },
                initialDateTime: DateTime.now(),
              ),
            ),
          ],
        );
      },
    );
    return selectedDate;
  }
}

class _BottomChildItem extends StatelessWidget {
  final String name;
  final String value;
  final Color? valueColor;

  const _BottomChildItem({
    required this.name,
    required this.value,
    this.valueColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(color: Color(0xffB1B1B1), fontSize: 14),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(color: valueColor, fontSize: 14),
          )
        ],
      ),
    );
  }
}
