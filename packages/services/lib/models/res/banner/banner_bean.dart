/// advImg : ""
/// advName : ""
/// id : 0
/// params : ""
/// skipModel : ""
/// skipUrl : ""
/// type : 0
class BannerBean {
  BannerBean({
    String? advImg,
    String? advName,
    num? id,
    String? params,
    String? skipModel,
    String? skipUrl,
    int? type,
  }) {
    _advImg = advImg;
    _advName = advName;
    _id = id;
    _params = params;
    _skipModel = skipModel;
    _skipUrl = skipUrl;
    _type = type;
  }

  BannerBean.fromJson(dynamic json) {
    _advImg = json['advImg'];
    _advName = json['advName'];
    _id = json['id'];
    _params = json['params'];
    _skipModel = json['skipModel'];
    _skipUrl = json['skipUrl'];
    _type = json['type'];
  }

  String? _advImg;
  String? _advName;
  num? _id;
  String? _params;
  String? _skipModel;
  String? _skipUrl;
  int? _type;

  BannerBean copyWith({
    String? advImg,
    String? advName,
    num? id,
    String? params,
    String? skipModel,
    String? skipUrl,
    int? type,
  }) =>
      BannerBean(
        advImg: advImg ?? _advImg,
        advName: advName ?? _advName,
        id: id ?? _id,
        params: params ?? _params,
        skipModel: skipModel ?? _skipModel,
        skipUrl: skipUrl ?? _skipUrl,
        type: type ?? _type,
      );

  String? get advImg => _advImg;

  String? get advName => _advName;

  num? get id => _id;

  String? get params => _params;

  String? get skipModel => _skipModel;

  String? get skipUrl => _skipUrl;

  int? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['advImg'] = _advImg;
    map['advName'] = _advName;
    map['id'] = _id;
    map['params'] = _params;
    map['skipModel'] = _skipModel;
    map['skipUrl'] = _skipUrl;
    map['type'] = _type;
    return map;
  }
}
