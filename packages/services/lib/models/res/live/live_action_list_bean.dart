import 'live_action_bean.dart';

/// gameList : []
/// liveList : []
/// 直播间活动列表
class LiveActionListBean {
  LiveActionListBean({
    List<LiveActionBean>? gameList,
    List<LiveActionBean>? liveList,
  }) {
    _gameList = gameList;
    _liveList = liveList;
  }

  LiveActionListBean.fromJson(dynamic json) {
    if (json['gameList'] != null) {
      _gameList = [];
      json['gameList'].forEach((v) {
        _gameList?.add(LiveActionBean.fromJson(v));
      });
    }
    if (json['liveList'] != null) {
      _liveList = [];
      json['liveList'].forEach((v) {
        _liveList?.add(LiveActionBean.fromJson(v));
      });
    }
  }

  List<LiveActionBean>? _gameList;
  List<LiveActionBean>? _liveList;

  LiveActionListBean copyWith({
    List<LiveActionBean>? gameList,
    List<LiveActionBean>? liveList,
  }) =>
      LiveActionListBean(
        gameList: gameList ?? _gameList,
        liveList: liveList ?? _liveList,
      );

  List<LiveActionBean>? get gameList => _gameList;

  List<LiveActionBean>? get liveList => _liveList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_gameList != null) {
      map['gameList'] = _gameList?.map((v) => v.toJson()).toList();
    }
    if (_liveList != null) {
      map['liveList'] = _liveList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
