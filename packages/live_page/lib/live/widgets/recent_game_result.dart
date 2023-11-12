import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:live_page/live_game/widgets/bjl/bjl_lottery_result.dart';
import 'package:live_page/live_game/widgets/brnn/brnn_lottery_result.dart';
import 'package:live_page/live_game/widgets/lhd/lhd_lottery_result.dart';
import 'package:live_page/live_game/widgets/yfkc/yfkc_lottery_result.dart';
import 'package:live_page/live_game/widgets/yfks/yfks_lottery_result.dart';
import 'package:live_page/live_game/widgets/yflhc/yflhc_lottery_result.dart';
import 'package:live_page/live_game/widgets/yfssc/yfssc_lottery_result.dart';
import 'package:live_page/live_game/widgets/yxx/yxx_lottery_result.dart';
import 'package:services/models/res/game/niu_niu/niu_niu_model.dart';

import '../../utils/im_msg_utils.dart';
import '../live_page.dart';

class RecentGameResult extends StatelessWidget {
  final String ticketMessage;
  final CustomTheme customTheme;

  const RecentGameResult({
    Key? key,
    required this.ticketMessage,
    required this.customTheme,
  }) : super(key: key);

  GameTicketModel? get model =>  ImMsgUtils.of().convertTicket(
        ticketMessage,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: customTheme.colors0x000000_30,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: InkWell(
        onTap: () => LiveController.of.toGameBetBottom(model?.tId),
        child: model?.tId == 1
            ? BRNNLotteryResult(model: model, customTheme: customTheme)
            : model?.tId == 2
                ? YXXLotteryResult(model: model, customTheme: customTheme)
                : model?.tId == 3
                    ? LHDLotteryResult(model: model, customTheme: customTheme)
                    : model?.tId == 4
                        ? BJLLotteryResult(
                            model: model, customTheme: customTheme)
                        : model?.tId == 5
                            ? YFKSLotteryResult(
                                model: model, customTheme: customTheme)
                            : model?.tId == 6
                                ? YFSSCLotteryResult(
                                    model: model, customTheme: customTheme)
                                : model?.tId == 7
                                    ? YFLHCLotteryResult(
                                        model: model, customTheme: customTheme)
                                    : model?.tId == 8
                                        ? YFKCLotteryResult(
                                            model: model,
                                            customTheme: customTheme)
                                        : Container(),
      ),
    );
  }
}
