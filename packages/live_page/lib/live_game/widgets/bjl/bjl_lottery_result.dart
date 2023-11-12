import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base/assets.gen.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:get/get.dart';
import 'package:live_page/live_game/utils/ticket_utils.dart';
import 'package:services/models/res/game/niu_niu/niu_niu_model.dart';

import '../../live_game_page.dart';
import '../../utils/ticket_function_bean.dart';

class BJLLotteryResult extends StatelessWidget {
  final GameTicketModel? model;
  final CustomTheme customTheme;

  const BJLLotteryResult({
    Key? key,
    required this.model,
    required this.customTheme,
  }) : super(key: key);

  TicketFunctionBean get modelLeft =>
      TicketUtils.getBJLResultImage(0, model?.lastKjNumber ?? '');

  TicketFunctionBean get modelRight =>
      TicketUtils.getBJLResultImage(1, model?.lastKjNumber ?? '');

  int get pointLeft =>
      TicketUtils.getLHDResultPoint(0, model?.lastKjNumber ?? '');

  int get pointRight =>
      TicketUtils.getLHDResultPoint(1, model?.lastKjNumber ?? '');

  String get number => '百家乐 ${model?.lastKjNo}期';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
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
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildInfoRow(
                      modelLeft,
                      isWin: pointLeft > pointRight,
                    ),
                  ),
                  Expanded(
                    child: _buildInfoRow(modelRight,
                        isLeft: false, isWin: pointLeft < pointRight),
                  ),
                ],
              ),
              if (pointLeft == pointRight)
                Positioned(
                  top: 0,
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
    bool isWin = false,
  }) {
    return Stack(
      children: [
        Container(
          color: isLeft ? const Color(0xff112659) : const Color(0xff481515),
          height: 38,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              ticket?.resourceIds?.length ?? 0,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Image.asset(
                  (ticket != null && (ticket.resourceIds?.isNotEmpty ?? false))
                      ? ticket.resourceIds![index]
                      : Assets.gamePage.liveGame.cardDefault.path,
                  height: 30,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ).toList(),
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
        Positioned(
          left: isLeft ? null : 0,
          right: isLeft ? 0 : null,
          bottom: 0,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              isLeft ? "闲" : '庄',
              style: TextStyle(
                fontSize: 14,
                color: isLeft
                    ? customTheme.colors0x0085FF
                    : customTheme.colors0xFF2B2B,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        if (isWin)
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
