import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base/assets.gen.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:get/get.dart';
import 'package:live_page/live_game/utils/ticket_utils.dart';
import 'package:services/models/res/game/niu_niu/niu_niu_model.dart';

import '../../live_game_page.dart';
import '../../utils/ticket_function_bean.dart';

class BJLLotteryItem extends StatelessWidget {
  final GameTicketModel? model;
  final bool isLast;
  final CustomTheme customTheme;

  const BJLLotteryItem({
    Key? key,
    required this.model,
    this.isLast = false,
    required this.customTheme,
  }) : super(key: key);

  TicketFunctionBean get modelLeft => TicketUtils.getBJLResultImage(
      0, isLast ? model?.lastKjNumber ?? '' : model?.kjNumber ?? '');

  TicketFunctionBean get modelRight => TicketUtils.getBJLResultImage(
      1, isLast ? model?.lastKjNumber ?? '' : model?.kjNumber ?? '');

  int get pointLeft => TicketUtils.getLHDResultPoint(
      0, isLast ? model?.lastKjNumber ?? '' : model?.kjNumber ?? '');

  int get pointRight => TicketUtils.getLHDResultPoint(
      1, isLast ? model?.lastKjNumber ?? '' : model?.kjNumber ?? '');

  String get number => '第${isLast ? model?.lastKjNo : model?.kjNo}期';

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    bool isWin = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!isLast)
          Opacity(
            opacity: isLeft ? 1 : 0,
            child: Text(
              number,
              style: TextStyle(
                fontSize: 14,
                color: customTheme.colors0xFFFFFF,
              ),
            ),
          ),
        const SizedBox(height: 2),
        Stack(
          children: [
            Container(
              height: isLast ? 69 : 55,
              color: isLeft ? const Color(0xff112659) : const Color(0xff481515),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  ticket?.resourceIds?.length ?? 0,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Image.asset(
                      (ticket != null &&
                              (ticket.resourceIds?.isNotEmpty ?? false))
                          ? ticket.resourceIds![index]
                          : Assets.gamePage.liveGame.cardDefault.path,
                      height: 42,
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
            Positioned(
              left: isLeft ? null : 4,
              right: isLeft ? 4 : null,
              child: Container(
                height: isLast ? 69 : 55,
                alignment: Alignment.center,
                child: Text(
                  isLeft ? "闲" : '庄',
                  style: TextStyle(
                    fontSize: 12,
                    color: customTheme.colors0xFFFFFF,
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
        ),
      ],
    );
  }
}
