/// id : 1362
/// accno : "1000000049"
/// mobilePhone : "15111111111"
/// areaCode : null
/// userAccount : "008615111111111"
/// lang : null
/// merchantCode : "0"
/// userType : 0
/// registerCountryCode : "zh_CN"
/// countryCode : null
/// personalSignature : "我写了签名哦，真的写了，不要忽视我！！！！！！！！！！！！！！！"
/// nickName : "安若汐_QFCA2"
/// avatar : "https://img.91momo50.vip/picture/2023/03/04/1799723723361637056.w.jpeg?auth_key=1678593037968-46f1af48a54b4df5b808509f20607da2-0-2aa234b67217904e6b83833d7a6dd6ca"
/// level : 9
/// tokenTime : null
/// studioNum : "1522_0"
/// onlineUsersCount : 41
/// source : null
/// enterRoomTime : 1678592737967
/// isRobot : false
/// silver : 0.0

class ImEnterRoomBean {
  ImEnterRoomBean({
      num? id, 
      String? accno, 
      String? mobilePhone, 
      dynamic areaCode, 
      String? userAccount, 
      dynamic lang, 
      String? merchantCode, 
      num? userType, 
      String? registerCountryCode, 
      dynamic countryCode, 
      String? personalSignature, 
      String? nickName, 
      String? avatar, 
      num? level, 
      dynamic tokenTime, 
      String? studioNum, 
      num? onlineUsersCount, 
      dynamic source, 
      num? enterRoomTime, 
      bool? isRobot, 
      num? silver,}){
    _id = id;
    _accno = accno;
    _mobilePhone = mobilePhone;
    _areaCode = areaCode;
    _userAccount = userAccount;
    _lang = lang;
    _merchantCode = merchantCode;
    _userType = userType;
    _registerCountryCode = registerCountryCode;
    _countryCode = countryCode;
    _personalSignature = personalSignature;
    _nickName = nickName;
    _avatar = avatar;
    _level = level;
    _tokenTime = tokenTime;
    _studioNum = studioNum;
    _onlineUsersCount = onlineUsersCount;
    _source = source;
    _enterRoomTime = enterRoomTime;
    _isRobot = isRobot;
    _silver = silver;
}

  ImEnterRoomBean.fromJson(dynamic json) {
    _id = json['id'];
    _accno = json['accno'];
    _mobilePhone = json['mobilePhone'];
    _areaCode = json['areaCode'];
    _userAccount = json['userAccount'];
    _lang = json['lang'];
    _merchantCode = json['merchantCode'];
    _userType = json['userType'];
    _registerCountryCode = json['registerCountryCode'];
    _countryCode = json['countryCode'];
    _personalSignature = json['personalSignature'];
    _nickName = json['nickName'];
    _avatar = json['avatar'];
    _level = json['level'];
    _tokenTime = json['tokenTime'];
    _studioNum = json['studioNum'];
    _onlineUsersCount = json['onlineUsersCount'];
    _source = json['source'];
    _enterRoomTime = json['enterRoomTime'];
    _isRobot = json['isRobot'];
    _silver = json['silver'];
  }
  num? _id;
  String? _accno;
  String? _mobilePhone;
  dynamic _areaCode;
  String? _userAccount;
  dynamic _lang;
  String? _merchantCode;
  num? _userType;
  String? _registerCountryCode;
  dynamic _countryCode;
  String? _personalSignature;
  String? _nickName;
  String? _avatar;
  num? _level;
  dynamic _tokenTime;
  String? _studioNum;
  num? _onlineUsersCount;
  dynamic _source;
  num? _enterRoomTime;
  bool? _isRobot;
  num? _silver;
ImEnterRoomBean copyWith({  num? id,
  String? accno,
  String? mobilePhone,
  dynamic areaCode,
  String? userAccount,
  dynamic lang,
  String? merchantCode,
  num? userType,
  String? registerCountryCode,
  dynamic countryCode,
  String? personalSignature,
  String? nickName,
  String? avatar,
  num? level,
  dynamic tokenTime,
  String? studioNum,
  num? onlineUsersCount,
  dynamic source,
  num? enterRoomTime,
  bool? isRobot,
  num? silver,
}) => ImEnterRoomBean(  id: id ?? _id,
  accno: accno ?? _accno,
  mobilePhone: mobilePhone ?? _mobilePhone,
  areaCode: areaCode ?? _areaCode,
  userAccount: userAccount ?? _userAccount,
  lang: lang ?? _lang,
  merchantCode: merchantCode ?? _merchantCode,
  userType: userType ?? _userType,
  registerCountryCode: registerCountryCode ?? _registerCountryCode,
  countryCode: countryCode ?? _countryCode,
  personalSignature: personalSignature ?? _personalSignature,
  nickName: nickName ?? _nickName,
  avatar: avatar ?? _avatar,
  level: level ?? _level,
  tokenTime: tokenTime ?? _tokenTime,
  studioNum: studioNum ?? _studioNum,
  onlineUsersCount: onlineUsersCount ?? _onlineUsersCount,
  source: source ?? _source,
  enterRoomTime: enterRoomTime ?? _enterRoomTime,
  isRobot: isRobot ?? _isRobot,
  silver: silver ?? _silver,
);
  num? get id => _id;
  String? get accno => _accno;
  String? get mobilePhone => _mobilePhone;
  dynamic get areaCode => _areaCode;
  String? get userAccount => _userAccount;
  dynamic get lang => _lang;
  String? get merchantCode => _merchantCode;
  num? get userType => _userType;
  String? get registerCountryCode => _registerCountryCode;
  dynamic get countryCode => _countryCode;
  String? get personalSignature => _personalSignature;
  String? get nickName => _nickName;
  String? get avatar => _avatar;
  num? get level => _level;
  dynamic get tokenTime => _tokenTime;
  String? get studioNum => _studioNum;
  num? get onlineUsersCount => _onlineUsersCount;
  dynamic get source => _source;
  num? get enterRoomTime => _enterRoomTime;
  bool? get isRobot => _isRobot;
  num? get silver => _silver;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['accno'] = _accno;
    map['mobilePhone'] = _mobilePhone;
    map['areaCode'] = _areaCode;
    map['userAccount'] = _userAccount;
    map['lang'] = _lang;
    map['merchantCode'] = _merchantCode;
    map['userType'] = _userType;
    map['registerCountryCode'] = _registerCountryCode;
    map['countryCode'] = _countryCode;
    map['personalSignature'] = _personalSignature;
    map['nickName'] = _nickName;
    map['avatar'] = _avatar;
    map['level'] = _level;
    map['tokenTime'] = _tokenTime;
    map['studioNum'] = _studioNum;
    map['onlineUsersCount'] = _onlineUsersCount;
    map['source'] = _source;
    map['enterRoomTime'] = _enterRoomTime;
    map['isRobot'] = _isRobot;
    map['silver'] = _silver;
    return map;
  }

}