// To parse this JSON data, do
//
//     final contributionUserBean = contributionUserBeanFromJson(jsonString);

import 'dart:convert';

ContributionUserBean contributionUserBeanFromJson(String str) =>
    ContributionUserBean.fromJson(json.decode(str));

String contributionUserBeanToJson(ContributionUserBean data) =>
    json.encode(data.toJson());

class ContributionUserBean {
  ContributionUserBean({
    this.avatar = '',
    this.fireDifference = 0,
    this.fireNum = 0,
    this.userId = 0,
    this.userLevel = 0,
    this.userName = '',
  });

  final String avatar;
  final int fireDifference;
  final int fireNum;
  final int userId;
  final int userLevel;
  final String userName;

  factory ContributionUserBean.fromJson(Map<String, dynamic> json) =>
      ContributionUserBean(
        avatar: json["avatar"],
        fireDifference: json["fireDifference"],
        fireNum: json["fireNum"],
        userId: json["userId"],
        userLevel: json["userLevel"],
        userName: json["userName"],
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "fireDifference": fireDifference,
        "fireNum": fireNum,
        "userId": userId,
        "userLevel": userLevel,
        "userName": userName,
      };
}
