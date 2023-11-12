import 'package:flutter/material.dart';
import 'package:services/models/res/game/game_transaction_list.dart';

class IncomeItem extends StatelessWidget {
  final DetailList? item;
  final double? height;

  const IncomeItem({
    Key? key,
    this.item,
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              null == item?.amount ? '金额'  : '￥${item?.amount?.toString()}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: null == item?.amount ? 14 : 12
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              item?.billTypeName ?? '币种',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: null == item?.billTypeName ? 14 : 12
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              item?.createTimeFormatter ?? '储值时间',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: null == item?.createTimeFormatter ? 14 : 12
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              ('取消' == item?.stateName ? '已取消' : item?.stateName) ?? '状态',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: null == item?.stateName ? 14 : 12
              ),
            ),
          ),
        ],
      ),
    );
  }
}
