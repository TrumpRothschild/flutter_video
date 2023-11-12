/// amount : 123.45
/// kjNo : "12345"
/// leftSeconds : "60"
/// nickName : "John Doe"
/// studioNum : "001"
/// ticketId : 123
/// ticketName : "Lottery"
/// ticketNameEn : "Lottery"
/// tomList : [{"amount":23.45,"bid":456,"bname":"Single","bnameEn":"Single","odds":2.0,"oddsName":"2:1","oddsNameEn":"2:1","oid":[123,456],"pbid":789,"times":1},{"amount":100.0,"bid":789,"bname":"Double","bnameEn":"Double","odds":1.5,"oddsName":"3:2","oddsNameEn":"3:2","oid":[987,654],"pbid":321,"times":2}]
/// type : 1
/// userId : 123456
/// followId : "ABC123"

class FollowBetInfoModel {
  FollowBetInfoModel({
    this.amount,
    this.kjNo,
    this.leftSeconds,
    this.nickName,
    this.studioNum,
    this.ticketId,
    this.ticketName,
    this.ticketNameEn,
    this.tomList,
    this.type,
    this.userId,
    this.followId,
  });

  FollowBetInfoModel.fromJson(dynamic json) {
    amount = json['amount'];
    kjNo = json['kjNo'];
    leftSeconds = json['leftSeconds'];
    nickName = json['nickName'];
    studioNum = json['studioNum'];
    ticketId = json['ticketId'];
    ticketName = json['ticketName'];
    ticketNameEn = json['ticketNameEn'];
    if (json['tomList'] != null) {
      tomList = [];
      json['tomList'].forEach((v) {
        tomList?.add(TomList.fromJson(v));
      });
    }
    type = json['type'];
    userId = json['userId'];
    followId = json['followId'];
  }

  num? amount;
  dynamic? kjNo;
  dynamic? leftSeconds;
  String? nickName;
  String? studioNum;
  num? ticketId;
  String? ticketName;
  String? ticketNameEn;
  List<TomList>? tomList;
  num? type;
  num? userId;
  String? followId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = amount;
    map['kjNo'] = kjNo;
    map['leftSeconds'] = leftSeconds;
    map['nickName'] = nickName;
    map['studioNum'] = studioNum;
    map['ticketId'] = ticketId;
    map['ticketName'] = ticketName;
    map['ticketNameEn'] = ticketNameEn;
    if (tomList != null) {
      map['tomList'] = tomList?.map((v) => v.toJson()).toList();
    }
    map['type'] = type;
    map['userId'] = userId;
    map['followId'] = followId;
    return map;
  }
}

/// amount : 23.45
/// bid : 456
/// bname : "Single"
/// bnameEn : "Single"
/// odds : 2.0
/// oddsName : "2:1"
/// oddsNameEn : "2:1"
/// oid : [123,456]
/// pbid : 789
/// times : 1

class TomList {
  TomList({
    this.amount,
    this.bid,
    this.bname,
    this.bnameEn,
    this.odds,
    this.oddsName,
    this.oddsNameEn,
    this.oid,
    this.pbid,
    this.times,
  });

  TomList.fromJson(dynamic json) {
    amount = json['amount'];
    bid = json['bid'];
    bname = json['bname'];
    bnameEn = json['bnameEn'];
    odds = json['odds'];
    oddsName = json['oddsName'];
    oddsNameEn = json['oddsNameEn'];
    oid = json['oid'] != null ? json['oid'].cast<num>() : [];
    pbid = json['pbid'];
    times = json['times'];
  }

  num? amount;
  num? bid;
  String? bname;
  String? bnameEn;
  num? odds;
  String? oddsName;
  String? oddsNameEn;
  List<num>? oid;
  num? pbid;
  num? times;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = amount;
    map['bid'] = bid;
    map['bname'] = bname;
    map['bnameEn'] = bnameEn;
    map['odds'] = odds;
    map['oddsName'] = oddsName;
    map['oddsNameEn'] = oddsNameEn;
    map['oid'] = oid;
    map['pbid'] = pbid;
    map['times'] = times;
    return map;
  }
}
