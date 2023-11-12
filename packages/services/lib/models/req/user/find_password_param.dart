/// areaCode : ""
/// mobilePhone : ""
/// password : ""
/// smsCode : ""
/// type : 0
/// 找回密码参数
class FindPasswordParam {
  FindPasswordParam({
      String? areaCode, 
      String? mobilePhone, 
      String? password, 
      String? smsCode,
  //操作类型 1：登录业务，2：支付业务
      int? type,}){
    _areaCode = areaCode;
    _mobilePhone = mobilePhone;
    _password = password;
    _smsCode = smsCode;
    _type = type;
}

  FindPasswordParam.fromJson(dynamic json) {
    _areaCode = json['areaCode'];
    _mobilePhone = json['mobilePhone'];
    _password = json['password'];
    _smsCode = json['smsCode'];
    _type = json['type'];
  }
  String? _areaCode;
  String? _mobilePhone;
  String? _password;
  String? _smsCode;
  int? _type;
FindPasswordParam copyWith({  String? areaCode,
  String? mobilePhone,
  String? password,
  String? smsCode,
  int? type,
}) => FindPasswordParam(  areaCode: areaCode ?? _areaCode,
  mobilePhone: mobilePhone ?? _mobilePhone,
  password: password ?? _password,
  smsCode: smsCode ?? _smsCode,
  type: type ?? _type,
);
  String? get areaCode => _areaCode;
  String? get mobilePhone => _mobilePhone;
  String? get password => _password;
  String? get smsCode => _smsCode;
  int? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['areaCode'] = _areaCode;
    map['mobilePhone'] = _mobilePhone;
    map['password'] = _password;
    map['smsCode'] = _smsCode;
    map['type'] = _type;
    return map;
  }

}