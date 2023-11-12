import 'pay_channel_model.dart';

///充值中心
class PayWayModel {
  String? iconUrl;
  String? payTypeName;
  List<PayChannelModel>? payChannelVOList;

  PayWayModel({iconUrl, payTypeName, payChannelVOList});

  PayWayModel.fromJson(Map<String, dynamic> json) {
    iconUrl = json['iconUrl'];
    payTypeName = json['payTypeName'];
    List<dynamic> data = json['payChannelVOList'];
    payChannelVOList = data.map((m) => PayChannelModel.fromJson(m)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['iconUrl'] = iconUrl;
    data['payTypeName'] = payTypeName;
    data['payChannelVOList'] = payChannelVOList.toString();
    return data;
  }
}
