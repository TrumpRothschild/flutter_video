import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base/assets.gen.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:get/get.dart';
import 'package:live_page/live_game/utils/ticket_utils.dart';
import 'package:services/models/res/game/niu_niu/niu_niu_model.dart';

import '../../live_game_page.dart';
import '../../utils/ticket_function_bean.dart';

class BRNNLotteryItem extends StatelessWidget {
  final GameTicketModel? model;
  final bool isLast;
  final CustomTheme customTheme;

  const BRNNLotteryItem({
    Key? key,
    required this.model,
    this.isLast = false,
    required this.customTheme,
  }) : super(key: key);

  TicketFunctionBean get modelLeft => TicketUtils.getResultImage(
      0, isLast ? model?.lastKjNumber ?? '' : model?.kjNumber ?? '');

  TicketFunctionBean get modelRight => TicketUtils.getResultImage(
      1, isLast ? model?.lastKjNumber ?? '' : model?.kjNumber ?? '');

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildInfoRow(modelLeft),
            ),
            Expanded(
              child: _buildInfoRow(modelRight, isLeft: false),
            ),
          ],
        ),
        if (modelLeft.winType == 2 || modelRight.winType == 2)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 24,
              alignment: Alignment.center,
              child: AssetGenImage(
                Assets.gamePage.liveGame.winBoth.path,
              ).image(
                height: 20,
                fit: BoxFit.fitHeight,
              ),
            ),
          )
      ],
    );
  }

  Widget _buildInfoRow(
    TicketFunctionBean? ticket, {
    bool isLeft = true,
  }) {
    return Stack(
      children: [
        Container(
          color: isLeft ? const Color(0xff112659) : const Color(0xff481515),
          padding: const EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                isLeft ? "蓝方" : '红方',
                style: TextStyle(
                  fontSize: 12,
                  color: customTheme.colors0xFFFFFF,
                ),
                textAlign: isLeft ? TextAlign.end : TextAlign.start,
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: (ticket != null &&
                        (ticket.resourceIds?.isNotEmpty ?? false))
                    ? List.generate(
                        ticket.resourceIds!.length,
                        (index) => Image.asset(
                          ticket.resourceIds![index],
                          height: 42,
                          fit: BoxFit.fitHeight,
                        ),
                      ).toList()
                    : List.generate(
                        5,
                        (index) => AssetGenImage(
                          Assets.gamePage.liveGame.cardDefault.path,
                        ).image(
                          height: 42,
                          fit: BoxFit.fitHeight,
                        ),
                      ).toList(),
              )
            ],
          ),
        ),
        if (ticket?.statusNameResourceId?.isNotEmpty ?? false)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    customTheme.colors0x000000,
                    Colors.transparent,
                  ],
                ),
              ),
              child: Image.asset(
                ticket?.statusNameResourceId ?? '',
                height: 18,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        if (ticket?.winType == 1)
          Positioned(
            left: isLeft ? 0 : null,
            right: isLeft ? null : 0,
            top: 0,
            child: AssetGenImage(
              isLeft
                  ? Assets.gamePage.liveGame.winLeft.path
                  : Assets.gamePage.liveGame.winRight.path,
            ).image(
              height: 20,
              fit: BoxFit.fitHeight,
            ),
          ),
      ],
    );
  }
}
