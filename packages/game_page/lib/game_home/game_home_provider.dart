import 'package:get/get.dart';
import 'package:services/api/game_apis.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/game/game_banner_bean.dart';
import 'package:services/models/res/game/game_bean.dart';
import 'package:services/models/res/game/avd_notice.dart';

class GameHomeProvider extends GetConnect {
  /// 获取首页banner数据
  static Future<List<GameSlideData>?> getBannerList() async {
    BaseResponse response = await GameApis.of().getBannerList();
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return (response.data as List<dynamic>)
        .map((e) => GameSlideData.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// 获取game数据
  static Future<List<GameBean>?> getGameData() async {
    BaseResponse response = await GameApis.of().getGameData();
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return (response.data as List<dynamic>)
        .map((e) => GameBean.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// 获取notice数据
  static Future<AvdNotice?> getAdvNotice() async {
    BaseResponse response = await GameApis.of().getAdvNotice();
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return AvdNotice.fromJson(response.data);
  }
}
