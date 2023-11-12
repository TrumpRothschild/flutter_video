import 'package:base/commons/utils/log_utils.dart';
import 'package:get/get.dart';
import 'package:services/api/game_apis.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/game/game_transaction_list.dart';

class WithdrawRecordProvider extends GetConnect {
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

  static Future<BaseResponse?> cancelWithdraw(
    int? userId,
    int? withdrawOrderId,
  ) async {
    BaseResponse response =
        await GameApis.of().cancelWithdraw(userId, withdrawOrderId);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return response;
  }

  static Future<BaseResponse?> withdrawResult(String? orderNo) async {
    BaseResponse response = await GameApis.of().withdrawResult(orderNo);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return response;
  }
}
