import 'dart:convert';

import 'package:services/api/apis.dart';
import 'package:services/http.dart';

import '../models/res/game/niu_niu/niu_bet_post_model.dart';

/// @date 2023/02/12
/// @author bert
/// @des 游戏、彩票相关api

class GameApis {
  static GameApis of() => GameApis();

  /// game banner接口
  getBannerList() async {
    return await HttpUtil().post(
      Apis.getBannerList,
      data: {
        'flashviewCode': 'game',
      },
    );
  }

  /// game data接口
  getGameData() async {
    return await HttpUtil().post(Apis.getGameData);
  }

  /// game notice接口
  getAdvNotice() async {
    return await HttpUtil().post(
      Apis.getAdvNotice,
      data: {
        'type': 6,
      },
    );
  }

  getGameRecordList(bool isToday) async {
    return await HttpUtil().post(
      Apis.getGameRecordList,
      data: {
        'queryDate': isToday ? 1 : 2,
      },
    );
  }

  getBill({
    int lastID = 0,
    String transactionTypes = '',
    String billTypes = '',
    String orderStatus = '',
    String rangeMonth = '',
  }) async {
    return await HttpUtil().post(
      Apis.getBill,
      data: {
        "pageSize": 10,
        "billTypes": billTypes,
        // 订单状态: 1处理中,2成功,3失败,4取消,5申请中,6超时,7撤单
        // "orderStatus": orderStatus,
        // 当前页最后一条的数据的 ID
        "lastID": lastID,
        "transactionTypes": transactionTypes,
        "rangeMonth": rangeMonth,
      },
    );
  }

  getTransactionTypeList() async {
    return await HttpUtil().post(
      Apis.transactionTypeList,
    );
  }

  cancelWithdraw(
    int? userId,
    int? withdrawOrderNo,
  ) async {
    return await HttpUtil().post(
      Apis.cancelWithdraw,
      data: {
        "cancelExplain": "",
        "userId": userId,
        "billId": withdrawOrderNo,
      },
    );
  }

  withdrawResult(
    String? orderNo,
  ) async {
    return await HttpUtil().post(
      Apis.withdrawResult,
      data: {
        "orderNo": orderNo,
      },
    );
  }

  gameLogin(String gameType, int categoryId, {String? extra}) async {

    var params = {
      'gameType': gameType,
      'categoryId': categoryId,
      'channelCode': "official",
    };
    if (extra != null && extra.length >0) {
      Map valueMap = json.decode(extra);
      for (var key in valueMap.keys) {
        if (params[key] != null) {
          final value = valueMap[key];
          if (value is int) {
            params[key] = int.parse(value.toString());
          }
          else if (value is double) {
            params[key] = double.parse(value.toString());
          }
          else {
            params[key] = value.toString();
          }
        }
        else {
          final value = valueMap[key];
          if (value is int) {
            params[key] = int.parse(value.toString());
          }
          else if (value is double) {
            params[key] = double.parse(value.toString());
          }
          else {
            params[key] = value.toString();
          }
        }
      }
    }

    return await HttpUtil().post(
      Apis.gameLogin,
      data: params,
    );
  }

  getRecentInfo(int ticketId) async {
    return await HttpUtil().post(
      '${Apis.getRecentInfo}?ticketId=$ticketId',
    );
  }

  getInfo(int liveFlag, int ticketId) async {
    return await HttpUtil().post(
      Apis.getInfo,
      data: {
        'liveFlag': liveFlag,
        'ticketId': ticketId,
      },
    );
  }

  getExplain(int ticketId) async {
    return await HttpUtil().post(
      '${Apis.getExplain}?ticketId=$ticketId',
    );
  }

  getLotteryList(
    int ticketId,
    int pageNum,
    int pageSize,
  ) async {
    return await HttpUtil().post(
      Apis.getLotteryList,
      data: {
        "ticketId": ticketId,
        "pageNum": pageNum,
        "pageSize": pageSize,
      },
    );
  }

  getBetList(
    int pageNum,
    int pageSize,
    num? ticketId,
    String? tzDate,
    String? zjStatus,
  ) async {
    return await HttpUtil().post(
      Apis.getBetList,
      data: {
        "ticketId": ticketId,
        "tzDate": tzDate,
        "zjStatus": zjStatus,
        "pageNum": pageNum,
        "pageSize": pageSize,
      },
    );
  }

  niuNiuBet(NiuPostBetModel model) async {
    return await HttpUtil().post(
      Apis.niuNiuBet,
      data: jsonEncode(model.toJson()),
    );
  }

  getStatistics(
    num? ticketId,
    String? tzDate,
    String? zjStatus,
  ) async {
    return await HttpUtil().post(
      Apis.statistics,
      data: {
        "ticketId": ticketId,
        "tzDate": tzDate,
        "zjStatus": zjStatus,
      },
    );
  }

  getGameTypeList() async {
    return await HttpUtil().post(
      '${Apis.getGameTypeList}?liveFlag=0',
    );
  }

  followBetInfo(String followId) async {
    return await HttpUtil().post(
      '${Apis.followBetInfo}?followId=$followId',
    );
  }
}
