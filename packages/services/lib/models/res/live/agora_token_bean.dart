/// agoraKey : ""
/// agoraKeyAsciiCode : ""
/// agoraSalt : ""
/// expire : 0
/// token : ""

class AgoraTokenBean {
  AgoraTokenBean({
      String? agoraKey, 
      String? agoraKeyAsciiCode, 
      String? agoraSalt, 
      num? expire, 
      String? token,}){
    _agoraKey = agoraKey;
    _agoraKeyAsciiCode = agoraKeyAsciiCode;
    _agoraSalt = agoraSalt;
    _expire = expire;
    _token = token;
}

  AgoraTokenBean.fromJson(dynamic json) {
    _agoraKey = json['agoraKey'];
    _agoraKeyAsciiCode = json['agoraKeyAsciiCode'];
    _agoraSalt = json['agoraSalt'];
    _expire = json['expire'];
    _token = json['token'];
  }
  String? _agoraKey;
  String? _agoraKeyAsciiCode;
  String? _agoraSalt;
  num? _expire;
  String? _token;
  AgoraTokenBean copyWith({  String? agoraKey,
  String? agoraKeyAsciiCode,
  String? agoraSalt,
  num? expire,
  String? token,
}) => AgoraTokenBean(  agoraKey: agoraKey ?? _agoraKey,
  agoraKeyAsciiCode: agoraKeyAsciiCode ?? _agoraKeyAsciiCode,
  agoraSalt: agoraSalt ?? _agoraSalt,
  expire: expire ?? _expire,
  token: token ?? _token,
);
  String? get agoraKey => _agoraKey;
  String? get agoraKeyAsciiCode => _agoraKeyAsciiCode;
  String? get agoraSalt => _agoraSalt;
  num? get expire => _expire;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['agoraKey'] = _agoraKey;
    map['agoraKeyAsciiCode'] = _agoraKeyAsciiCode;
    map['agoraSalt'] = _agoraSalt;
    map['expire'] = _expire;
    map['token'] = _token;
    return map;
  }

}