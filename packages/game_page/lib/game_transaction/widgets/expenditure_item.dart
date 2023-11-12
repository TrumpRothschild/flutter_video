import 'package:flutter/material.dart';
import 'package:services/models/res/game/game_transaction_list.dart';

class ExpenditureItem extends StatelessWidget {
  final DetailList? item;
  final VoidCallback? onCancel;
  final double height;

  const ExpenditureItem({
    Key? key,
    this.item,
    this.height = 50,
    this.onCancel,
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
            flex: 3,
            child: Text(
              null == item?.amount ? '金额'  : '￥${item?.amount?.toString()}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 14
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              null == item ? '提现方式' : '银行卡',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 14
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              item?.createTimeFormatter ?? '提现时间',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 14
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              ('取消' == item?.stateName ? '已取消' : item?.stateName) ?? '状态',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 14
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: onCancel != null
                ? (item?.canCancel ?? false)
                    ? GestureDetector(
                        onTap: onCancel,
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
                    : Container()
                : const Text(
                    '操作',
                    textAlign: TextAlign.center,
                  ),
          ),
        ],
      ),
    );
  }
}
