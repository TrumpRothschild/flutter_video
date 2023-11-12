/// id : 500
/// acctoken : "c9aceaf97ccad50c656f22ef61eee135"
/// registerCountryCode : "zh_CN"
/// 用户信息bean
class LoginBean {
  LoginBean({
      int? id,
      String? acctoken, 
      String? registerCountryCode,}){
    _id = id;
    _acctoken = acctoken;
    _registerCountryCode = registerCountryCode;
}

  LoginBean.fromJson(dynamic json) {
    _id = json['id'];
    _acctoken = json['acctoken'];
    _registerCountryCode = json['registerCountryCode'];
  }
  int? _id;
  String? _acctoken;
  String? _registerCountryCode;
LoginBean copyWith({  int? id,
  String? acctoken,
  String? registerCountryCode,
}) => LoginBean(  id: id ?? _id,
  acctoken: acctoken ?? _acctoken,
  registerCountryCode: registerCountryCode ?? _registerCountryCode,
);
  int? get id => _id;
  String? get acctoken => _acctoken;
  String? get registerCountryCode => _registerCountryCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['acctoken'] = _acctoken;
    map['registerCountryCode'] = _registerCountryCode;
    return map;
  }

}