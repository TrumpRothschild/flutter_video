import 'dart:convert';

import 'package:base/assets.gen.dart';
import 'package:base/commons/utils/app_date_utils.dart';

MineMsgBean mineMsgBeanFromJson(String str) =>
    MineMsgBean.fromJson(json.decode(str));

String mineMsgBeanToJson(MineMsgBean data) => json.encode(data.toJson());

class MineMsgBean {
  MineMsgBean({
    this.content = '',
    this.createTime,
    this.id = 0,
    this.isRead = false,
    this.msgType = -1,
    this.title = '',
  });

  final String content;
  final DateTime? createTime;
  final int id;
  bool isRead;

  /// 消息类型 1系统消息 2邮件
  final int msgType;
  final String title;

  String get createTimeStr {
    if (createTime == null) return '';
    return AppDateUtils.apiDayFormat3(createTime!.toLocal());
  }

  String get typeIcon {
    switch (msgType) {
      case 1:
        return Assets.minePage.sysMessges.path;
      case 2:
        return Assets.minePage.sysEmial.path;
      default:
        return Assets.minePage.sysMsg.path;
    }
  }

  String get typeTitle {
    switch (msgType) {
      case 1:
        return '系统消息';
      case 2:
        return '邮件';
      default:
        return '未知类型';
    }
  }

  factory MineMsgBean.fromJson(Map<String, dynamic> json) => MineMsgBean(
      content: json["content"]?.toString() ?? '',
      createTime: json["createTime"] == null
          ? null
          : DateTime.parse(json["createTime"]?.toString() ?? ''),
      id: json["id"] as int? ?? -1,
      isRead: json["isRead"] as bool? ?? false,
      msgType: json["msgType"] as int? ?? -1,
      title: json["title"]?.toString() ?? '');

  Map<String, dynamic> toJson() => {
        "content": content,
        "createTime": createTime?.toIso8601String(),
        "id": id,
        "isRead": isRead,
        "msgType": msgType,
        "title": title,
      };
}
