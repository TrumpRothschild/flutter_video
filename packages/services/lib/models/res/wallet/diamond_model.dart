///兑换钻石/兑换金币
class DiamondModel {
  int? platformGoldNum;
  String? optionsUnit;
  String? option;
  int? silverBeanOptionsId;
  String? platformGoldUint;
  String? exChange;

  DiamondModel(
      {platformGoldNum,
      optionsUnit,
      option,
      silverBeanOptionsId,
      platformGoldUint,
      exChange});

  DiamondModel.fromJson(Map<String, dynamic> json) {
    platformGoldNum = json['platformGoldNum'];
    optionsUnit = json['optionsUnit'];
    option = json['option'];
    silverBeanOptionsId = json['silverBeanOptionsId'];
    platformGoldUint = json['platformGoldUint'];
    exChange = json['exChange'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['platformGoldNum'] = platformGoldNum;
    data['optionsUnit'] = optionsUnit;
    data['option'] = option;
    data['silverBeanOptionsId'] = silverBeanOptionsId;
    data['platformGoldUint'] = platformGoldUint;
    data['exChange'] = exChange;
    return data;
  }
}
