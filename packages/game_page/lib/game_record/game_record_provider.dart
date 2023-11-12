import 'package:get/get.dart';
import 'package:services/api/game_apis.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/game/game_banner_bean.dart';
import 'package:services/models/res/game/game_bean.dart';
import 'package:services/models/res/game/game_record_list.dart';

class GameRecordProvider extends GetConnect {
  static Future<GameRecordListModel?> getRecordData(bool isToday) async {
    BaseResponse response = await GameApis.of().getGameRecordList(isToday);
    if (GetUtils.isNull(response) == true) {
      return null;
    }


    return GameRecordListModel.fromJson(response.data);
  }
}
