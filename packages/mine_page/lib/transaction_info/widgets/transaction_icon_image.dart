import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';

class TransactionIconImage extends StatelessWidget {
  const TransactionIconImage({
    Key? key,
    required this.orderStatus,
  }) : super(key: key);

  final int orderStatus;

  @override
  Widget build(BuildContext context) {
    //1处理中，2成功，3失败，4取消，5申请中，6超时，7撒单
    switch (orderStatus) {
      case 1:
        return Assets.minePage.transactionProcessIcon.image(
          width: 111,
          height: 105,
        );
      case 2:
        return Assets.minePage.transactionSuccessIcon.image(
          width: 111,
          height: 105,
        );
      case 3:
        return Assets.minePage.transactionFailedIcon.image(
          width: 111,
          height: 105,
        );
      case 4:
        return Assets.minePage.transactionCancelIcon.image(
          width: 111,
          height: 105,
        );
      case 5:
        return Assets.minePage.transactionRequestIcon.image(
          width: 111,
          height: 105,
        );
      case 6:
        return Assets.minePage.transactionTimeoutIcon.image(
          width: 111,
          height: 105,
        );
      case 7:
        return Assets.minePage.transactionRevocationIcon.image(
          width: 111,
          height: 105,
        );
      default:
        return Assets.minePage.transactionOtherBg.image(
          width: 111,
          height: 105,
        );
    }
  }
}
