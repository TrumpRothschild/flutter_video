/// id : 87
/// name : "热点"
/// code : "RD"
/// iconUrl : "https://img.91momo50.vip/picture/2023/02/02/1788647536916761952.w.png?auth_key=1676445217788-482d5f0d9feb4342a4ea71df58dd47ca-0-8c9148b81dd817cb4bb746b8660857dc"
/// gameList : [{"id":536,"name":"金蟾捕鱼","code":"RD","categoryId":8009,"gameCode":"gold toad fishing_1051","iconUrl":"https://img.91momo50.vip/picture/2023/02/03/1788931957499770976.w.png?auth_key=1676445217788-0aa21f2857524896ba3159ee073fa7be-0-4d5c218427d294a5ad15f606fef80cca","gameType":null,"rowNum":2,"isThird":false},{"id":537,"name":"百人牛牛","code":"RD","categoryId":8009,"gameCode":"Multi-Players Niu Niu_1020","iconUrl":"https://img.91momo50.vip/picture/2023/02/03/1788932084598286464.w.png?auth_key=1676445217788-f32cbfc8f58e43128c854d287b5b7c84-0-6900137efdb94711ff8a9ba252fe5492","gameType":null,"rowNum":2,"isThird":false}]

class GameBean {
  GameBean({
    this.id,
    this.name,
    this.code,
    this.iconUrl,
    this.gameList,
  });

  GameBean.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    iconUrl = json['iconUrl'];
    if (json['gameList'] != null) {
      gameList = [];
      json['gameList'].forEach((v) {
        gameList?.add(GameList.fromJson(v));
      });
    }
  }

  int? id;
  String? name;
  String? code;
  String? iconUrl;
  List<GameList>? gameList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['code'] = code;
    map['iconUrl'] = iconUrl;
    if (gameList != null) {
      map['gameList'] = gameList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 536
/// name : "金蟾捕鱼"
/// code : "RD"
/// categoryId : 8009
/// gameCode : "gold toad fishing_1051"
/// iconUrl : "https://img.91momo50.vip/picture/2023/02/03/1788931957499770976.w.png?auth_key=1676445217788-0aa21f2857524896ba3159ee073fa7be-0-4d5c218427d294a5ad15f606fef80cca"
/// gameType : null
/// rowNum : 2
/// isThird : false

class GameList {
  GameList({
    this.id,
    this.name,
    this.code,
    this.categoryId,
    this.gameCode,
    this.iconUrl,
    this.gameType,
    this.rowNum,
    this.isThird,
  });

  GameList.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    categoryId = json['categoryId'];
    gameCode = json['gameCode'];
    iconUrl = json['iconUrl'];
    gameType = json['gameType'];
    rowNum = json['rowNum'];
    isThird = json['isThird'];
  }

  int? id;
  String? name;
  String? code;
  int? categoryId;
  String? gameCode;
  String? iconUrl;
  dynamic gameType;
  int? rowNum;
  bool? isThird;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['code'] = code;
    map['categoryId'] = categoryId;
    map['gameCode'] = gameCode;
    map['iconUrl'] = iconUrl;
    map['gameType'] = gameType;
    map['rowNum'] = rowNum;
    map['isThird'] = isThird;
    return map;
  }
}
