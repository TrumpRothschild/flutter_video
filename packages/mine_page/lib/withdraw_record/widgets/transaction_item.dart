import 'package:base/commons/utils/number_util.dart';
import 'package:base/commons/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:services/models/res/game/game_transaction_list.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.detail,
    this.onCancel,
  }) : super(key: key);

  final VoidCallback? onCancel;
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
                child: Row(
                  children: [
                    Flexible(
                      child: Text(widget.detail.transactionTypeName ?? '', style: TextStyle(
                        fontSize: sp(24),
                      )),

                    ),
                    const SizedBox(width: 8),
                    widget.detail.canCancel
                        ? GestureDetector(
                            onTap: widget.onCancel,
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: const BoxDecoration(
                                  color: Color(0xffE6E6E6),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: const Text(
                                  '取消',
                                  style: TextStyle(
                                    color: Color(0xff747474),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  '${NumberUtil.formatNum(widget.detail.amount ?? 0.00, 2)}${widget.detail.billTypeName}',
                  textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: sp(24),
                    )
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.detail.createTimeFormatter,
                  style: TextStyle(
                    fontSize: sp(24),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  widget.detail.stateName,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: sp(24),
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
