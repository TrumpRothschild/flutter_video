import 'package:get/get.dart';
import 'package:services/api/common_apis.dart';
import 'package:services/api/live_apis.dart';
import 'package:services/models/res/base_response.dart';

import 'models/ranking_user_bean.dart';

class RankingUserProvider extends GetConnect {
  /// 获取平台主播列表
  /// isPrevious	是否上期：是：查询上一天，上周，月的数据 [必填]
  /// type 查询类型 1：日 2:周 3：月 4：总 [必填]
  static Future<List<RankingUserBean>> getAnchorList({
    bool isPrevious = false,
    required int type,
  }) async {
    BaseResponse response = await LiveApis.of().getAnchorList(
      type: type,
      isPrevious: isPrevious,
    );
    if (GetUtils.isNull(response) == true) {
      return [];
    }

    final dataArr = response.data as List;
    return dataArr
        .map((e) => RankingUserBean.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// 获取平台土豪列表
  /// isPrevious	是否上期：是：查询上一天，上周，月的数据 [必填]
  /// type 查询类型 1：日 2:周 3：月 4：总 [必填]
  static Future<List<RankingUserBean>> getToffList({
    bool isPrevious = false,
    required int type,
  }) async {
    BaseResponse response = await LiveApis.of().getToffList(
      type: type,
      isPrevious: isPrevious,
    );
    if (GetUtils.isNull(response) == true) {
      return [];
    }

    final dataArr = response.data as List;
    return dataArr
        .map((e) => RankingUserBean.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// 关注主播
  static Future<bool> focusUser({
    bool isInRoom = false,
    required int focusUserId,
  }) async {
    BaseResponse response = await CommonApis.of().focusUser({
      "focusUserId": focusUserId,
      "isInRoom": isInRoom,
    });
    if (GetUtils.isNull(response) == true) {
      return false;
    }

    return response.code == 200;
  }

  /// 关注主播
  static Future<bool> unfocusUser({
    bool isInRoom = false,
    required int focusUserId,
  }) async {
    BaseResponse response = await CommonApis.of().unfocusUser({
      "focusUserId": focusUserId,
      "isInRoom": isInRoom,
    });
    if (GetUtils.isNull(response) == true) {
      return false;
    }

    return response.code == 200;
  }
}
