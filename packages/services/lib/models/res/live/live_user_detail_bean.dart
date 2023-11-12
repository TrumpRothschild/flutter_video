/// accno : ""
/// adminType : 0
/// area : ""
/// avatar : ""
/// birthday : ""
/// contributeUserList : [{"avatar":"","userId":0}]
/// countryCode : ""
/// fansNum : 0
/// firepower : ""
/// focusNum : 0
/// giftTotal : 0
/// hometown : ""
/// isFocus : true
/// isOpenLive : true
/// level : 0
/// levelIcon : ""
/// levelName : ""
/// maritalStatus : 0
/// nickName : ""
/// occupationCode : ""
/// onlineUsersCount : 0
/// personalSignature : ""
/// registerArea : ""
/// sex : 0
/// source : ""
/// userAccount : ""
/// userId : ""
/// userType : 0

class LiveUserDetailBean {
  LiveUserDetailBean({
      String? accno, 
      num? adminType, 
      String? area, 
      String? avatar, 
      String? birthday, 
      List<ContributeUserList>? contributeUserList, 
      String? countryCode, 
      num? fansNum, 
      String? firepower, 
      num? focusNum, 
      num? giftTotal, 
      String? hometown, 
      bool? isFocus, 
      bool? isOpenLive, 
      num? level, 
      String? levelIcon, 
      String? levelName, 
      num? maritalStatus, 
      String? nickName, 
      String? occupationCode, 
      num? onlineUsersCount, 
      String? personalSignature, 
      String? registerArea, 
      num? sex, 
      String? source, 
      String? userAccount, 
      String? userId, 
      num? userType,}){
    _accno = accno;
    _adminType = adminType;
    _area = area;
    _avatar = avatar;
    _birthday = birthday;
    _contributeUserList = contributeUserList;
    _countryCode = countryCode;
    _fansNum = fansNum;
    _firepower = firepower;
    _focusNum = focusNum;
    _giftTotal = giftTotal;
    _hometown = hometown;
    _isFocus = isFocus;
    _isOpenLive = isOpenLive;
    _level = level;
    _levelIcon = levelIcon;
    _levelName = levelName;
    _maritalStatus = maritalStatus;
    _nickName = nickName;
    _occupationCode = occupationCode;
    _onlineUsersCount = onlineUsersCount;
    _personalSignature = personalSignature;
    _registerArea = registerArea;
    _sex = sex;
    _source = source;
    _userAccount = userAccount;
    _userId = userId;
    _userType = userType;
}

