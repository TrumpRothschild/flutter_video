import 'package:services/models/res/game/niu_niu/niu_niu_model.dart';

/// id : 0
/// isZj : 0
/// tid : 0
/// tzInfo : ""
/// tzMoney : 0
/// tzNo : 0
/// tzQs : 0
/// tzTime : ""
/// tzZs : 0
/// zjMoney : 0

class GameBetModel {
  GameBetModel({
    this.id,
    this.isZj,
    this.tid,
    this.tzInfo,
    this.tzMoney,
    this.tzNo,
    this.tzQs,
    this.tzTime,
    this.tzZs,
    this.zjMoney,
  });

  GameBetModel.fromJson(dynamic json) {
    id = json['id'];
    isZj = json['isZj'];
    tid = json['tid'];
    tzInfo = json['tzInfo'];
    tzMoney = json['tzMoney'];
    tzNo = json['tzNo'];
    tzQs = json['tzQs'];
    tzTime = json['tzTime'];
    tzZs = json['tzZs'];
    zjMoney = json['zjMoney'];
  }

  num? id;
  num? isZj;
  num? tid;
  String? tzInfo;
  num? tzMoney;
  num? tzNo;
  num? tzQs;
  String? tzTime;
  num? tzZs;
  num? zjMoney;

  GameBetModel copyWith({
    num? id,
    num? isZj,
    num? tid,
    String? tzInfo,
    num? tzMoney,
    num? tzNo,
    num? tzQs,
    String? tzTime,
    num? tzZs,
    num? zjMoney,
  }) =>
      GameBetModel(
        id: id ?? this.id,
        isZj: isZj ?? this.isZj,
        tid: tid ?? this.tid,
        tzInfo: tzInfo ?? this.tzInfo,
        tzMoney: tzMoney ?? this.tzMoney,
        tzNo: tzNo ?? this.tzNo,
        tzQs: tzQs ?? this.tzQs,
        tzTime: tzTime ?? this.tzTime,
        tzZs: tzZs ?? this.tzZs,
        zjMoney: zjMoney ?? this.zjMoney,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['isZj'] = isZj;
    map['tid'] = tid;
    map['tzInfo'] = tzInfo;
    map['tzMoney'] = tzMoney;
    map['tzNo'] = tzNo;
    map['tzQs'] = tzQs;
    map['tzTime'] = tzTime;
    map['tzZs'] = tzZs;
    map['zjMoney'] = zjMoney;
    return map;
  }

  GameTicketModel toNiuNiuModel() {
    return GameTicketModel(
      kjNumber: tzInfo,
    );
  }
}
