import 'package:base/assets.gen.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:live_page/live_game/live_game_page.dart';
import 'package:live_page/live_game/widgets/lottery_list.dart';
import 'package:live_page/live_game/widgets/yfkc/yfkc_lottery_item.dart';
import 'package:live_page/live_game/widgets/yfks/yfks_lottery_item.dart';
import 'package:live_page/live_game/widgets/yflhc/yflhc_lottery_item.dart';
import 'package:live_page/live_game/widgets/yfssc/yfssc_lottery_item.dart';
import 'package:live_page/live_game/widgets/yxx/yxx_lottery_item.dart';
import 'package:live_page/widgets/cus_button.dart';
import 'package:services/image/ol_image.dart';

class BetHeader2 extends StatelessWidget {
  const BetHeader2({
    Key? key,
    required this.gameName,
    required this.ticketId,
    this.headerImgUrl,
  }) : super(key: key);

  final String gameName;
  final int ticketId;
  final String? headerImgUrl;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LiveGameController>(builder: (controller) {
      final CustomTheme customTheme = controller.currentCustomThemeData();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.isShowLottery)
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OLImage(
                          imageUrl: headerImgUrl ?? '',
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(width: 6),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  gameName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: customTheme.colors0xFFFFFF,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                SvgPicture.asset(
                                  Assets.gamePage.liveGame.niuNiuPlay,
                                ),
                              ],
                            ),
                            const GameCountDown(),
                          ],
                        )
                      ],
                    ),
                  )
                else
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OLImage(
                          imageUrl: headerImgUrl ?? '',
                          width: 60,
                          height: 60,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "第${controller.lastInfo?.kjNo ?? ''}期",
                          style: TextStyle(
                            fontSize: 12,
                            color: customTheme.colors0xFFFFFF,
                          ),
                        ),
                        const GameCountDown(),
                      ],
                    ),
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        if (!controller.isShowLottery) ...[
                          CustomButton.text(
                            onPressed: controller.toExplain,
                            size: CustomButtonSize.small,
                            foregroundColor: customTheme.colors0xFFFFFF,
                            radius: 20,
                            fontSize: 11,
                            child: Text(
                              '玩法说明',
                              style: TextStyle(
                                color: customTheme.colors0xFFFFFF,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                        ],
                        CustomButton.text(
                          onPressed: controller.toBetRecord,
                          size: CustomButtonSize.small,
                          foregroundColor: customTheme.colors0xFFFFFF,
                          radius: 20,
                          fontSize: 11,
                          child: Text(
                            '投注记录',
                            style: TextStyle(
                              color: customTheme.colors0xFFFFFF,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        CustomButton.text(
                          onPressed: controller.toggleLottery,
                          size: CustomButtonSize.small,
                          foregroundColor: customTheme.colors0xFFFFFF,
                          radius: 20,
                          fontSize: 11,
                          child: Row(
                            children: [
                              Text(
                                '开奖记录',
                                style: TextStyle(
                                  color: customTheme.colors0xFFFFFF,
                                ),
                              ),
                              if (controller.isShowLottery)
                                const Icon(Icons.keyboard_arrow_down, size: 12)
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
                        if (controller.isShowLottery)
                          GestureDetector(
                            onTap: controller.toMoreRecord,
                            child: Text(
                              '更多记录',
                              style: TextStyle(
                                color: customTheme.colors0xFFFFFF,
                              ),
                            ),
                          )
                        else
                          SvgPicture.asset(
                            Assets.gamePage.liveGame.niuNiuPlay,
                          )
                      ],
                    ),
                    if (!controller.isShowLottery)...[
                      const SizedBox(height: 16),
                      _buildLastLotteryItem(controller),
                    ],
                  ],
                ),
              ],
            ),
          ),
          if (controller.isShowLottery)
            LotteryList(
              ticketId: ticketId,
              lotteryList: controller.expandedList,
              customTheme: customTheme,
            )
        ],
      );
    });
  }

  Widget _buildLastLotteryItem(LiveGameController controller) {
    switch (ticketId) {
      case 2:
        return YXXLotteryItem(
          model: controller.lastInfo,
          isLast: true,
          customTheme: controller.currentCustomThemeData(),
        );
      case 5:
        return YFKSLotteryItem(
          model: controller.lastInfo,
          isLast: true,
          customTheme: controller.currentCustomThemeData(),
        );
      case 6:
        return YFSSCLotteryItem(
          model: controller.lastInfo,
          isLast: true,
          customTheme: controller.currentCustomThemeData(),
        );
      case 7:
        return YFLHCLotteryItem(
          model: controller.lastInfo,
          isLast: true,
          customTheme: controller.currentCustomThemeData(),
        );
      case 8:
        return YFKCLotteryItem(
          model: controller.lastInfo,
          isLast: true,
          customTheme: controller.currentCustomThemeData(),
        );
      default:
        return Container();
    }
  }
}
