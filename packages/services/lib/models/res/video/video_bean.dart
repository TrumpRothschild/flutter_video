
/// cover : ""
/// duration : 0
/// id : ""
/// likeNumber : 0
/// offlineFlag : 0
/// price : 0
/// priceType : 0
/// tagList : ""
/// title : ""
/// videoId : 0

class VideoBean {
  VideoBean({
    String? cover,
    int? duration,
    String? id,
    int? likeNumber,
    num? offlineFlag,
    bool? flag,
    num? price,
    int? priceType,
    String? tagList,
    String? title,
    num? videoId,
  }) {
    _cover = cover;
    _duration = duration;
    _id = id;
    _likeNumber = likeNumber;
    _offlineFlag = offlineFlag;
    _flag = flag;
    _price = price;
    _priceType = priceType;
    _tagList = tagList;
    _title = title;
    _videoId = videoId;
  }

  VideoBean.fromJson(dynamic json) {
    _cover = json['cover'];
    _duration = json['duration'];
    _id = json['id'];
    _likeNumber = json['likeNumber'];
    _offlineFlag = json['offlineFlag'];
    _flag = json['flag'];
    _price = json['price'];
    _priceType = json['priceType'];
    _tagList = json['tagList'];
    _title = json['title'];
    _videoId = json['videoId'];
  }

  String? _cover;
  int? _duration;
  String? _id;
  int? _likeNumber;
  num? _offlineFlag;
  bool? _flag;
  num? _price;
  int? _priceType;
  String? _tagList;
  String? _title;
  num? _videoId;

  VideoBean copyWith({
    String? cover,
    int? duration,
    String? id,
    int? likeNumber,
    num? offlineFlag,
    bool? flag,
    num? price,
    int? priceType,
    String? tagList,
    String? title,
    num? videoId,
  }) =>
      VideoBean(
        cover: cover ?? _cover,
        duration: duration ?? _duration,
        id: id ?? _id,
        likeNumber: likeNumber ?? _likeNumber,
        offlineFlag: offlineFlag ?? _offlineFlag,
        flag: flag ?? _flag,
        price: price ?? _price,
        priceType: priceType ?? _priceType,
        tagList: tagList ?? _tagList,
        title: title ?? _title,
        videoId: videoId ?? _videoId,
      );

  String? get cover => _cover;

  int? get duration => _duration;

  String? get id => _id;

  int? get likeNumber => _likeNumber;

  num? get offlineFlag => _offlineFlag;

  num? get price => _price;

  int? get priceType => _priceType;

  String? get tagList => _tagList;

  String? get title => _title;

  bool get flag => _flag??false;

  set flag(bool value) {
    _flag = value;
  }

  num? get videoId => _videoId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cover'] = _cover;
    map['duration'] = _duration;
    map['id'] = _id;
    map['likeNumber'] = _likeNumber;
    map['offlineFlag'] = _offlineFlag;
    map['flag'] = _flag;
    map['price'] = _price;
    map['priceType'] = _priceType;
    map['tagList'] = _tagList;
    map['title'] = _title;
    map['videoId'] = _videoId;
    return map;
  }
}