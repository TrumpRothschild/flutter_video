import 'package:flutter/material.dart';
import 'package:base/assets.gen.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:services/models/res/game/niu_niu/niu_niu_detail_model.dart';

import '../../live_game/live_game_page.dart';
import '../live_game_bet_page.dart';

class BetItem extends StatelessWidget {
  final CustomTheme customTheme;
  final Odds item;
  final VoidCallback? onDelete;

  const BetItem({
    Key? key,
    required this.customTheme,
    required this.item,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: customTheme.colors0xE6E6E6))),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.oddsName ?? '',
                style: TextStyle(
                  fontSize: 14,
                  color: customTheme.colors0xFF0000,
                ),
                textAlign: TextAlign.start,
              ),
              Text(
                item.parentName ?? '',
                style: TextStyle(
                  fontSize: 14,
                  color: customTheme.colors0x000000,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: onDelete,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.delete,
                        size: 18,
                        color: customTheme.colors0xBCBCBC,
                      ),
                    ],
                  ),
                ),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 14,
                    color: customTheme.colors0x000000,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "1",
                        style: TextStyle(
                          color: customTheme.colors0xBCBCBC,
                        ),
                      ),
                      Text(
                        " 注 ",
                        style: TextStyle(
                          color: customTheme.colors0xBCBCBC,
                        ),
                      ),
                      Text(
                        "${LiveGameBetController.to.currentMultiple}",
                        style: TextStyle(
                          color: customTheme.colors0xFF0000,
                        ),
                      ),
                      Text(
                        " 倍数 ",
                        style: TextStyle(
                          color: customTheme.colors0xBCBCBC,
                        ),
                      ),
                      Text(
                        "${LiveGameController.to.chip}X${LiveGameBetController.to.currentMultiple}",
                        style: TextStyle(
                          color: customTheme.colors0xFF0000,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
