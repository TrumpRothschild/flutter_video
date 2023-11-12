

/// bannerImage : ""
/// bannerName : ""
/// extraParams : ""
/// id : 0
/// skipModel : 0
/// skipValue : ""
/// type : 0

class BannerListBean {
  BannerListBean({
    String? bannerImage,
    String? bannerName,
    String? extraParams,
    num? id,
    int? skipModel,
    String? skipValue,
    int? type,
  }) {
    _bannerImage = bannerImage;
    _bannerName = bannerName;
    _extraParams = extraParams;
    _id = id;
    _skipModel = skipModel;
    _skipValue = skipValue;
    _type = type;
  }

  BannerListBean.fromJson(dynamic json) {
    _bannerImage = json['bannerImage'];
    _bannerName = json['bannerName'];
    _extraParams = json['extraParams'];
    _id = json['id'];
    _skipModel = json['skipModel'];
    _skipValue = json['skipValue'];
    _type = json['type'];
  }

  String? _bannerImage;
  String? _bannerName;
  String? _extraParams;
  num? _id;
  int? _skipModel;
  String? _skipValue;
  int? _type;

  BannerListBean copyWith({
    String? bannerImage,
    String? bannerName,
    String? extraParams,
    num? id,
    int? skipModel,
    String? skipValue,
    int? type,
  }) =>
      BannerListBean(
        bannerImage: bannerImage ?? _bannerImage,
        bannerName: bannerName ?? _bannerName,
        extraParams: extraParams ?? _extraParams,
        id: id ?? _id,
        skipModel: skipModel ?? _skipModel,
        skipValue: skipValue ?? _skipValue,
        type: type ?? _type,
      );

  String? get bannerImage => _bannerImage;

  String? get bannerName => _bannerName;

  String? get extraParams => _extraParams;

  num? get id => _id;

  int? get skipModel => _skipModel;

  String? get skipValue => _skipValue;

  int? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bannerImage'] = _bannerImage;
    map['bannerName'] = _bannerName;
    map['extraParams'] = _extraParams;
    map['id'] = _id;
    map['skipModel'] = _skipModel;
    map['skipValue'] = _skipValue;
    map['type'] = _type;
    return map;
  }
}