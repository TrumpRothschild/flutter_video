/// area : ""
/// avatar : "picture/2023/03/04/1799723723361637056.w.jpeg"
/// barrage : "弹幕消息"
/// firepower : "0"
/// isTourists : true
/// level : 9
/// levelName : "VIP9"
/// nickName : "安若汐_QFCA2"
/// userId : "1362"

class ImBarrageBean {
  ImBarrageBean({
      String? area, 
      String? avatar, 
      String? barrage, 
      String? firepower, 
      bool? isTourists, 
      num? level, 
      String? levelName, 
      String? nickName, 
      String? userId,}){
    _area = area;
    _avatar = avatar;
    _barrage = barrage;
    _firepower = firepower;
    _isTourists = isTourists;
    _level = level;
    _levelName = levelName;
    _nickName = nickName;
    _userId = userId;
}

  ImBarrageBean.fromJson(dynamic json) {
    _area = json['area'];
    _avatar = json['avatar'];
    _barrage = json['barrage'];
    _firepower = json['firepower'];
    _isTourists = json['isTourists'];
    _level = json['level'];
    _levelName = json['levelName'];
    _nickName = json['nickName'];
    _userId = json['userId'];
  }
  String? _area;
  String? _avatar;
  String? _barrage;
  String? _firepower;
  bool? _isTourists;
  num? _level;
  String? _levelName;
  String? _nickName;
  String? _userId;
ImBarrageBean copyWith({  String? area,
  String? avatar,
  String? barrage,
  String? firepower,
  bool? isTourists,
  num? level,
  String? levelName,
  String? nickName,
  String? userId,
}) => ImBarrageBean(  area: area ?? _area,
  avatar: avatar ?? _avatar,
  barrage: barrage ?? _barrage,
  firepower: firepower ?? _firepower,
  isTourists: isTourists ?? _isTourists,
  level: level ?? _level,
  levelName: levelName ?? _levelName,
  nickName: nickName ?? _nickName,
  userId: userId ?? _userId,
);
  String? get area => _area;
  String? get avatar => _avatar;
  String? get barrage => _barrage;
  String? get firepower => _firepower;
  bool? get isTourists => _isTourists;
  num? get level => _level;
  String? get levelName => _levelName;
  String? get nickName => _nickName;
  String? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['area'] = _area;
    map['avatar'] = _avatar;
    map['barrage'] = _barrage;
    map['firepower'] = _firepower;
    map['isTourists'] = _isTourists;
    map['level'] = _level;
    map['levelName'] = _levelName;
    map['nickName'] = _nickName;
    map['userId'] = _userId;
    return map;
  }

}