/// activityName : ""
/// activityType : 0
/// configType : 0
/// endDate : ""
/// id : 0
/// imgUrl : ""
/// link : ""
/// permanent : true
/// startDate : ""
///直播间活动bean
class LiveActionBean {
  LiveActionBean({
      String? activityName, 
      num? activityType, 
      num? configType, 
      String? endDate, 
      num? id, 
      String? imgUrl, 
      String? link, 
      bool? permanent, 
      String? startDate,}){
    _activityName = activityName;
    _activityType = activityType;
    _configType = configType;
    _endDate = endDate;
    _id = id;
    _imgUrl = imgUrl;
    _link = link;
    _permanent = permanent;
    _startDate = startDate;
}

  LiveActionBean.fromJson(dynamic json) {
    _activityName = json['activityName'];
    _activityType = json['activityType'];
    _configType = json['configType'];
    _endDate = json['endDate'];
    _id = json['id'];
    _imgUrl = json['imgUrl'];
    _link = json['link'];
    _permanent = json['permanent'];
    _startDate = json['startDate'];
  }
  String? _activityName;
  num? _activityType;
  num? _configType;
  String? _endDate;
  num? _id;
  String? _imgUrl;
  String? _link;
  bool? _permanent;
  String? _startDate;
LiveActionBean copyWith({  String? activityName,
  num? activityType,
  num? configType,
  String? endDate,
  num? id,
  String? imgUrl,
  String? link,
  bool? permanent,
  String? startDate,
}) => LiveActionBean(  activityName: activityName ?? _activityName,
  activityType: activityType ?? _activityType,
  configType: configType ?? _configType,
  endDate: endDate ?? _endDate,
  id: id ?? _id,
  imgUrl: imgUrl ?? _imgUrl,
  link: link ?? _link,
  permanent: permanent ?? _permanent,
  startDate: startDate ?? _startDate,
);
  String? get activityName => _activityName;
  num? get activityType => _activityType;
  num? get configType => _configType;
  String? get endDate => _endDate;
  num? get id => _id;
  String? get imgUrl => _imgUrl;
  String? get link => _link;
  bool? get permanent => _permanent;
  String? get startDate => _startDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['activityName'] = _activityName;
    map['activityType'] = _activityType;
    map['configType'] = _configType;
    map['endDate'] = _endDate;
    map['id'] = _id;
    map['imgUrl'] = _imgUrl;
    map['link'] = _link;
    map['permanent'] = _permanent;
    map['startDate'] = _startDate;
    return map;
  }

}