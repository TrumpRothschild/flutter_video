import 'package:get/get.dart';
import 'package:services/api/game_apis.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/game/game_transaction_list.dart';

class GameWebProvider extends GetConnect {
  static Future<BaseResponse?> gameLogin(String gameType, int categoryId, {String? extra}) async {
    BaseResponse response = await GameApis.of().gameLogin(gameType, categoryId, extra: extra);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return response;
  }
}
