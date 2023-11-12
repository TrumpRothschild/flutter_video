/// balance : 0
/// followId : ""
/// result : true

class NiuBetResultModel {
  NiuBetResultModel({
    this.balance,
    this.followId,
    this.result,
  });

  NiuBetResultModel.fromJson(dynamic json) {
    balance = json['balance'];
    followId = json['followId'];
    result = json['result'];
  }

  num? balance;
  String? followId;
  bool? result;

  NiuBetResultModel copyWith({
    num? balance,
    String? followId,
    bool? result,
  }) =>
      NiuBetResultModel(
        balance: balance ?? this.balance,
        followId: followId ?? this.followId,
        result: result ?? this.result,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['balance'] = balance;
    map['followId'] = followId;
    map['result'] = result;
    return map;
  }
}
