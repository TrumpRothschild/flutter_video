import 'dart:async';

import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/utils/extension.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_page/live_game/widgets/bet_header_1.dart';
import 'package:live_page/live_game/widgets/bet_header_2.dart';
import 'package:live_page/live_game/widgets/bottom_chip.dart';
import 'package:live_page/live_game/widgets/yfkc/yfkc_bet_grid.dart';
import 'package:live_page/live_game/widgets/yflhc/yflhc_bet_grid.dart';
import 'package:live_page/live_game/widgets/yfssc/yfssc_bet_grid.dart';
import 'package:live_page/live_game/widgets/yxx/yxx_bet_grid.dart';
import 'package:live_page/live_game_bet/live_game_bet_page.dart';
import 'package:live_page/live_game_bet_history/game_bet_history_page.dart';
import 'package:live_page/niu_lottery_history/niu_lottery_history_page.dart';
import 'package:services/models/res/game/niu_niu/niu_niu_detail_model.dart';
import 'package:services/models/res/game/niu_niu/niu_niu_model.dart';
import 'package:synchronized/synchronized.dart';
import '../utils/im_msg_utils.dart';
import 'live_game_provider.dart';
import 'utils/ticket_utils.dart';
import 'widgets/bet_bottom.dart';
import 'widgets/bjl/bjl_bet_grid.dart';
import 'widgets/brnn/brnn_bet_grid.dart';
import 'widgets/bottom_explain.dart';
import 'widgets/lhd/lhd_bet_grid.dart';
import 'widgets/live_game_indicator.dart';
import 'widgets/yfks/yfks_bet_grid.dart';

part 'live_game_controller.dart';

class LiveGamePage extends StatelessWidget {
  final String gameName;
  final int ticketId;
  final String? headerImgUrl;

  const LiveGamePage({
    Key? key,
    required this.gameName,
    required this.ticketId,
    this.headerImgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LiveGameController(gameName, ticketId));
    final CustomTheme customTheme = controller.currentCustomThemeData();
    return GetBuilder<LiveGameController>(
      builder: (controller) {
        return Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
          decoration: BoxDecoration(
            color: customTheme.colors0x000000_40,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
          ),
          constraints: BoxConstraints(
              maxHeight: 350 + MediaQuery.of(context).padding.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (ticketId == 1 || ticketId == 3 || ticketId == 4)
                BetHeader1(
                  gameName: gameName,
                  ticketId: ticketId,
                  headerImgUrl: headerImgUrl,
                )
              else
                BetHeader2(
                  gameName: gameName,
                  ticketId: ticketId,
                  headerImgUrl: headerImgUrl,
                ),
              if (controller.detailModelList.isNotEmpty)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 40,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 8),
                        decoration: BoxDecoration(
                          color: customTheme.colors0xFFFFFF_15,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: TabBar(
                          indicatorColor: customTheme.colors0xFFFFFF,
                          labelColor: customTheme.colors0xFFFFFF,
                          unselectedLabelColor: customTheme.colors0xA5A5A5,
                          isScrollable: false,
                          indicator: const LiveGameIndicator(),
                          labelPadding: EdgeInsets.zero,
                          tabs: controller.tabs.mapIndexed((item, index) {
                            return Tab(
                              child: Text(
                                controller.tabs[index],
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: const TextStyle(fontSize: 12),
                              ),
                            );
                          }).toList(),
                          controller:
                              controller.tabController, // 记得要带上tabController
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: TabBarView(
                            controller: controller.tabController,
                            children: controller.detailModelList
                                .mapIndexed((item, index) {
                              switch (ticketId) {
                                case 1:
                                  return BRNNBetGrid(
                                    customTheme: customTheme,
                                    typeIndex: index,
                                    oddsList: item?.odds ?? [],
                                    selectedOddsList:
                                        controller.selectedOddsList,
                                    onSelectOdds: controller.onSelectOdds,
                                  );
                                case 2:
                                  return YXXBetGrid(
                                    customTheme: customTheme,
                                    typeIndex: index,
                                    oddsList: item?.odds ?? [],
                                    selectedOddsList:
                                        controller.selectedOddsList,
                                    onSelectOdds: controller.onSelectOdds,
                                  );
                                case 3:
                                  return LHDBetGrid(
                                    customTheme: customTheme,
                                    typeIndex: index,
                                    oddsList: item?.odds ?? [],
                                    selectedOddsList:
                                        controller.selectedOddsList,
                                    onSelectOdds: controller.onSelectOdds,
                                  );
                                case 4:
                                  return BJLBetGrid(
                                    customTheme: customTheme,
                                    typeIndex: index,
                                    oddsList: item?.odds ?? [],
                                    selectedOddsList:
                                        controller.selectedOddsList,
                                    onSelectOdds: controller.onSelectOdds,
                                  );
                                case 5:
                                  return YFKSBetGrid(
                                    customTheme: customTheme,
                                    typeIndex: index,
                                    oddsList: item?.odds ?? [],
                                    selectedOddsList:
                                        controller.selectedOddsList,
                                    onSelectOdds: controller.onSelectOdds,
                                  );
                                case 6:
                                  return YFSSCBetGrid(
                                    customTheme: customTheme,
                                    typeIndex: index,
                                    oddsList: item?.odds ?? [],
                                    selectedOddsList:
                                        controller.selectedOddsList,
                                    onSelectOdds: controller.onSelectOdds,
                                  );
                                case 7:
                                  return YFLHCBetGrid(
                                    customTheme: customTheme,
                                    typeIndex: index,
                                    oddsList: item?.odds ?? [],
                                    selectedOddsList:
                                        controller.selectedOddsList,
                                    onSelectOdds: controller.onSelectOdds,
                                  );
                                case 8:
                                  return YFKCBetGrid(
                                    customTheme: customTheme,
                                    typeIndex: index,
                                    oddsList: item?.odds ?? [],
                                    selectedOddsList:
                                        controller.selectedOddsList,
                                    onSelectOdds: controller.onSelectOdds,
                                  );
                                default:
                                  return Container();
                              }
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                const Expanded(
                    child: CupertinoActivityIndicator(
                  color: Colors.white,
                )),
              BetBottom(
                customTheme: customTheme,
                changeChip: controller.changeChip,
                chip: controller.chip,
                onBet: controller.onBet,
              ),
            ],
          ),
        );
      },
    );
  }
}

class GameCountDown extends StatelessWidget {
  const GameCountDown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LiveGameController>(
        id: 'countDown',
        builder: (countDownCtrl) {
          return Row(
            children: [
              Text(
                "本期截止：",
                style: TextStyle(
                  fontSize: 14,
                  color: countDownCtrl.currentCustomThemeData().colors0xFFFFFF,
                ),
              ),
              Text(
                countDownCtrl.currentSecStr,
                style: TextStyle(
                  fontSize: 14,
                  color: countDownCtrl.currentCustomThemeData().colors0x00F0FF,
                ),
              ),
            ],
          );
        });
  }
}
