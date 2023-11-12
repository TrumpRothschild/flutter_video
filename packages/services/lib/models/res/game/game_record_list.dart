/// list : [{"betAmount":0,"betCount":0,"gameId":"","gameName":"","gameType":"","iconUrl":"","netAt":0,"platformCode":"","winAmount":0}]
/// totalBetAmount : 0
/// totalWinAmount : 0

class GameRecordListModel {
  GameRecordListModel({
    this.list,
    this.totalBetAmount,
    this.totalWinAmount,
  });

  GameRecordListModel.fromJson(dynamic json) {
    if (json['list'] != null) {
      list = [];

      var _list = json['list'] as List<dynamic>;
      if (_list.isEmpty) {
        list = [];

      }
      else {
        json['list'].forEach((v) {
          list?.add(RecordItem.fromJson(v));
        });
      }
    }
    totalBetAmount = json['totalBetAmount'];
    totalWinAmount = json['totalWinAmount'];

    // if ( json['totalBetAmount'] is int) {
    //   totalBetAmount = double.parse(json['totalBetAmount'].toString());
    // }
    // else {
    //   totalBetAmount = json['totalBetAmount'];
    // }
    //
    // if ( json['totalWinAmount'] is int) {
    //   totalWinAmount = double.parse(json['totalWinAmount'].toString());
    // }
    // else {
    //   totalWinAmount = json['totalWinAmount'];
    // }
  }

  List<RecordItem>? list;
  num? totalBetAmount;
  num? totalWinAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (list != null) {
      map['list'] = list?.map((v) => v.toJson()).toList();
    }
    map['totalBetAmount'] = totalBetAmount;
    map['totalWinAmount'] = totalWinAmount;
    return map;
  }
}

/// betAmount : 0
/// betCount : 0
/// gameId : ""
/// gameName : ""
/// gameType : ""
/// iconUrl : ""
/// netAt : 0
/// platformCode : ""
/// winAmount : 0

class RecordItem {
  RecordItem({
    this.betAmount,
    this.betCount,
    this.gameId,
    this.gameName,
    this.gameType,
    this.iconUrl,
    this.netAt,
    this.platformCode,
    this.winAmount,
  });

  RecordItem.fromJson(dynamic json) {
    betAmount = json['betAmount'];
    betCount = json['betCount'];
    gameId = json['gameId'];
    gameName = json['gameName'];
    gameType = json['gameType'];
    iconUrl = json['iconUrl'];
    netAt = json['netAt'];
    platformCode = json['platformCode'];
    winAmount = json['winAmount'];
  }

  num? betAmount;
  num? betCount;
  String? gameId;
  String? gameName;
  String? gameType;
  String? iconUrl;
  num? netAt;
  String? platformCode;
  num? winAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['betAmount'] = betAmount;
    map['betCount'] = betCount;
    map['gameId'] = gameId;
    map['gameName'] = gameName;
    map['gameType'] = gameType;
    map['iconUrl'] = iconUrl;
    map['netAt'] = netAt;
    map['platformCode'] = platformCode;
    map['winAmount'] = winAmount;
    return map;
  }
}
