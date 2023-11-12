
/// duration : 0
/// id : 0
/// s1080pUrl : ""
/// s360pUrl : ""
/// s480pUrl : ""
/// s720pUrl : ""
/// secretKey : ""
/// sourceId : 0
/// title : ""
/// url : ""
/// videoCodeRateVOList : [{"codeRate":"","codeRateDesc":"","url":""}]

class LiveVideoListBean {
  LiveVideoListBean({
    num? duration,
    num? id,
    String? s1080pUrl,
    String? s360pUrl,
    String? s480pUrl,
    String? s720pUrl,
    String? secretKey,
    num? sourceId,
    String? title,
    String? url,
    List<VideoCodeRateVoList>? videoCodeRateVOList,}){
    _duration = duration;
    _id = id;
    _s1080pUrl = s1080pUrl;
    _s360pUrl = s360pUrl;
    _s480pUrl = s480pUrl;
    _s720pUrl = s720pUrl;
    _secretKey = secretKey;
    _sourceId = sourceId;
    _title = title;
    _url = url;
    _videoCodeRateVOList = videoCodeRateVOList;
  }

  LiveVideoListBean.fromJson(dynamic json) {
    _duration = json['duration'];
    _id = json['id'];
    _s1080pUrl = json['s1080pUrl'];
    _s360pUrl = json['s360pUrl'];
    _s480pUrl = json['s480pUrl'];
    _s720pUrl = json['s720pUrl'];
    _secretKey = json['secretKey'];
    _sourceId = json['sourceId'];
    _title = json['title'];
    _url = json['url'];
    if (json['videoCodeRateVOList'] != null) {
      _videoCodeRateVOList = [];
      json['videoCodeRateVOList'].forEach((v) {
        _videoCodeRateVOList?.add(VideoCodeRateVoList.fromJson(v));
      });
    }
  }
  num? _duration;
  num? _id;
  String? _s1080pUrl;
  String? _s360pUrl;
  String? _s480pUrl;
  String? _s720pUrl;
  String? _secretKey;
  num? _sourceId;
  String? _title;
  String? _url;
  List<VideoCodeRateVoList>? _videoCodeRateVOList;
  LiveVideoListBean copyWith({  num? duration,
    num? id,
    String? s1080pUrl,
    String? s360pUrl,
    String? s480pUrl,
    String? s720pUrl,
    String? secretKey,
    num? sourceId,
    String? title,
    String? url,
    List<VideoCodeRateVoList>? videoCodeRateVOList,
  }) => LiveVideoListBean(  duration: duration ?? _duration,
    id: id ?? _id,
    s1080pUrl: s1080pUrl ?? _s1080pUrl,
    s360pUrl: s360pUrl ?? _s360pUrl,
    s480pUrl: s480pUrl ?? _s480pUrl,
    s720pUrl: s720pUrl ?? _s720pUrl,
    secretKey: secretKey ?? _secretKey,
    sourceId: sourceId ?? _sourceId,
    title: title ?? _title,
    url: url ?? _url,
    videoCodeRateVOList: videoCodeRateVOList ?? _videoCodeRateVOList,
  );
  num? get duration => _duration;
  num? get id => _id;
  String? get s1080pUrl => _s1080pUrl;
  String? get s360pUrl => _s360pUrl;
  String? get s480pUrl => _s480pUrl;
  String? get s720pUrl => _s720pUrl;
  String? get secretKey => _secretKey;
  num? get sourceId => _sourceId;
  String? get title => _title;
  String? get url => _url;
  List<VideoCodeRateVoList>? get videoCodeRateVOList => _videoCodeRateVOList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['duration'] = _duration;
    map['id'] = _id;
    map['s1080pUrl'] = _s1080pUrl;
    map['s360pUrl'] = _s360pUrl;
    map['s480pUrl'] = _s480pUrl;
    map['s720pUrl'] = _s720pUrl;
    map['secretKey'] = _secretKey;
    map['sourceId'] = _sourceId;
    map['title'] = _title;
    map['url'] = _url;
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