/// categoryId : 0
/// gameCode : ""
/// iconUrl : ""
/// isThird : true
/// name : ""
/// rowNum : 0

class LiveGameModel {
  LiveGameModel({
    this.categoryId,
    this.gameCode,
    this.iconUrl,
    this.isThird,
    this.name,
    this.rowNum,
  });

  LiveGameModel.fromJson(dynamic json) {
    categoryId = json['categoryId'];
    gameCode = json['gameCode'];
    iconUrl = json['iconUrl'];
    isThird = json['isThird'];
    name = json['name'];
    rowNum = json['rowNum'];
  }

  int? categoryId;
  String? gameCode;
  String? iconUrl;
  bool? isThird;
  String? name;
  num? rowNum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryId'] = categoryId;
    map['gameCode'] = gameCode;
    map['iconUrl'] = iconUrl;
    map['isThird'] = isThird;
    map['name'] = name;
    map['rowNum'] = rowNum;
    return map;
  }
}
