/// anchorId : 0
/// id : 0
/// originType : 0
/// s1080pUrl : ""
/// s360pUrl : ""
/// s480pUrl : ""
/// s720pUrl : ""
/// secretKey : ""
/// studioUrl : ""
/// thumbUrl : ""
/// title : ""
/// videoCodeRateVOList : [{"codeRate":"","codeRateDesc":"","url":""}]

class HomeVideoBean {
  HomeVideoBean({
      num? anchorId, 
      num? id, 
      num? originType, 
      String? s1080pUrl, 
      String? s360pUrl, 
      String? s480pUrl, 
      String? s720pUrl, 
      String? secretKey, 
      String? studioUrl, 
      String? thumbUrl, 
      String? title, 
      List<VideoCodeRateVoList>? videoCodeRateVOList,}){
    _anchorId = anchorId;
    _id = id;
    _originType = originType;
    _s1080pUrl = s1080pUrl;
    _s360pUrl = s360pUrl;
    _s480pUrl = s480pUrl;
    _s720pUrl = s720pUrl;
    _secretKey = secretKey;
    _studioUrl = studioUrl;
    _thumbUrl = thumbUrl;
    _title = title;
    _videoCodeRateVOList = videoCodeRateVOList;
}

  HomeVideoBean.fromJson(dynamic json) {
    _anchorId = json['anchorId'];
    _id = json['id'];
    _originType = json['originType'];
    _s1080pUrl = json['s1080pUrl'];
    _s360pUrl = json['s360pUrl'];
    _s480pUrl = json['s480pUrl'];
    _s720pUrl = json['s720pUrl'];
    _secretKey = json['secretKey'];
    _studioUrl = json['studioUrl'];
    _thumbUrl = json['thumbUrl'];
    _title = json['title'];
    if (json['videoCodeRateVOList'] != null) {
      _videoCodeRateVOList = [];
      json['videoCodeRateVOList'].forEach((v) {
        _videoCodeRateVOList?.add(VideoCodeRateVoList.fromJson(v));
      });
    }
  }
  num? _anchorId;
  num? _id;
  num? _originType;
  String? _s1080pUrl;
  String? _s360pUrl;
  String? _s480pUrl;
  String? _s720pUrl;
  String? _secretKey;
  String? _studioUrl;
  String? _thumbUrl;
  String? _title;
  List<VideoCodeRateVoList>? _videoCodeRateVOList;
HomeVideoBean copyWith({  num? anchorId,
  num? id,
  num? originType,
  String? s1080pUrl,
  String? s360pUrl,
  String? s480pUrl,
  String? s720pUrl,
  String? secretKey,
  String? studioUrl,
  String? thumbUrl,
  String? title,
  List<VideoCodeRateVoList>? videoCodeRateVOList,
}) => HomeVideoBean(  anchorId: anchorId ?? _anchorId,
  id: id ?? _id,
  originType: originType ?? _originType,
  s1080pUrl: s1080pUrl ?? _s1080pUrl,
  s360pUrl: s360pUrl ?? _s360pUrl,
  s480pUrl: s480pUrl ?? _s480pUrl,
  s720pUrl: s720pUrl ?? _s720pUrl,
  secretKey: secretKey ?? _secretKey,
  studioUrl: studioUrl ?? _studioUrl,
  thumbUrl: thumbUrl ?? _thumbUrl,
  title: title ?? _title,
  videoCodeRateVOList: videoCodeRateVOList ?? _videoCodeRateVOList,
);
  num? get anchorId => _anchorId;
  num? get id => _id;
  num? get originType => _originType;
  String? get s1080pUrl => _s1080pUrl;
  String? get s360pUrl => _s360pUrl;
  String? get s480pUrl => _s480pUrl;
  String? get s720pUrl => _s720pUrl;
  String? get secretKey => _secretKey;
  String? get studioUrl => _studioUrl;
  String? get thumbUrl => _thumbUrl;
  String? get title => _title;
  List<VideoCodeRateVoList>? get videoCodeRateVOList => _videoCodeRateVOList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['anchorId'] = _anchorId;
    map['id'] = _id;
    map['originType'] = _originType;
    map['s1080pUrl'] = _s1080pUrl;
    map['s360pUrl'] = _s360pUrl;
    map['s480pUrl'] = _s480pUrl;
    map['s720pUrl'] = _s720pUrl;
    map['secretKey'] = _secretKey;
    map['studioUrl'] = _studioUrl;
    map['thumbUrl'] = _thumbUrl;
    map['title'] = _title;
    if (_videoCodeRateVOList != null) {
      map['videoCodeRateVOList'] = _videoCodeRateVOList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// codeRate : ""
/// codeRateDesc : ""
/// url : ""

class VideoCodeRateVoList {
  VideoCodeRateVoList({
      String? codeRate, 
      String? codeRateDesc, 
      String? url,}){
    _codeRate = codeRate;
    _codeRateDesc = codeRateDesc;
    _url = url;
}

  VideoCodeRateVoList.fromJson(dynamic json) {
    _codeRate = json['codeRate'];
    _codeRateDesc = json['codeRateDesc'];
    _url = json['url'];
  }
  String? _codeRate;
  String? _codeRateDesc;
  String? _url;
VideoCodeRateVoList copyWith({  String? codeRate,
  String? codeRateDesc,
  String? url,
}) => VideoCodeRateVoList(  codeRate: codeRate ?? _codeRate,
  codeRateDesc: codeRateDesc ?? _codeRateDesc,
  url: url ?? _url,
);
  String? get codeRate => _codeRate;
  String? get codeRateDesc => _codeRateDesc;
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['codeRate'] = _codeRate;
    map['codeRateDesc'] = _codeRateDesc;
    map['url'] = _url;
    return map;
  }

}