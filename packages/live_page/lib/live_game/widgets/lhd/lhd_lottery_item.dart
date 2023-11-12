import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base/assets.gen.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:get/get.dart';
import 'package:live_page/live_game/utils/ticket_utils.dart';
import 'package:services/models/res/game/niu_niu/niu_niu_model.dart';

import '../../live_game_page.dart';
import '../../utils/ticket_function_bean.dart';

class LHDLotteryItem extends StatelessWidget {
  final GameTicketModel? model;
  final bool isLast;
  final CustomTheme customTheme;

  const LHDLotteryItem({
    Key? key,
    required this.model,
    this.isLast = false,
    required this.customTheme,
  }) : super(key: key);

  List<String> get items => TicketUtils.getLHDResultImage(
      isLast ? model?.lastKjNumber ?? '' : model?.kjNumber ?? '');

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
                items[0],
                isWin: pointLeft > pointRight,
              ),
            ),
            Expanded(
              child: _buildInfoRow(items[1],
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
    String imgAsset, {
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
              padding: const EdgeInsets.all(4),
              alignment: Alignment.center,
              child: Image.asset(
                imgAsset,
                height: 42,
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned(
              left: isLeft ? null : 4,
              right: isLeft ? 4 : null,
              child: Container(
                height: isLast ? 69 : 55,
                alignment: Alignment.center,
                child: Text(
                  isLeft ? "蓝方" : '红方',
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
