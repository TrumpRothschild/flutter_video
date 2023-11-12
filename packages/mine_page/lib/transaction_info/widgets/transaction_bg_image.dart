import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';

class TransactionBgImage extends StatelessWidget {
  const TransactionBgImage({
    Key? key,
    required this.orderStatus,
  }) : super(key: key);

  final int orderStatus;

  @override
  Widget build(BuildContext context) {
    //1处理中，2成功，3失败，4取消，5申请中，6超时，7撒单
    switch (orderStatus) {
      case 1:
        return Assets.minePage.transactionProcessBg.image(
          width: double.infinity,
          height: MediaQuery.of(context).size.width / (375 / 547),
          fit: BoxFit.cover,
        );
      case 2:
        return Assets.minePage.transactionSuccessBg.image(
          width: double.infinity,
          height: MediaQuery.of(context).size.width / (375 / 547),
          fit: BoxFit.cover,
        );
      case 5:
        return Assets.minePage.transactionRequestBg.image(
          width: double.infinity,
          height: MediaQuery.of(context).size.width / (375 / 547),
          fit: BoxFit.cover,
        );
      default:
        return Assets.minePage.transactionOtherBg.image(
          width: double.infinity,
          height: MediaQuery.of(context).size.width / (375 / 547),
          fit: BoxFit.cover,
        );
    }
  }
}
