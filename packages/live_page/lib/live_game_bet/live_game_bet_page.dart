import 'dart:async';

import 'package:base/app_routes.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_page/live/live_page.dart';
import 'package:live_page/live_game/live_game_page.dart';
import 'package:services/models/res/game/niu_niu/niu_bet_post_model.dart';
import 'package:services/models/res/game/niu_niu/niu_niu_detail_model.dart';

import '../live_game/live_game_provider.dart';
import '../live_game/utils/ticket_utils.dart';
import 'widgets/bet_item.dart';

part 'live_game_bet_controller.dart';

class LiveGameBetPage extends GetView<LiveGameBetController> {
  const LiveGameBetPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LiveGameBetController());
    final CustomTheme customTheme = controller.currentCustomThemeData();

    return GetBuilder<LiveGameBetController>(
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            color: controller.currentCustomThemeData().colors0xFFFFFF,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
          ),
          constraints: BoxConstraints(
              maxHeight: 350 + MediaQuery.of(context).padding.bottom),
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
                  '确认投注',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "第${controller.betNumber}期",
                            style: TextStyle(
                              fontSize: 14,
                              color: customTheme.colors0x000000,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Row(
                            children: [
                              Text(
                                "本期截止：",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: customTheme.colors0x000000,
                                ),
                              ),
                              Text(
                                controller.currentSecStr,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: customTheme.colors0x3EB614,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(
                        height: 1,
                        thickness: 1,
                        color: customTheme.colors0xE6E6E6),
                    Expanded(
                      child: ListView.builder(
                        itemCount: LiveGameController.to.selectedOddsList.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (BuildContext context, int index) {
                          final item =
                          LiveGameController.to.selectedOddsList[index];
                          return BetItem(
                            onDelete: () => controller.onDeleteItem(item),
                            item: item,
                            customTheme: customTheme,
                          );
                        },
                      ),
                    ),
                    GridView(
                      padding: const EdgeInsets.all(12),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        childAspectRatio: 65 / 30,
                        crossAxisSpacing: 6,
                      ),
                      children: controller.multiples
                          .map(
                            (e) => GestureDetector(
                              onTap: () => controller.onSelectMultiple(e),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                        controller.currentMultiple == e
                                            ? 20
                                            : 5),
                                  ),
                                  border: Border.all(
                                    color: controller.currentMultiple == e
                                        ? Colors.transparent
                                        : customTheme.colors0xD9D9D9,
                                  ),
                                  gradient: controller.currentMultiple == e
                                      ? LinearGradient(
                                          colors: [
                                            customTheme.colors0x6129FF,
                                            customTheme.colors0xD96CFF,
                                          ],
                                        )
                                      : null,
                                ),
                                child: Text(
                                  "$e倍数",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: controller.currentMultiple == e
                                        ? customTheme.colors0xFFFFFF
                                        : customTheme.colors0x838383,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    Divider(
                        height: 1,
                        thickness: 1,
                        color: customTheme.colors0xE6E6E6),
                    SafeArea(
                      minimum: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text.rich(
                                  TextSpan(text: '合计：', children: [
                                    TextSpan(
                                      text:
                                          '${LiveGameController.to.selectedOddsList.length}',
                                      style: TextStyle(
                                        color: customTheme.colors0xFF0000,
                                      ),
                                    ),
                                    const TextSpan(text: " 注 统计 "),
                                    TextSpan(
                                      text: controller.betTotal,
                                      style: TextStyle(
                                        color: customTheme.colors0xFF0000,
                                      ),
                                    ),
                                    const TextSpan(text: " 金币"),
                                  ]),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: customTheme.colors0x000000,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text.rich(
                                  TextSpan(text: '账户金币：', children: [
                                    TextSpan(
                                      text: "0",
                                      style: TextStyle(
                                        color: customTheme.colors0xFF0000,
                                      ),
                                    ),
                                  ]),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: customTheme.colors0x000000,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: controller.onBet,
                            child: Container(
                              height: 26,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [
                                    customTheme.colors0x6129FF,
                                    customTheme.colors0xD96CFF,
                                  ],
                                ),
                              ),
                              child: Text(
                                "确定购买",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: customTheme.colors0xFFFFFF,
                                ),
                              ),
                            ),
                          ),
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
}
