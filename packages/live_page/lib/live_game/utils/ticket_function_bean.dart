class TicketFunctionBean {
  String? statusName;
  String? statusNameResourceId;
  List<String>? results;
  List<String>? resourceIds;
  List<String>? resourceIds2;
  List<int>? pointData;
  List<int>? highlightPosition;
  int? winType;
  int? bjlPoint;
  int? sum;
  int? single;
  int? size;
  List<Object?>? objectList;

  TicketFunctionBean({
    this.statusName,
    this.statusNameResourceId,
    this.results,
    this.resourceIds,
    this.resourceIds2,
    this.pointData,
    this.highlightPosition,
    this.winType,
    this.bjlPoint,
    this.sum,
    this.single,
    this.size,
    this.objectList,
  });

  factory TicketFunctionBean.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return TicketFunctionBean();
    }
    return TicketFunctionBean()
      ..statusName = json['statusName'] as String?
      ..statusNameResourceId = json['statusNameResourceId'] as String?
      ..results =
          (json['results'] as List<dynamic>?)?.map((e) => e as String).toList()
      ..resourceIds = (json['resourceIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..resourceIds2 = (json['resourceIds2'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..pointData =
          (json['pointData'] as List<dynamic>?)?.map((e) => e as int).toList()
      ..highlightPosition = (json['highlightPosition'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList()
      ..winType = json['winType'] as int? ?? 0
      ..bjlPoint = json['bjlPoint'] as int? ?? 0
      ..sum = json['sum'] as int? ?? 0
      ..single = json['single'] as int? ?? 0
      ..size = json['size'] as int? ?? 0
      ..objectList = (json['objectList'] as List<dynamic>?);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusName'] = statusName;
    data['statusNameResourceId'] = statusNameResourceId;
    data['results'] = results;
    data['resourceIds'] = resourceIds;
    data['resourceIds2'] = resourceIds2;
    data['pointData'] = pointData;
    data['highlightPosition'] = highlightPosition;
    data['winType'] = winType;
    data['bjlPoint'] = bjlPoint;
    data['sum'] = sum;
    data['single'] = single;
    data['size'] = size;
    data['objectList'] = objectList;
    return data;
  }
}
