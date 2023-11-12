import 'package:base/themes/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_page/live_game/utils/ticket_utils.dart';
import 'package:live_page/live_game/widgets/bjl/bjl_lottery_item.dart';
import 'package:live_page/live_game/widgets/brnn/brnn_lottery_item.dart';
import 'package:live_page/live_game/widgets/lhd/lhd_lottery_item.dart';
import 'package:live_page/live_game/widgets/yfkc/yfkc_lottery_item.dart';
import 'package:live_page/live_game/widgets/yfks/yfks_lottery_item.dart';
import 'package:live_page/live_game/widgets/yflhc/yflhc_lottery_item.dart';
import 'package:live_page/live_game/widgets/yfssc/yfssc_lottery_item.dart';
import 'package:live_page/live_game/widgets/yxx/yxx_lottery_item.dart';
import 'package:services/models/res/game/niu_niu/niu_niu_model.dart';


class LotteryList extends StatelessWidget {
  final int ticketId;
  final CustomTheme customTheme;
  final List<GameTicketModel?> lotteryList;

  const LotteryList({
    Key? key,
    required this.ticketId,
    required this.lotteryList,
    required this.customTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (lotteryList.isEmpty) {
      return SizedBox(
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              color: customTheme.colors0xFFFFFF,
              size: 15,
            ),
            const SizedBox(width: 4),
            Text(
              '暂无数据',
              style: TextStyle(
                color: customTheme.colors0xFFFFFF,
              ),
            ),
          ],
        ),
      );
    }
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 120),
      child: SingleChildScrollView(
        child: Column(
          children: lotteryList.map((model) {
            switch (ticketId) {
              case 1:
                return BRNNLotteryItem(
                  model: model,
                  customTheme: customTheme,
                );
              case 2:
                return YXXLotteryItem(
                  model: model,
                  customTheme: customTheme,
                );
              case 3:
                return LHDLotteryItem(
                  model: model,
                  customTheme: customTheme,
                );
              case 4:
                return BJLLotteryItem(
                  model: model,
                  customTheme: customTheme,
                );
              case 5:
                return YFKSLotteryItem(
                  model: model,
                  customTheme: customTheme,
                );
              case 6:
                return YFSSCLotteryItem(
                  model: model,
                  customTheme: customTheme,
                );
              case 7:
                return YFLHCLotteryItem(
                  model: model,
                  customTheme: customTheme,
                );
              case 8:
                return YFKCLotteryItem(
                  model: model,
                  customTheme: customTheme,
                );
              default:
                return Container();
            }
          }).toList(),
        ),
      ),
    );
  }
}
