import 'package:get/get.dart';
import 'package:services/api/game_apis.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/game/game_bet_model.dart';
import 'package:services/models/res/game/game_type_model.dart';
import 'package:services/models/res/game/niu_niu/niu_niu_model.dart';
import 'package:services/models/res/game/niu_niu/niu_niu_detail_model.dart';
import 'package:services/models/res/game/niu_niu/niu_explain_model.dart';
import 'package:services/models/res/game/niu_niu/niu_bet_post_model.dart';
import 'package:services/models/res/game/niu_niu/niu_bet_result_model.dart';
import 'package:services/models/res/game/game_statistics.dart';
import 'package:services/models/res/game/follow_bet_Info_model.dart';

class LiveGameProvider extends GetConnect {
  static Future<GameTicketModel?> getRecentInfo(int ticketId) async {
    BaseResponse response = await GameApis.of().getRecentInfo(ticketId);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return GameTicketModel.fromJson(response.data);
  }

  static Future<List<NiuNiuDetailModel?>> getDetailInfo(
      int liveFlag, int ticketId) async {
    BaseResponse response = await GameApis.of().getInfo(liveFlag, ticketId);
    if (GetUtils.isNull(response) == true) {
      return [];
    }
    return (response.data as List<dynamic>?)
            ?.map(
              (e) => NiuNiuDetailModel.fromJson(e as Map<String, dynamic>),
            )
            .toList() ??
        [];
  }

  static Future<NiuExplainModel?> getExplain(int ticketId) async {
    BaseResponse response = await GameApis.of().getExplain(ticketId);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return NiuExplainModel.fromJson(response.data);
  }

  static Future<List<GameTicketModel?>> getLotteryList(
    int ticketId, {
    int pageNum = 1,
    int pageSize = 20,
  }) async {
    BaseResponse response =
        await GameApis.of().getLotteryList(ticketId, pageNum, pageSize);
    if (GetUtils.isNull(response) == true) {
      return [];
    }
    return (response.data as List<dynamic>?)
            ?.map(
              (e) => GameTicketModel.fromJson(e as Map<String, dynamic>),
            )
            .toList() ??
        [];
  }

  static Future<List<GameBetModel?>> getBetList({
    int pageNum = 1,
    int pageSize = 20,
    num? ticketId,
    String? tzDate,
    String? zjStatus,
    bool isAll = false,
  }) async {
    BaseResponse response = await GameApis.of()
        .getBetList(pageNum, pageSize, ticketId, tzDate, zjStatus);
    if (GetUtils.isNull(response) == true) {
      return [];
    }
    return (response.data as List<dynamic>?)
            ?.map(
              (e) => GameBetModel.fromJson(e as Map<String, dynamic>),
            )
            .toList() ??
        [];
  }

  static Future<NiuBetResultModel?> bet(NiuPostBetModel model) async {
    BaseResponse response = await GameApis.of().niuNiuBet(model);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return NiuBetResultModel.fromJson(response.data);
  }

  static Future<List<GameTypeModel?>> getGameTypeList() async {
    BaseResponse response = await GameApis.of().getGameTypeList();
    if (GetUtils.isNull(response) == true) {
      return [];
    }
    return (response.data as List<dynamic>?)
            ?.map(
              (e) => GameTypeModel.fromJson(e as Map<String, dynamic>),
            )
            .toList() ??
        [];
  }

  static Future<GameStatistics?> getStatistics({
    num? ticketId,
    String? tzDate,
    String? zjStatus,
  }) async {
    BaseResponse response =
        await GameApis.of().getStatistics(ticketId, tzDate, zjStatus);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return GameStatistics.fromJson(response.data);
  }

  static Future<FollowBetInfoModel?> followBetInfo({
    required String followId,
  }) async {
    BaseResponse response =
        await GameApis.of().followBetInfo(followId);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return FollowBetInfoModel.fromJson(response.data);
  }
}
