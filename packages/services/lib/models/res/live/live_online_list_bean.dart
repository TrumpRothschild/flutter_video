
/// adminType : 0
/// avatar : ""
/// countryCode : ""
/// enterRoomTime : 0
/// level : 0
/// nickName : ""
/// personalSignature : ""
/// sex : 0
/// silver : 0
/// userAccount : ""
/// userId : ""
/// userType : 0

class LiveOnlineListBean {
  LiveOnlineListBean({
    num? adminType,
    String? avatar,
    String? countryCode,
    num? enterRoomTime,
    num? level,
    String? nickName,
    String? personalSignature,
    num? sex,
    num? silver,
    String? userAccount,
    String? userId,
    num? userType,
  }) {
    _adminType = adminType;
    _avatar = avatar;
    _countryCode = countryCode;
    _enterRoomTime = enterRoomTime;
    _level = level;
    _nickName = nickName;
    _personalSignature = personalSignature;
    _sex = sex;
    _silver = silver;
    _userAccount = userAccount;
    _userId = userId;
    _userType = userType;
  }

  LiveOnlineListBean.fromJson(dynamic json) {
    _adminType = json['adminType'];
    _avatar = json['avatar'];
    _countryCode = json['countryCode'];
    _enterRoomTime = json['enterRoomTime'];
    _level = json['level'];
    _nickName = json['nickName'];
    _personalSignature = json['personalSignature'];
    _sex = json['sex'];
    _silver = json['silver'];
    _userAccount = json['userAccount'];
    _userId = json['userId'];
    _userType = json['userType'];
  }

  num? _adminType;
  String? _avatar;
  String? _countryCode;
  num? _enterRoomTime;
  num? _level;
  String? _nickName;
  String? _personalSignature;
  num? _sex;
  num? _silver;
  String? _userAccount;
  String? _userId;
  num? _userType;

  LiveOnlineListBean copyWith({
    num? adminType,
    String? avatar,
    String? countryCode,
    num? enterRoomTime,
    num? level,
    String? nickName,
    String? personalSignature,
    num? sex,
    num? silver,
    String? userAccount,
    String? userId,
    num? userType,
  }) =>
      LiveOnlineListBean(
        adminType: adminType ?? _adminType,
        avatar: avatar ?? _avatar,
        countryCode: countryCode ?? _countryCode,
        enterRoomTime: enterRoomTime ?? _enterRoomTime,
        level: level ?? _level,
        nickName: nickName ?? _nickName,
        personalSignature: personalSignature ?? _personalSignature,
        sex: sex ?? _sex,
        silver: silver ?? _silver,
        userAccount: userAccount ?? _userAccount,
        userId: userId ?? _userId,
        userType: userType ?? _userType,
      );

  num? get adminType => _adminType;

  String? get avatar => _avatar;

  String? get countryCode => _countryCode;

  num? get enterRoomTime => _enterRoomTime;

  num? get level => _level;

  String? get nickName => _nickName;

  String? get personalSignature => _personalSignature;

  num? get sex => _sex;

  num? get silver => _silver;

  String? get userAccount => _userAccount;

  String? get userId => _userId;

  num? get userType => _userType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adminType'] = _adminType;
    map['avatar'] = _avatar;
    map['countryCode'] = _countryCode;
    map['enterRoomTime'] = _enterRoomTime;
    map['level'] = _level;
    map['nickName'] = _nickName;
    map['personalSignature'] = _personalSignature;
    map['sex'] = _sex;
    map['silver'] = _silver;
    map['userAccount'] = _userAccount;
    map['userId'] = _userId;
    map['userType'] = _userType;
    return map;
  }
}
