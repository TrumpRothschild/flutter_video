// To parse this JSON data, do
//
//     final rankingUserBean = rankingUserBeanFromJson(jsonString);

import 'dart:convert';

RankingUserBean rankingUserBeanFromJson(String str) =>
    RankingUserBean.fromJson(json.decode(str));

String rankingUserBeanToJson(RankingUserBean data) =>
    json.encode(data.toJson());

class RankingUserBean {
  RankingUserBean({
    this.avatar = '',
    this.distance = 0,
    this.fansCount = 0,
    this.firepower = 0,
    this.isFocus = false,
    this.nickName = '',
    this.position = 0,
    this.sex = 0,
    this.studioNum = '',
    this.studioStatus = -1,
    this.studioThumbImage = '',
    this.userId = 0,
    this.userLevel = 0,
    this.userType = 0,
  });

  final String avatar;

  /// 跟前一名的差距
  final int distance;
  final int fansCount;

  /// 用户打赏的金币 * 10 火力值（或主播收到的打赏金币数量* 10 火力值）
  final int firepower;
  bool isFocus;
  final String nickName;

  /// 排名
  final int position;
  final int sex;
  final String studioNum;
  final int studioStatus;
  final String studioThumbImage;
  final int userId;
  final int userLevel;

  /// 用户类型：0-普通用户 、1-游客用户、2-主播、3-家族长
  final int userType;

  factory RankingUserBean.fromJson(Map<String, dynamic> json) =>
      RankingUserBean(
        avatar: json["avatar"],
        distance: json["distance"],
        fansCount: json["fansCount"],
        firepower: json["firepower"],
        isFocus: json["isFocus"],
        nickName: json["nickName"],
        position: json["position"],
        sex: json["sex"],
        studioNum: json["studioNum"],
        studioStatus: json["studioStatus"],
        studioThumbImage: json["studioThumbImage"],
        userId: json["userId"],
        userLevel: json["userLevel"],
        userType: json["userType"],
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "distance": distance,
        "fansCount": fansCount,
        "firepower": firepower,
        "isFocus": isFocus,
        "nickName": nickName,
        "position": position,
        "sex": sex,
        "studioNum": studioNum,
        "studioStatus": studioStatus,
        "studioThumbImage": studioThumbImage,
        "userId": userId,
        "userLevel": userLevel,
        "userType": userType,
      };
}
