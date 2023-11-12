import 'dart:convert';

PageModel pageModelFromJson(String str) => PageModel.fromJson(json.decode(str));

String pageModelToJson(PageModel data) => json.encode(data.toJson());

class PageModel<T> {
  PageModel({
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
  final List<T> list;
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

  factory PageModel.fromJson(Map<String, dynamic> json) => PageModel(
        total: json["total"],
        list: json["list"] ?? [],
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
        "list": list,
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
