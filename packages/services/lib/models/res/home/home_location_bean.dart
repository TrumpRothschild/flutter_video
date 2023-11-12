/// countryCode : ""
/// countryName : ""
/// provinceCode : ""
/// provinceName : ""

class HomeLocationBean {
  HomeLocationBean({
      String? countryCode, 
      String? countryName, 
      String? provinceCode, 
      String? provinceName,}){
    _countryCode = countryCode;
    _countryName = countryName;
    _provinceCode = provinceCode;
    _provinceName = provinceName;
}

  HomeLocationBean.fromJson(dynamic json) {
    _countryCode = json['countryCode'];
    _countryName = json['countryName'];
    _provinceCode = json['provinceCode'];
    _provinceName = json['provinceName'];
  }
  String? _countryCode;
  String? _countryName;
  String? _provinceCode;
  String? _provinceName;
HomeLocationBean copyWith({  String? countryCode,
  String? countryName,
  String? provinceCode,
  String? provinceName,
}) => HomeLocationBean(  countryCode: countryCode ?? _countryCode,
  countryName: countryName ?? _countryName,
  provinceCode: provinceCode ?? _provinceCode,
  provinceName: provinceName ?? _provinceName,
);
  String? get countryCode => _countryCode;
  String? get countryName => _countryName;
  String? get provinceCode => _provinceCode;
  String? get provinceName => _provinceName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['countryCode'] = _countryCode;
    map['countryName'] = _countryName;
    map['provinceCode'] = _provinceCode;
    map['provinceName'] = _provinceName;
    return map;
  }

}