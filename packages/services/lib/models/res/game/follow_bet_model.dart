/// followId : "23031100119"
/// amount : 15.0
/// kjNo : 202303111230
/// nickName : "UYFPFE1J"
/// ticketNameEn : "Baccarat"
/// userId : 406
/// ticketId : 4
/// studioNum : "1522_0"
/// ticketName : "百家乐"

class FollowBetModel {
  FollowBetModel({
    this.followId,
    this.amount,
    this.kjNo,
    this.nickName,
    this.ticketNameEn,
    this.userId,
    this.ticketId,
    this.studioNum,
    this.ticketName,
  });

  FollowBetModel.fromJson(dynamic json) {
    followId = json['followId'];
    amount = json['amount'];
    kjNo = json['kjNo'];
    nickName = json['nickName'];
    ticketNameEn = json['ticketNameEn'];
    userId = json['userId'];
    ticketId = json['ticketId'];
    studioNum = json['studioNum'];
    ticketName = json['ticketName'];
  }

  String? followId;
  num? amount;
  num? kjNo;
  String? nickName;
  String? ticketNameEn;
  num? userId;
  num? ticketId;
  String? studioNum;
  String? ticketName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['followId'] = followId;
    map['amount'] = amount;
    map['kjNo'] = kjNo;
    map['nickName'] = nickName;
    map['ticketNameEn'] = ticketNameEn;
    map['userId'] = userId;
    map['ticketId'] = ticketId;
    map['studioNum'] = studioNum;
    map['ticketName'] = ticketName;
    return map;
  }
}