  LiveUserDetailBean.fromJson(dynamic json) {
    _accno = json['accno'];
    _adminType = json['adminType'];
    _area = json['area'];
    _avatar = json['avatar'];
    _birthday = json['birthday'];
    if (json['contributeUserList'] != null) {
      _contributeUserList = [];
      json['contributeUserList'].forEach((v) {
        _contributeUserList?.add(ContributeUserList.fromJson(v));
      });
    }
    _countryCode = json['countryCode'];
    _fansNum = json['fansNum'];
    _firepower = json['firepower'];
    _focusNum = json['focusNum'];
    _giftTotal = json['giftTotal'];
    _hometown = json['hometown'];
    _isFocus = json['isFocus'];
    _isOpenLive = json['isOpenLive'];
    _level = json['level'];
    _levelIcon = json['levelIcon'];
    _levelName = json['levelName'];
    _maritalStatus = json['maritalStatus'];
    _nickName = json['nickName'];
    _occupationCode = json['occupationCode'];
    _onlineUsersCount = json['onlineUsersCount'];
    _personalSignature = json['personalSignature'];
    _registerArea = json['registerArea'];
    _sex = json['sex'];
    _source = json['source'];
    _userAccount = json['userAccount'];
    _userId = json['userId'];
    _userType = json['userType'];
  }
  String? _accno;
  num? _adminType;
  String? _area;
  String? _avatar;
  String? _birthday;
  List<ContributeUserList>? _contributeUserList;
  String? _countryCode;
  num? _fansNum;
  String? _firepower;
  num? _focusNum;
  num? _giftTotal;
  String? _hometown;
  bool? _isFocus;
  bool? _isOpenLive;
  num? _level;
  String? _levelIcon;
  String? _levelName;
  num? _maritalStatus;
  String? _nickName;
  String? _occupationCode;
  num? _onlineUsersCount;
  String? _personalSignature;
  String? _registerArea;
  num? _sex;
  String? _source;
  String? _userAccount;
  String? _userId;
  num? _userType;
LiveUserDetailBean copyWith({  String? accno,
  num? adminType,
  String? area,
  String? avatar,
  String? birthday,
  List<ContributeUserList>? contributeUserList,
  String? countryCode,
  num? fansNum,
  String? firepower,
  num? focusNum,
  num? giftTotal,
  String? hometown,
  bool? isFocus,
  bool? isOpenLive,
  num? level,
  String? levelIcon,
  String? levelName,
  num? maritalStatus,
  String? nickName,
  String? occupationCode,
  num? onlineUsersCount,
  String? personalSignature,
  String? registerArea,
  num? sex,
  String? source,
  String? userAccount,
  String? userId,
  num? userType,
}) => LiveUserDetailBean(  accno: accno ?? _accno,
  adminType: adminType ?? _adminType,
  area: area ?? _area,
  avatar: avatar ?? _avatar,
  birthday: birthday ?? _birthday,
  contributeUserList: contributeUserList ?? _contributeUserList,
  countryCode: countryCode ?? _countryCode,
  fansNum: fansNum ?? _fansNum,
  firepower: firepower ?? _firepower,
  focusNum: focusNum ?? _focusNum,
  giftTotal: giftTotal ?? _giftTotal,
  hometown: hometown ?? _hometown,
  isFocus: isFocus ?? _isFocus,
  isOpenLive: isOpenLive ?? _isOpenLive,
  level: level ?? _level,
  levelIcon: levelIcon ?? _levelIcon,
  levelName: levelName ?? _levelName,
  maritalStatus: maritalStatus ?? _maritalStatus,
  nickName: nickName ?? _nickName,
  occupationCode: occupationCode ?? _occupationCode,
  onlineUsersCount: onlineUsersCount ?? _onlineUsersCount,
  personalSignature: personalSignature ?? _personalSignature,
  registerArea: registerArea ?? _registerArea,
  sex: sex ?? _sex,
  source: source ?? _source,
  userAccount: userAccount ?? _userAccount,
  userId: userId ?? _userId,
  userType: userType ?? _userType,
);
  String? get accno => _accno;
  num? get adminType => _adminType;
  String? get area => _area;
  String? get avatar => _avatar;
  String? get birthday => _birthday;
  List<ContributeUserList>? get contributeUserList => _contributeUserList;
  String? get countryCode => _countryCode;
  num? get fansNum => _fansNum;
  String? get firepower => _firepower;
  num? get focusNum => _focusNum;
  num? get giftTotal => _giftTotal;
  String? get hometown => _hometown;
  bool? get isFocus => _isFocus;
  bool? get isOpenLive => _isOpenLive;
  num? get level => _level;
  String? get levelIcon => _levelIcon;
  String? get levelName => _levelName;
  num? get maritalStatus => _maritalStatus;
  String? get nickName => _nickName;
  String? get occupationCode => _occupationCode;
  num? get onlineUsersCount => _onlineUsersCount;
  String? get personalSignature => _personalSignature;
  String? get registerArea => _registerArea;
  num? get sex => _sex;
  String? get source => _source;
  String? get userAccount => _userAccount;
  String? get userId => _userId;
  num? get userType => _userType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accno'] = _accno;
    map['adminType'] = _adminType;
    map['area'] = _area;
    map['avatar'] = _avatar;
    map['birthday'] = _birthday;
    if (_contributeUserList != null) {
      map['contributeUserList'] = _contributeUserList?.map((v) => v.toJson()).toList();
    }
    map['countryCode'] = _countryCode;
    map['fansNum'] = _fansNum;
    map['firepower'] = _firepower;
    map['focusNum'] = _focusNum;
    map['giftTotal'] = _giftTotal;
    map['hometown'] = _hometown;
    map['isFocus'] = _isFocus;
    map['isOpenLive'] = _isOpenLive;
    map['level'] = _level;
    map['levelIcon'] = _levelIcon;
    map['levelName'] = _levelName;
    map['maritalStatus'] = _maritalStatus;
    map['nickName'] = _nickName;
    map['occupationCode'] = _occupationCode;
    map['onlineUsersCount'] = _onlineUsersCount;
    map['personalSignature'] = _personalSignature;
    map['registerArea'] = _registerArea;
    map['sex'] = _sex;
    map['source'] = _source;
    map['userAccount'] = _userAccount;
    map['userId'] = _userId;
    map['userType'] = _userType;
    return map;
  }

}

/// avatar : ""
/// userId : 0

class ContributeUserList {
  ContributeUserList({
      String? avatar, 
      num? userId,}){
    _avatar = avatar;
    _userId = userId;
}

  ContributeUserList.fromJson(dynamic json) {
    _avatar = json['avatar'];
    _userId = json['userId'];
  }
  String? _avatar;
  num? _userId;
ContributeUserList copyWith({  String? avatar,
  num? userId,
}) => ContributeUserList(  avatar: avatar ?? _avatar,
  userId: userId ?? _userId,
);
  String? get avatar => _avatar;
  num? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['avatar'] = _avatar;
    map['userId'] = _userId;
    return map;
  }

}