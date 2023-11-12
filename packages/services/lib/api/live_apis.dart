import 'package:services/api/apis.dart';
import 'package:services/http.dart';

/// @date 2023/02/12
/// @author bert
/// @des 直播相关api

class LiveApis {
  static LiveApis of() => LiveApis();

  /// 获取直播间用户/主播名片
  getUserDetailInfo(Map<String, dynamic> params) async {
    return await HttpUtil().post(Apis.getUserDetailInfo, data: params);
  }

  /// 直播间主播名片进度
  getAnchorCard(int userId) async {
    return await HttpUtil().post(Apis.getAnchorCard, data: {'userId': userId});
  }

  /// 直播间推荐直播列表 接口
  getLiveRecommendList({
    required int pageNum,
    int pageSize = 10,
    required String studioNum,
  }) async {
    return await HttpUtil().post(
      Apis.getLiveRecommendList,
      data: {
        "pageNum": pageNum,
        "pageSize": pageSize,
        "studioNum": studioNum,
      },
    );
  }

  /// 直播间推荐直播列表 接口
  ///	1 日榜 2周榜 3月榜
  getContributionList({
    int dateType = 10,
  }) async {
    return await HttpUtil().post(
      Apis.getContributionList,
      data: {
        "dateType": dateType,
      },
    );
  }

  /// 平台主播排行榜
  getAnchorList({
    bool isPrevious = false,
    required int type,
  }) async {
    return await HttpUtil().post(
      Apis.getAnchorList,
      data: {
        "isPrevious": isPrevious,
        "type": type,
      },
    );
  }

  /// 平台土豪排行榜
  getToffList({
    bool isPrevious = false,
    required int type,
  }) async {
    return await HttpUtil().post(
      Apis.getToffList,
      data: {
        "isPrevious": isPrevious,
        "type": type,
      },
    );
  }

  /// 查询直播间在线观众50个 直播间top50 列表
  liveStudioTop50({
    required String studioNum,
  }) async {
    return await HttpUtil().post(
      Apis.liveStudioTop50,
      data: {
        "studioNum": studioNum,
      },
    );
  }

  /// 通过房间号获取直播间详情,进入房间之前请求的接口
  getLiveRoomDetail(Map<String, dynamic> params) async {
    return await HttpUtil().post(Apis.getLiveRoomDetail, data: params);
  }

  /// 获取推流和拉流的token
  getRtcToken(Map<String, dynamic> params) async {
    return await HttpUtil().post(Apis.getRtcToken, data: params);
  }

  /// 直播礼物列表
  giftList() async {
    return await HttpUtil().post(Apis.giftList);
  }

  /// 礼物打赏接口
  giftGiving(Map<String, dynamic> params) async {
    return await HttpUtil().post(Apis.giftGiving, data: params);
  }

  /// 直播间活动信息列表
  getRoomActList() async {
    return await HttpUtil().post(Apis.getRoomActList);
  }
}
