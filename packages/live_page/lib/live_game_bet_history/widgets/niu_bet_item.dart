import 'package:base/themes/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:services/models/res/game/game_bet_model.dart';

class NiuBetItem extends StatelessWidget {
  final CustomTheme customTheme;
  final GameBetModel? item;

  const NiuBetItem({
    Key? key,
    required this.customTheme,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: customTheme.colors0xF4F4F4,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "期号：${item?.tzQs ?? ''}",
                  style: TextStyle(
                    fontSize: 14,
                    color: customTheme.colors0x000000,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                child: Text(
                  "注单号：${item?.tzNo ?? ''}",
                  style: TextStyle(
                    fontSize: 14,
                    color: customTheme.colors0x000000,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  _ChildItem(
                    name: '投注信息：',
                    value: item?.tzInfo ?? '',
                  ),
                  _ChildItem(
                    name: '${item?.tzZs ?? ''}',
                    value: '10',
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _ChildItem(
                    name: '投注金额：',
                    value: '￥${item?.tzMoney ?? ''}',
                  ),
                  _ChildItem(
                    name: '中奖金额：',
                    value: '￥${item?.zjMoney ?? ''}',
                    valueColor: Colors.red,
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ChildItem extends StatelessWidget {
  final String name;
  final String value;
  final Color valueColor;

  const _ChildItem({
    required this.name,
    required this.value,
    this.valueColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Text(
            name,
            style: const TextStyle(color: Color(0xffB1B1B1), fontSize: 14),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(color: valueColor, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
