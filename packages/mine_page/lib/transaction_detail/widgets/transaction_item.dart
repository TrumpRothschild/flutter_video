import 'package:base/commons/utils/number_util.dart';
import 'package:flutter/material.dart';
import 'package:services/models/res/game/game_transaction_list.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.detail,
  }) : super(key: key);

  final DetailList detail;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10).copyWith(left: 14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(widget.detail.changeTypeName ?? ''),
              ),
              Expanded(
                  child: Text(
                '￥${NumberUtil.formatNum(double.parse(widget.detail.valideAmount), 2)}${widget.detail.billTypeName}',
                textAlign: TextAlign.end,
              )),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.detail.createTimeFormatter,
                ),
              ),
              Expanded(
                child: Text(
                  widget.detail.stateName,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Color(widget.detail.stateColor),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
