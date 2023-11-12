// To parse this JSON data, do
//
//     final appVersionBean = appVersionBeanFromJson(jsonString);

import 'dart:convert';

AppVersionBean appVersionBeanFromJson(String str) =>
    AppVersionBean.fromJson(json.decode(str));

String appVersionBeanToJson(AppVersionBean data) => json.encode(data.toJson());

class AppVersionBean {
  AppVersionBean({
    this.appType = "0",
    this.backUrl = '',
    this.code = '',
    this.content = '',
    this.downUrl = '',
    this.fileSize = "0",
    this.id = "0",
    this.isForced = "-1",
    this.isSilentDownload = false,
    this.name = '',
    this.proName = '',
    this.relativeDownUrl = '',
    this.showVersion = '',
    this.updateTime,
    this.upgradeVersion = "1",
  });

  // app类型 1客户端, 2主播端
  final String appType;
  final String backUrl;
  // app客户端编码 ios/android
  final String code;
  // 	更新内容
  final String content;
  final String downUrl;
  final String fileSize;
  final String id;
  // 强制更新 0不强制 1强制
  final String isForced;
  final bool? isSilentDownload;
  final String name;
  final String proName;
  final String relativeDownUrl;
  final String showVersion;
  final String? updateTime;
  final String upgradeVersion;

  factory AppVersionBean.fromJson(Map<String, dynamic> json) => AppVersionBean(
        appType: json["appType"]?.toString() ?? '',
        backUrl: json["backUrl"]?.toString() ?? '',
        code: json["code"]?.toString() ?? '',
        content: json["content"]?.toString() ?? '',
        downUrl: json["downUrl"]?.toString() ?? '',
        fileSize: json["fileSize"] ?.toString() ?? '',
        id: json["id"] ?.toString() ?? '',
        isForced: json["isForced"] ?.toString() ?? '',
        isSilentDownload: json["isSilentDownload"],
        name: json["name"]?.toString() ?? '',
        proName: json["proName"]?.toString() ?? '',
        relativeDownUrl: json["relativeDownUrl"]?.toString() ?? '',
        showVersion: json["showVersion"]?.toString() ?? '',
        updateTime: json["updateTime"]?.toString() ?? '',
        upgradeVersion: json["upgradeVersion"] ?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        "appType": appType,
        "backUrl": backUrl,
        "code": code,
        "content": content,
        "downUrl": downUrl,
        "fileSize": fileSize,
        "id": id,
        "isForced": isForced,
        "isSilentDownload": isSilentDownload,
        "name": name,
        "proName": proName,
        "relativeDownUrl": relativeDownUrl,
        "showVersion": showVersion,
        "updateTime": updateTime,
        "upgradeVersion": upgradeVersion,
      };
}
