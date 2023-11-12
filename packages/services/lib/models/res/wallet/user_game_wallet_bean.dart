// To parse this JSON data, do
//
//     final userGameWalletBean = userGameWalletBeanFromJson(jsonString);

import 'dart:convert';

UserGameWalletBean userGameWalletBeanFromJson(String str) =>
    UserGameWalletBean.fromJson(json.decode(str));

String userGameWalletBeanToJson(UserGameWalletBean data) =>
    json.encode(data.toJson());

class UserGameWalletBean {
  UserGameWalletBean({
    this.amount = 0,
    this.categoryId = -1,
    this.id = -1,
    this.name = '',
    this.platformCode = '',
  });

  final double amount;
  final int categoryId;
  final int id;
  final String name;
  final String platformCode;

  factory UserGameWalletBean.fromJson(Map<String, dynamic> json) =>
      UserGameWalletBean(
        amount: json["amount"] as double? ?? 0.0,
        categoryId: json["categoryId"] as int? ?? -1,
        id: json["id"] as int? ?? -1,
        name: json["name"]?.toString() ?? '',
        platformCode: json["platformCode"]?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "categoryId": categoryId,
        "id": id,
        "name": name,
        "platformCode": platformCode,
      };
}
