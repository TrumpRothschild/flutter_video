/// id : 6
/// activityName : ""
/// activityType : 6
/// status : true
/// skipUrl : ""
/// distributionMethod : 1
/// jumpPage : 2
/// jumpappType : 1
/// studioNum : null
/// gameType : null
/// config : [{"recharge":50,"given":388},{"recharge":100,"given":798},{"recharge":200,"given":1668},{"recharge":500,"given":5000}]
/// langList : [{"id":81,"activityTitle":"","activityContent":"","lang":"zh_CN","imageUrl":""}]

class ActivityBean {
  ActivityBean({
      this.id, 
      this.activityName, 
      this.activityType, 
      this.status, 
      this.skipUrl, 
      this.distributionMethod, 
      this.jumpPage, 
      this.jumpappType, 
      this.studioNum, 
      this.gameType, 
      this.config, 
      this.langList,});

  ActivityBean.fromJson(dynamic json) {
    id = json['id'];
    activityName = json['activityName'];
    activityType = json['activityType'];
    status = json['status'];
    skipUrl = json['skipUrl'];
    distributionMethod = json['distributionMethod'];
    jumpPage = json['jumpPage'];
    jumpappType = json['jumpappType'];
    studioNum = json['studioNum'];
    gameType = json['gameType'];
    if (json['config'] != null) {
      config = [];
      json['config'].forEach((v) {
        config?.add(Config.fromJson(v));
      });
    }
    if (json['langList'] != null) {
      langList = [];
      json['langList'].forEach((v) {
        langList?.add(LangList.fromJson(v));
      });
    }
  }
  num? id;
  String? activityName;
  num? activityType;
  bool? status;
  String? skipUrl;
  num? distributionMethod;
  num? jumpPage;
  num? jumpappType;
  dynamic studioNum;
  dynamic gameType;
  List<Config>? config;
  List<LangList>? langList;
ActivityBean copyWith({  num? id,
  String? activityName,
  num? activityType,
  bool? status,
  String? skipUrl,
  num? distributionMethod,
  num? jumpPage,
  num? jumpappType,
  dynamic studioNum,
  dynamic gameType,
  List<Config>? config,
  List<LangList>? langList,
}) => ActivityBean(  id: id ?? this.id,
  activityName: activityName ?? this.activityName,
  activityType: activityType ?? this.activityType,
  status: status ?? this.status,
  skipUrl: skipUrl ?? this.skipUrl,
  distributionMethod: distributionMethod ?? this.distributionMethod,
  jumpPage: jumpPage ?? this.jumpPage,
  jumpappType: jumpappType ?? this.jumpappType,
  studioNum: studioNum ?? this.studioNum,
  gameType: gameType ?? this.gameType,
  config: config ?? this.config,
  langList: langList ?? this.langList,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['activityName'] = activityName;
    map['activityType'] = activityType;
    map['status'] = status;
    map['skipUrl'] = skipUrl;
    map['distributionMethod'] = distributionMethod;
    map['jumpPage'] = jumpPage;
    map['jumpappType'] = jumpappType;
    map['studioNum'] = studioNum;
    map['gameType'] = gameType;
    if (config != null) {
      map['config'] = config?.map((v) => v.toJson()).toList();
    }
    if (langList != null) {
      map['langList'] = langList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 81
/// activityTitle : ""
/// activityContent : ""
/// lang : "zh_CN"
/// imageUrl : ""

class LangList {
  LangList({
      this.id, 
      this.activityTitle, 
      this.activityContent, 
      this.lang, 
      this.imageUrl,});

  LangList.fromJson(dynamic json) {
    id = json['id'];
    activityTitle = json['activityTitle'];
    activityContent = json['activityContent'];
    lang = json['lang'];
    imageUrl = json['imageUrl'];
  }
  num? id;
  String? activityTitle;
  String? activityContent;
  String? lang;
  String? imageUrl;
LangList copyWith({  num? id,
  String? activityTitle,
  String? activityContent,
  String? lang,
  String? imageUrl,
}) => LangList(  id: id ?? this.id,
  activityTitle: activityTitle ?? this.activityTitle,
  activityContent: activityContent ?? this.activityContent,
  lang: lang ?? this.lang,
  imageUrl: imageUrl ?? this.imageUrl,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['activityTitle'] = activityTitle;
    map['activityContent'] = activityContent;
    map['lang'] = lang;
    map['imageUrl'] = imageUrl;
    return map;
  }

}

/// recharge : 50
/// given : 388

class Config {
  Config({
      this.recharge, 
      this.given,});

  Config.fromJson(dynamic json) {
    recharge = json['recharge'];
    given = json['given'];
  }
  num? recharge;
  num? given;
Config copyWith({  num? recharge,
  num? given,
}) => Config(  recharge: recharge ?? this.recharge,
  given: given ?? this.given,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['recharge'] = recharge;
    map['given'] = given;
    return map;
  }

}