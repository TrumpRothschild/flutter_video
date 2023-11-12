/// contentType : 0
/// durationType : 0
/// excludeId : 0
/// keyWord : ""
/// mosaicFlag : 0
/// pageNum : 1
/// pageSize : 10
/// priceType : 0
/// region : 0
/// sortType : 0
/// sorts : [{"name":"name","type":"desc"}]
/// subtitleFlag : 0

class VideoSearchParam {
  VideoSearchParam({
    // 内容类型，如果没选不传或传0 1：AV 2：三级 3：动漫 4：自拍
    int? contentType,
    // 时长类型 1：0-10分钟 2：11-30分钟 3：31-60分钟 4：61-180 5：大于180分钟
    int? durationType,
    // 排除ID
    num? excludeId,
    // 搜索关键字
    String? keyWord,
    // 0：无码 1有码
    int? mosaicFlag,
    //第几页
    int? pageNum,
    // 每页最大数量
    int? pageSize,
    // 收费类型，如果没选不传或传0 默认1=免费,2=收费
    int? priceType,
    // 地区类型 1：大陆 2：日本 3：韩国 4：欧美 5：台湾 6：港澳
    int? region,
    // 排序类型 1：标准 2：最多播放 3：最多评论 4：时间 5：热度
    int? sortType,
    // 排序
    List<Sorts>? sorts,
    //字幕 0：无中字幕 1：有中字幕
    int? subtitleFlag,
  }) {
    _contentType = contentType;
    _durationType = durationType;
    _excludeId = excludeId;
    _keyWord = keyWord;
    _mosaicFlag = mosaicFlag;
    _pageNum = pageNum;
    _pageSize = pageSize;
    _priceType = priceType;
    _region = region;
    _sortType = sortType;
    _sorts = sorts;
    _subtitleFlag = subtitleFlag;
  }

  VideoSearchParam.fromJson(dynamic json) {
    _contentType = json['contentType'];
    _durationType = json['durationType'];
    _excludeId = json['excludeId'];
    _keyWord = json['keyWord'];
    _mosaicFlag = json['mosaicFlag'];
    _pageNum = json['pageNum'];
    _pageSize = json['pageSize'];
    _priceType = json['priceType'];
    _region = json['region'];
    _sortType = json['sortType'];
    if (json['sorts'] != null) {
      _sorts = [];
      json['sorts'].forEach((v) {
        _sorts?.add(Sorts.fromJson(v));
      });
    }
    _subtitleFlag = json['subtitleFlag'];
  }

  int? _contentType;
  int? _durationType;
  num? _excludeId;
  String? _keyWord;
  int? _mosaicFlag;
  int? _pageNum;
  int? _pageSize;
  int? _priceType;
  int? _region;
  int? _sortType;
  List<Sorts>? _sorts;
  int? _subtitleFlag;

  VideoSearchParam copyWith({
    int? contentType,
    int? durationType,
    num? excludeId,
    String? keyWord,
    int? mosaicFlag,
    int? pageNum,
    int? pageSize,
    int? priceType,
    int? region,
    int? sortType,
    List<Sorts>? sorts,
    int? subtitleFlag,
  }) =>
      VideoSearchParam(
        contentType: contentType ?? _contentType,
        durationType: durationType ?? _durationType,
        excludeId: excludeId ?? _excludeId,
        keyWord: keyWord ?? _keyWord,
        mosaicFlag: mosaicFlag ?? _mosaicFlag,
        pageNum: pageNum ?? _pageNum,
        pageSize: pageSize ?? _pageSize,
        priceType: priceType ?? _priceType,
        region: region ?? _region,
        sortType: sortType ?? _sortType,
        sorts: sorts ?? _sorts,
        subtitleFlag: subtitleFlag ?? _subtitleFlag,
      );

  num? get contentType => _contentType;

  num? get durationType => _durationType;

  num? get excludeId => _excludeId;

  String? get keyWord => _keyWord;

  num? get mosaicFlag => _mosaicFlag;

  num? get pageNum => _pageNum;

  num? get pageSize => _pageSize;

  num? get priceType => _priceType;

  num? get region => _region;

  num? get sortType => _sortType;

  List<Sorts>? get sorts => _sorts;

  num? get subtitleFlag => _subtitleFlag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_contentType != null) map['contentType'] = _contentType;
    if (_durationType != null) map['durationType'] = _durationType;
    if (_excludeId != null) map['excludeId'] = _excludeId;
    if (_keyWord != null) map['keyWord'] = _keyWord;
    if (_mosaicFlag != null) map['mosaicFlag'] = _mosaicFlag;
    map['pageNum'] = _pageNum;
    map['pageSize'] = _pageSize;
    map['channelCode'] = 'official';
    if (_priceType != null) map['priceType'] = _priceType;
    if (_region != null) map['region'] = _region;
    if (_sortType != null) map['sortType'] = _sortType;
    if (_sorts != null) {
      map['sorts'] = _sorts?.map((v) => v.toJson()).toList();
    }
    if (_subtitleFlag != null) map['subtitleFlag'] = _subtitleFlag;
    return map;
  }
}

/// name : "name"
/// type : "desc"

class Sorts {
  Sorts({
    //排序字段
    String? name,
    //type
    String? type,
  }) {
    _name = name;
    _type = type;
  }

  Sorts.fromJson(dynamic json) {
    _name = json['name'];
    _type = json['type'];
  }

  String? _name;
  String? _type;

  Sorts copyWith({
    String? name,
    String? type,
  }) =>
      Sorts(
        name: name ?? _name,
        type: type ?? _type,
      );

  String? get name => _name;

  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['type'] = _type;
    return map;
  }
}
