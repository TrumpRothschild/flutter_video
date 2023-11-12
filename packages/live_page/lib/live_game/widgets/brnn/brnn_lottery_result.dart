import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base/assets.gen.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:get/get.dart';
import 'package:live_page/live_game/utils/ticket_utils.dart';
import 'package:services/models/res/game/niu_niu/niu_niu_model.dart';

import '../../live_game_page.dart';
import '../../utils/ticket_function_bean.dart';

class BRNNLotteryResult extends StatelessWidget {
  final GameTicketModel? model;
  final CustomTheme customTheme;

  const BRNNLotteryResult({
    Key? key,
    required this.model,
    required this.customTheme,
  }) : super(key: key);

  TicketFunctionBean get modelLeft => TicketUtils.getResultImage(
      0,  model?.lastKjNumber ?? '');

  TicketFunctionBean get modelRight => TicketUtils.getResultImage(
      1,  model?.lastKjNumber ?? '');

  String get number => '百人牛牛 ${model?.lastKjNo}期';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      padding: const EdgeInsets.all(10).copyWith(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              number,
              style: TextStyle(
                fontSize: 12,
                color: customTheme.colors0xFFDB5C,
              ),
            ),
          ),
          Stack(
            alignment: Alignment.center,
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
                  left: 0,
                  right: 0,
                  child: AssetGenImage(
                    Assets.gamePage.liveGame.winBoth.path,
                  ).image(
                    height: 15,
                    fit: BoxFit.fitHeight,
                  ),
                )
            ],
          ),
        ],
      ),
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
          height: 38,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  ticket?.resourceIds?.length ?? 0,
                  (index) => Image.asset(
                    (ticket != null &&
                            (ticket.resourceIds?.isNotEmpty ?? false))
                        ? ticket.resourceIds![index]
                        : Assets.gamePage.liveGame.cardDefault.path,
                    height: 30,
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
              height: 16,
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
                height: 14,
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
