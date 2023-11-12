
/// accno : ""
/// avatar : ""
/// cardEnabled : true
/// fansCount : 0
/// isFocus : true
/// nickName : ""
/// userAccount : ""
/// userId : 0
/// userType : 0

class LiveAnchorBean {
  LiveAnchorBean({
    String? accno,
    String? avatar,
    bool? cardEnabled,
    num? fansCount,
    bool isFocus=false,
    String? nickName,
    String? userAccount,
    num? userId,
    num? userType,}){
    _accno = accno;
    _avatar = avatar;
    _cardEnabled = cardEnabled;
    _fansCount = fansCount;
    _isFocus = isFocus;
    _nickName = nickName;
    _userAccount = userAccount;
    _userId = userId;
    _userType = userType;
  }

  LiveAnchorBean.fromJson(dynamic json) {
    _accno = json['accno'];
    _avatar = json['avatar'];
    _cardEnabled = json['cardEnabled'];
    _fansCount = json['fansCount'];
    _isFocus = json['isFocus'];
    _nickName = json['nickName'];
    _userAccount = json['userAccount'];
    _userId = json['userId'];
    _userType = json['userType'];
  }
  String? _accno;
  String? _avatar;
  bool? _cardEnabled;
  num? _fansCount;
  bool _isFocus=false;
  String? _nickName;
  String? _userAccount;
  num? _userId;
  num? _userType;
  LiveAnchorBean copyWith({  String? accno,
    String? avatar,
    bool? cardEnabled,
    num? fansCount,
    bool? isFocus,
    String? nickName,
    String? userAccount,
    num? userId,
    num? userType,
  }) => LiveAnchorBean(  accno: accno ?? _accno,
    avatar: avatar ?? _avatar,
    cardEnabled: cardEnabled ?? _cardEnabled,
    fansCount: fansCount ?? _fansCount,
    isFocus: isFocus ?? _isFocus,
    nickName: nickName ?? _nickName,
    userAccount: userAccount ?? _userAccount,
    userId: userId ?? _userId,
    userType: userType ?? _userType,
  );
  String? get accno => _accno;
  String? get avatar => _avatar;
  bool? get cardEnabled => _cardEnabled;
  num? get fansCount => _fansCount;
  bool get isFocus => _isFocus;
  String? get nickName => _nickName;
  String? get userAccount => _userAccount;
  num? get userId => _userId;
  num? get userType => _userType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accno'] = _accno;
    map['avatar'] = _avatar;
    map['cardEnabled'] = _cardEnabled;
    map['fansCount'] = _fansCount;
    map['isFocus'] = _isFocus;
    map['nickName'] = _nickName;
    map['userAccount'] = _userAccount;
    map['userId'] = _userId;
    map['userType'] = _userType;
    return map;
  }

}