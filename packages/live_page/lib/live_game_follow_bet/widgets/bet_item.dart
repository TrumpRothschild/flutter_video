import 'package:flutter/material.dart';
import 'package:base/assets.gen.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:services/models/res/game/follow_bet_Info_model.dart';
import 'package:services/models/res/game/niu_niu/niu_niu_detail_model.dart';

import '../../live_game/live_game_page.dart';
import '../live_game_follow_bet_page.dart';

class FollowBetItem extends StatelessWidget {
  final CustomTheme customTheme;
  final String? ticketName;
  final String? oddsName;
  final TomList? item;
  final VoidCallback? onDelete;
  final bool isHeader;

  const FollowBetItem({
    Key? key,
    required this.customTheme,
    this.ticketName,
    this.oddsName,
    this.item,
    this.onDelete,
    this.isHeader = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: customTheme.colors0xE6E6E6),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(color: customTheme.colors0xE6E6E6))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isHeader)
                    Text(
                      '玩法',
                      style: TextStyle(
                        fontSize: 14,
                        color: customTheme.colors0x000000,
                      ),
                    )
                  else ...[
                    Text(
                      '${ticketName ?? ''}-${item?.bname ?? ''}丨${oddsName ?? item?.oddsName}',
                      style: TextStyle(
                        fontSize: 14,
                        color: customTheme.colors0x000000,
                      ),
                    ),
                    Text(
                      '',
                      style: TextStyle(
                        fontSize: 14,
                        color: customTheme.colors0xFF0000,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Container(
            width: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(color: customTheme.colors0xE6E6E6))),
            child: isHeader
                ? Text('赔率',
                    style: TextStyle(
                      fontSize: 14,
                      color: customTheme.colors0x000000,
                    ))
                : Text(
                    item?.odds?.toStringAsFixed(1) ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      color: customTheme.colors0x9F44FF,
                    ),
                  ),
          ),
          Container(
            width: 96,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(color: customTheme.colors0xE6E6E6))),
            child: isHeader
                ? Text(
                    '金额',
                    style: TextStyle(
                      fontSize: 14,
                      color: customTheme.colors0x000000,
                    ),
                  )
                : SizedBox.expand(
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: customTheme.colors0xD9D9D9),
                      ),
                      child: Text(
                        item?.amount?.toStringAsFixed(0) ?? '',
                        style: TextStyle(
                            fontSize: 14, color: customTheme.colors0x000000),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          ),
          GestureDetector(
            onTap: onDelete,
            child: Container(
              width: 50,
              alignment: Alignment.center,
              child: isHeader
                  ? Text(
                      '删除',
                      style: TextStyle(
                        fontSize: 14,
                        color: customTheme.colors0x000000,
                      ),
                    )
                  : Icon(
                      Icons.delete,
                      size: 18,
                      color: customTheme.colors0x000000,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
