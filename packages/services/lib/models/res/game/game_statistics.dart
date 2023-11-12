/// sbAmount : 0
/// tzAmount : 0
/// tzCount : 0
/// zjAmount : 0
/// zjCount : 0

class GameStatistics {
  GameStatistics({
    this.sbAmount,
    this.tzAmount,
    this.tzCount,
    this.zjAmount,
    this.zjCount,
  });

  GameStatistics.fromJson(dynamic json) {
    sbAmount = json['sbAmount'];
    tzAmount = json['tzAmount'];
    tzCount = json['tzCount'];
    zjAmount = json['zjAmount'];
    zjCount = json['zjCount'];
  }

  num? sbAmount;
  num? tzAmount;
  num? tzCount;
  num? zjAmount;
  num? zjCount;

  GameStatistics copyWith({
    num? sbAmount,
    num? tzAmount,
    num? tzCount,
    num? zjAmount,
    num? zjCount,
  }) =>
      GameStatistics(
        sbAmount: sbAmount ?? this.sbAmount,
        tzAmount: tzAmount ?? this.tzAmount,
        tzCount: tzCount ?? this.tzCount,
        zjAmount: zjAmount ?? this.zjAmount,
        zjCount: zjCount ?? this.zjCount,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sbAmount'] = sbAmount;
    map['tzAmount'] = tzAmount;
    map['tzCount'] = tzCount;
    map['zjAmount'] = zjAmount;
    map['zjCount'] = zjCount;
    return map;
  }
}
