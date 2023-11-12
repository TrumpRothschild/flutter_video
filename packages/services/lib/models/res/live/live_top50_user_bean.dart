import 'dart:core';
import 'live_online_list_bean.dart';

/// onlineNum : 0
/// num : 0
/// list : []

class LiveTop50UserBean {
  LiveTop50UserBean({
    int? onlineNum,
    int? num,
    List<LiveOnlineListBean>? list,
  }) {
    _onlineNum = onlineNum;
    _num = num;
    _list = list;
  }

  LiveTop50UserBean.fromJson(dynamic json) {
    _onlineNum = json['onlineNum'];
    _num = json['num'];
    if (json['list'] != null) {
      _list = [];
      json['list'].forEach((v) {
        _list?.add(LiveOnlineListBean.fromJson(v));
      });
    }
  }

  int? _onlineNum;
  int? _num;
  List<LiveOnlineListBean>? _list;

  LiveTop50UserBean copyWith({
    int? onlineNum,
    int? num,
    List<LiveOnlineListBean>? list,
  }) =>
      LiveTop50UserBean(
        onlineNum: onlineNum ?? _onlineNum,
        num: num ?? _num,
        list: list ?? _list,
      );

  int? get onlineNum => _onlineNum;

  int? get num => _num;

  List<LiveOnlineListBean>? get list => _list;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['onlineNum'] = _onlineNum;
    map['num'] = _num;
    if (_list != null) {
      map['list'] = _list?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
