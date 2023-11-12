import 'package:get/get.dart';
import 'package:services/api/common_apis.dart';
import 'package:services/api/live_apis.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/game/game_tab_model.dart';
import 'package:services/models/res/game/live_game_model.dart';
import 'package:services/models/res/live/agora_token_bean.dart';
import 'package:services/models/res/live/anchor_card_bean.dart';
import 'package:services/models/res/live/live_gift_bean.dart';
import 'package:services/models/res/live/live_room_detail.dart';
import 'package:services/models/res/live/live_send_gift_bean.dart';

import '../models/res/home/home_live_bean.dart';
import '../models/res/live/live_action_list_bean.dart';
import '../models/res/live/live_top50_user_bean.dart';
import '../models/res/live/live_user_detail_bean.dart';

class LiveProvider extends GetConnect {
  /// 获取直播间用户/主播名片
  static Future<LiveUserDetailBean?> getUserDetailInfo(
      Map<String, dynamic> params) async {
    BaseResponse response = await LiveApis.of().getUserDetailInfo(params);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return LiveUserDetailBean.fromJson(response.data);
  }

  /// 获取直播间主播名片
  static Future<AnchorCardBean?> getAnchorCard(int userId) async {
    BaseResponse response = await LiveApis.of().getAnchorCard(userId);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return AnchorCardBean.fromJson(response.data);
  }

  /// 获取直播间推荐直播
  static Future<List<HomeLiveBean>> getLiveRecommendList({
    required String studioNum,
    required int pageNum,
    required int pageSize,
  }) async {
    BaseResponse response = await LiveApis.of().getLiveRecommendList(
      studioNum: studioNum,
      pageNum: pageNum,
      pageSize: pageSize,
    );
    if (GetUtils.isNull(response) == true) {
      return [];
    }

    return (response.data as List<dynamic>)
        .map((e) => HomeLiveBean.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// 关注主播
  static Future<bool> focusUser({
    bool isInRoom = true,
    required num focusUserId,
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
    bool isInRoom = true,
    required num focusUserId,
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

  static Future<List<GameTabModel?>> getGameCodeList() async {
    BaseResponse response = await CommonApis.of().getGameCodeList();
    if (GetUtils.isNull(response) == true) {
      return [];
    }
    return (response.data as List<dynamic>?)
            ?.map(
              (e) => GameTabModel.fromJson(e as Map<String, dynamic>),
            )
            .toList() ??
        [];
  }

  static Future<List<LiveGameModel?>> getLiveGameList(
      {required String code}) async {
    BaseResponse response = await CommonApis.of().getLiveGameList(code);
    if (GetUtils.isNull(response) == true) {
      return [];
    }
    return (response.data as List<dynamic>?)
            ?.map(
              (e) => LiveGameModel.fromJson(e as Map<String, dynamic>),
            )
            .toList() ??
        [];
  }

  /// 查询直播间在线观众50个 直播间top50 列表
  static Future<LiveTop50UserBean?> liveStudioTop50({
    required String studioNum,
  }) async {
    BaseResponse response = await LiveApis.of().liveStudioTop50(
      studioNum: studioNum,
    );
    if (GetUtils.isNull(response.data) == true) {
      return null;
    }

    return LiveTop50UserBean.fromJson(response.data as Map<String, dynamic>);
  }

  /// 通过房间号获取直播间详情,进入房间之前请求的接口
  static Future<LiveRoomDetail?> getLiveRoomDetail(
      Map<String, dynamic> params) async {
    BaseResponse response = await LiveApis.of().getLiveRoomDetail(params);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return LiveRoomDetail.fromJson(response.data);
  }

  /// 获取推流和拉流的token
  static Future<AgoraTokenBean?> getRtcToken(
      Map<String, dynamic> params) async {
    BaseResponse response = await LiveApis.of().getRtcToken(params);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return AgoraTokenBean.fromJson(response.data);
  }

  /// 直播礼物列表
  static Future<List<LiveGiftBean>?> giftList() async {
    BaseResponse response = await LiveApis.of().giftList();
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return (response.data as List<dynamic>)
        .map((e) => LiveGiftBean.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// 礼物打赏接口
  static Future<LiveSendGiftBean?> giftGiving(
      Map<String, dynamic> params) async {
    BaseResponse response = await LiveApis.of().giftGiving(params);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return LiveSendGiftBean.fromJson(response.data);
  }

  /// 获取直播间举报原因
  static Future<List<String>?> getLiveReportReason() async {
    return ['政治谣言', '色情低俗', '商业广告', '侮辱谩骂'];
  }

  /// 直播间活动信息列表
  static Future<LiveActionListBean?> getRoomActList() async {
    BaseResponse response = await LiveApis.of().getRoomActList();
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return LiveActionListBean.fromJson(response.data);
  }
}
