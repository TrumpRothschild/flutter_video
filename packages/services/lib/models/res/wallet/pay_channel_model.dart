///充值中心
class PayChannelModel {
  String? minAmt;
  String? maxAmt;
  String? payWayId;
  String? shortcut;
  String? channelCode;
  String? channelName;
  bool? isInput;
  String? currencyUnit;
  String? tips;
  String? shortcutOptionsUnit;
  String? czExChange;

  List<String> moneys() {
    return shortcut?.split(",").toList() ?? [];
  }

  int moneysLength() {
    return (shortcut?.split(",").toList() ?? []).length;
  }

  PayChannelModel(
      {minAmt,
      maxAmt,
      payWayId,
      shortcut,
      channelCode,
      channelName,
      isInput,
      currencyUnit,
      tips,
      shortcutOptionsUnit,
      czExChange});

  PayChannelModel.fromJson(Map<String, dynamic> json) {
    minAmt = json['minAmt'].toString();
    maxAmt = json['maxAmt'].toString();
    payWayId = json['payWayId'].toString();
    shortcut = json['shortcut'].toString();
    channelCode = json['channelCode'].toString();
    channelName = json['channelName'].toString();
    isInput = json['isInput'];
    currencyUnit = json['currencyUnit'].toString();
    tips = json['tips'].toString();
    shortcutOptionsUnit = json['shortcutOptionsUnit'].toString();
    czExChange = json['czExChange'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['minAmt'] = minAmt;
    data['maxAmt'] = maxAmt;
    data['payWayId'] = payWayId;
    data['shortcut'] = shortcut;
    data['channelCode'] = channelCode;
    data['channelName'] = channelName;
    data['isInput'] = isInput;
    data['currencyUnit'] = currencyUnit;
    data['tips'] = tips;
    data['shortcutOptionsUnit'] = shortcutOptionsUnit;
    data['czExChange'] = czExChange;
    return data;
  }
}
