import 'package:flutter/material.dart';
import 'package:game_page/game_transaction/widgets/cancel_dialog.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';

import '../game_transaction_controller.dart';
import 'expenditure_item.dart';
import 'income_item.dart';

class TransactionListView extends StatefulWidget {
  const TransactionListView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TransactionListController controller;

  @override
  _TransactionListViewState createState() => _TransactionListViewState();
}

class _TransactionListViewState extends State<TransactionListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Color(0xffd9d9d9), width: 0.5),
          )),
          child: widget.controller.type == TransactionType.income
              ? const IncomeItem(height: 50)
              : const ExpenditureItem(height: 50),
        ),
        Expanded(
          child: SmartRefresher(
            controller: widget.controller.refreshController,
            enablePullUp: true,
            onRefresh: widget.controller.onRefresh,
            onLoading: widget.controller.onLoading,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: widget.controller.transactionList.length,
              itemBuilder: (BuildContext context, int index) {
                final item = widget.controller.transactionList[index];
                return InkWell(
                  onTap: () => widget.controller.toTransactionInfo(item),
                  child: Builder(
                    builder: (context) {
                      if (widget.controller.type == TransactionType.income) {
                        return Container(
                          color: index.isOdd
                              ? const Color(0xffF4F4F4)
                              : Colors.white,
                          child: IncomeItem(
                            item: item,
                          ),
                        );
                      } else {
                        return Container(
                          color: index.isOdd
                              ? const Color(0xffF4F4F4)
                              : Colors.white,
                          child: ExpenditureItem(
                              item: item,
                              onCancel: () async {
                                bool isConfirm = await showCancelDialog(
                                      context,
                                      customTheme: widget.controller
                                          .currentCustomThemeData(),
                                    ) ??
                                    false;
                                if (isConfirm) {
                                  widget.controller.onCancel(item.id);
                                }
                              }),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
