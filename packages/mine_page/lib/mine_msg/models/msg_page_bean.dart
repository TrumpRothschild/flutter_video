// To parse this JSON data, do
//
//     final msgPageBean = msgPageBeanFromJson(jsonString);

import 'dart:convert';

import 'package:mine_page/mine_msg/models/mine_msg_bean.dart';

MsgPageBean msgPageBeanFromJson(String str) =>
    MsgPageBean.fromJson(json.decode(str));

String msgPageBeanToJson(MsgPageBean data) => json.encode(data.toJson());

class MsgPageBean {
  MsgPageBean({
    this.total = 0,
    this.list = const [],
    this.pageNum = 0,
    this.pageSize = 0,
    this.size = 0,
    this.startRow = 0,
    this.endRow = 0,
    this.pages = 0,
    this.prePage = 0,
    this.nextPage = 0,
    this.isFirstPage = false,
    this.isLastPage = false,
    this.hasPreviousPage = false,
    this.hasNextPage = false,
    this.navigatePages = 0,
    this.navigatepageNums = const [],
    this.navigateFirstPage = 0,
    this.navigateLastPage = 0,
  });

  final int total;
  final List<MineMsgBean> list;
  final int pageNum;
  final int pageSize;
  final int size;
  final int startRow;
  final int endRow;
  final int pages;
  final int prePage;
  final int nextPage;
  final bool isFirstPage;
  final bool isLastPage;
  final bool hasPreviousPage;
  final bool hasNextPage;
  final int navigatePages;
  final List<int> navigatepageNums;
  final int navigateFirstPage;
  final int navigateLastPage;

  factory MsgPageBean.fromJson(Map<String, dynamic> json) => MsgPageBean(
        total: json["total"],
        list: json["list"] == null
            ? []
            : List<MineMsgBean>.from(
                json["list"].map((x) => MineMsgBean.fromJson(x))),
        pageNum: json["pageNum"],
        pageSize: json["pageSize"],
        size: json["size"],
        startRow: json["startRow"],
        endRow: json["endRow"],
        pages: json["pages"],
        prePage: json["prePage"],
        nextPage: json["nextPage"],
        isFirstPage: json["isFirstPage"],
        isLastPage: json["isLastPage"],
        hasPreviousPage: json["hasPreviousPage"],
        hasNextPage: json["hasNextPage"],
        navigatePages: json["navigatePages"],
        navigatepageNums: json["navigatepageNums"] == null
            ? []
            : List<int>.from(json["navigatepageNums"].map((x) => x)),
        navigateFirstPage: json["navigateFirstPage"],
        navigateLastPage: json["navigateLastPage"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "pageNum": pageNum,
        "pageSize": pageSize,
        "size": size,
        "startRow ": startRow,
        "endRow ": endRow,
        "pages ": pages,
        "prePage ": prePage,
        "nextPage ": nextPage,
        "isFirstPage ": isFirstPage,
        "isLastPage ": isLastPage,
        "hasPreviousPage ": hasPreviousPage,
        "hasNextPage ": hasNextPage,
        "navigatePages ": navigatePages,
        "navigatepageNums ": List<dynamic>.from(navigatepageNums.map((x) => x)),
        "navigateFirstPage ": navigateFirstPage,
        "navigateLastPage ": navigateLastPage,
      };
}
