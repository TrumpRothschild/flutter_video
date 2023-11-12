/// id : 156
/// bet : "胜负"
/// isZs : 0
/// bets : null
/// odds : [{"id":1196,"oddsName":"蓝方胜","oddsImage":null,"odds":1.96,"price":2,"betGroup":1},{"id":1197,"oddsName":"红方胜","oddsImage":null,"odds":1.96,"price":2,"betGroup":1}]

class NiuNiuDetailModel {
  NiuNiuDetailModel({
    this.id,
    this.bet,
    this.isZs,
    this.bets,
    this.odds,
  });

  NiuNiuDetailModel.fromJson(dynamic json) {
    id = json['id'];
    bet = json['bet'];
    isZs = json['isZs'];
    bets = json['bets'];
    if (json['odds'] != null) {
      odds = [];
      json['odds'].forEach((v) {
        odds?.add(
          Odds.fromJson(v)
            ..parentId = id
            ..parentName = bet,
        );
      });
    }
  }

  num? id;
  String? bet;
  num? isZs;
  dynamic bets;
  List<Odds>? odds;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['bet'] = bet;
    map['isZs'] = isZs;
    map['bets'] = bets;
    if (odds != null) {
      map['odds'] = odds?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1196
/// oddsName : "蓝方胜"
/// oddsImage : null
/// odds : 1.96
/// price : 2
/// betGroup : 1

class Odds {
  Odds({
    this.id,
    this.oddsName,
    this.oddsImage,
    this.odds,
    this.price,
    this.betGroup,
  });

  Odds.fromJson(dynamic json) {
    id = json['id'];
    oddsName = json['oddsName'];
    oddsImage = json['oddsImage'];
    odds = json['odds'];
    price = json['price'];
    betGroup = json['betGroup'];
  }

  num? parentId;
  String? parentName;
  num? id;
  String? oddsName;
  dynamic oddsImage;
  num? odds;
  num? price;
  num? betGroup;

  Odds copyWith({
    num? id,
    String? oddsName,
    dynamic oddsImage,
    num? odds,
    num? price,
    num? betGroup,
  }) =>
      Odds(
        id: id ?? this.id,
        oddsName: oddsName ?? this.oddsName,
        oddsImage: oddsImage ?? this.oddsImage,
        odds: odds ?? this.odds,
        price: price ?? this.price,
        betGroup: betGroup ?? this.betGroup,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['oddsName'] = oddsName;
    map['oddsImage'] = oddsImage;
    map['odds'] = odds;
    map['price'] = price;
    map['betGroup'] = betGroup;
    return map;
  }
}
