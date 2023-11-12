// To parse this JSON data, do
//
//     final userLevelBean = userLevelBeanFromJson(jsonString);

import 'dart:convert';

UserLevelBean userLevelBeanFromJson(String str) =>
    UserLevelBean.fromJson(json.decode(str));

String userLevelBeanToJson(UserLevelBean data) => json.encode(data.toJson());

class UserLevelBean {
  UserLevelBean({
    this.currentExp = 0,
    this.levelIcon = '',
    this.levelName = '',
    this.levelWeight = -1,
    this.needExp = 0.0,
    this.progress = 0.0,
  });

  bool get isFullLevel => currentExp == needExp;

  // 已有的经验值
  final num currentExp;
  // 等级图标
  final String levelIcon;
  // 等级名称
  final String levelName;
  // 当前等级
  final num levelWeight;
  // 距离升级需要的经验值
  final num needExp;
  // 进度
  final num progress;

  factory UserLevelBean.fromJson(Map<String, dynamic> json) => UserLevelBean(
        currentExp: json["currentExp"] as num? ?? 0,
        levelIcon: json["levelIcon"]?.toString() ?? '',
        levelName: json["levelName"]?.toString() ?? '',
        levelWeight: json["levelWeight"] as num? ?? -1,
        needExp: json["needExp"] as num? ?? 0.0,
        progress: json["progress"] as num? ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "currentExp": currentExp,
        "levelIcon": levelIcon,
        "levelName": levelName,
        "levelWeight": levelWeight,
        "needExp": needExp,
        "progress": progress,
      };
}
