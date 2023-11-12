import 'package:base/commons/utils/log_utils.dart';
import 'package:get/get.dart';
import 'package:mine_page/transaction_detail/models/transaction_type_bean.dart';
import 'package:services/api/game_apis.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/game/game_transaction_list.dart';

class TransactionDetailProvider extends GetConnect {
  static Future<GameTransactionModel?> getBill({
    int lastID = 0,
    String transactionTypes = '',
    String billTypes = '',
    String orderStatus = '',
    String rangeMonth = '',
  }) async {
    BaseResponse response = await GameApis.of().getBill(
      lastID: lastID,
      transactionTypes: transactionTypes,
      billTypes: billTypes,
      orderStatus: orderStatus,
      rangeMonth: rangeMonth,
    );
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    Log.d('response: $response');
    return GameTransactionModel.fromJson(response.data);
  }

  static Future<List<TransactionTypeBean>> getTransactionTypeList() async {
    BaseResponse response = await GameApis.of().getTransactionTypeList();
    if (GetUtils.isNull(response.data) == true) {
      return [];
    }

    final resList = response.data as List? ?? [];
    if (resList.isEmpty) return [];

    return resList
        .map(
          (e) => TransactionTypeBean.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }
}
