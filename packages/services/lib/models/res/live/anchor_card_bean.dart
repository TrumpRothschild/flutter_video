// To parse this JSON data, do
//
//     final anchorCardBean = anchorCardBeanFromJson(jsonString);

import 'dart:convert';

AnchorCardBean anchorCardBeanFromJson(String str) =>
    AnchorCardBean.fromJson(json.decode(str));

String anchorCardBeanToJson(AnchorCardBean data) => json.encode(data.toJson());

class AnchorCardBean {
  AnchorCardBean({
    this.cardContact = '',
    this.cardLimit = 0,
    this.currentAmount = 0,
  });

  final String cardContact;
  final int cardLimit;
  final int currentAmount;

  int get maxLimit => cardLimit > 0 ? cardLimit : 1;

  factory AnchorCardBean.fromJson(Map<String, dynamic>? json) => AnchorCardBean(
        cardContact: json?["cardContact"]?.toString() ?? '',
        cardLimit: json?["cardLimit"] as int? ?? 0,
        currentAmount: json?["currentAmount"] as int? ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "cardContact": cardContact,
        "cardLimit": cardLimit,
        "currentAmount": currentAmount,
      };
}
