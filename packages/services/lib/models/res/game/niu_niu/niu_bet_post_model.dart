/// studioNum : ""
/// ticketBetOddsReqList : [{"amount":5,"bid":1196,"oid":[0],"pbid":156,"times":1},{"amount":5,"bid":1197,"oid":[2],"pbid":156,"times":1}]
/// ticketId : 1

class NiuPostBetModel {
  NiuPostBetModel({
    this.studioNum,
    this.ticketBetOddsReqList,
    this.ticketId,
  });

  NiuPostBetModel.fromJson(dynamic json) {
    studioNum = json['studioNum'];
    if (json['ticketBetOddsReqList'] != null) {
      ticketBetOddsReqList = [];
      json['ticketBetOddsReqList'].forEach((v) {
        ticketBetOddsReqList?.add(TicketBetOddsReqList.fromJson(v));
      });
    }
    ticketId = json['ticketId'];
  }

  String? studioNum;
  List<TicketBetOddsReqList>? ticketBetOddsReqList;
  num? ticketId;

  NiuPostBetModel copyWith({
    String? studioNum,
    List<TicketBetOddsReqList>? ticketBetOddsReqList,
    num? ticketId,
  }) =>
      NiuPostBetModel(
        studioNum: studioNum ?? this.studioNum,
        ticketBetOddsReqList: ticketBetOddsReqList ?? this.ticketBetOddsReqList,
        ticketId: ticketId ?? this.ticketId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['studioNum'] = studioNum;
    if (ticketBetOddsReqList != null) {
      map['ticketBetOddsReqList'] =
          ticketBetOddsReqList?.map((v) => v.toJson()).toList();
    }
    map['ticketId'] = ticketId;
    return map;
  }
}

/// amount : 5
/// bid : 1196
/// oid : [0]
/// pbid : 156
/// times : 1

class TicketBetOddsReqList {
  TicketBetOddsReqList({
    this.amount,
    this.bid,
    this.oid,
    this.pbid,
    this.times,
  });

  TicketBetOddsReqList.fromJson(dynamic json) {
    amount = json['amount'];
    bid = json['bid'];
    oid = json['oid'] != null ? json['oid'].cast<num>() : [];
    pbid = json['pbid'];
    times = json['times'];
  }

  num? amount;
  num? bid;
  List<num>? oid;
  num? pbid;
  num? times;

  TicketBetOddsReqList copyWith({
    num? amount,
    num? bid,
    List<num>? oid,
    num? pbid,
    num? times,
  }) =>
      TicketBetOddsReqList(
        amount: amount ?? this.amount,
        bid: bid ?? this.bid,
        oid: oid ?? this.oid,
        pbid: pbid ?? this.pbid,
        times: times ?? this.times,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = amount;
    map['bid'] = bid;
    map['oid'] = oid;
    map['pbid'] = pbid;
    map['times'] = times;
    return map;
  }
}
