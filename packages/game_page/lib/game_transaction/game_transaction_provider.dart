import 'package:get/get.dart';
import 'package:services/api/game_apis.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/game/game_transaction_list.dart';

class GameTransactionProvider extends GetConnect {
  static Future<GameTransactionModel?> getBill({
    required int lastID,
    required String transactionTypes,
    required String billTypes,
  }) async {
    BaseResponse response =
        await GameApis.of().getBill(lastID: lastID, transactionTypes: transactionTypes, billTypes: billTypes);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
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
}
