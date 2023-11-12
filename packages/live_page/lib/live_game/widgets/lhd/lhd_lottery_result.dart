import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base/assets.gen.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:get/get.dart';
import 'package:live_page/live_game/utils/ticket_utils.dart';
import 'package:services/models/res/game/niu_niu/niu_niu_model.dart';

import '../../live_game_page.dart';
import '../../utils/ticket_function_bean.dart';

class LHDLotteryResult extends StatelessWidget {
  final GameTicketModel? model;
  final CustomTheme customTheme;

  const LHDLotteryResult({
    Key? key,
    required this.model,
    required this.customTheme,
  }) : super(key: key);

  List<String> get items =>
      TicketUtils.getLHDResultImage(model?.lastKjNumber ?? '');

  int get pointLeft =>
      TicketUtils.getLHDResultPoint(0, model?.lastKjNumber ?? '');

  int get pointRight =>
      TicketUtils.getLHDResultPoint(1, model?.lastKjNumber ?? '');

  String get number => '龙虎斗 ${model?.lastKjNo}期';

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
            alignment: Alignment.center,
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
    String imgAsset, {
    bool isLeft = true,
    bool isWin = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            Container(
              height: 38,
              color: isLeft ? const Color(0xff112659) : const Color(0xff481515),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!isLeft)
                    Text(
                      '庄',
                      style: TextStyle(
                        fontSize: 12,
                        color: customTheme.colors0xFF2B2B,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: isLeft ? 0 : 8, right: isLeft ? 8 : 0),
                    child: Image.asset(
                      imgAsset,
                      height: 30,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  if (isLeft)
                    Text(
                      "闲",
                      style: TextStyle(
                        fontSize: 12,
                        color: customTheme.colors0x0085FF,
                      ),
                      textAlign: TextAlign.center,
                    )
                ],
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
