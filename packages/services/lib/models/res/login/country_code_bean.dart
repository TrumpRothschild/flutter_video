/// name : "中国"
/// countryCode : "zh_CN"
/// areaCode : "0086"
/// lang : "zh_CN"

class CountryCodeBean {
  CountryCodeBean({
    String? name,
    String? countryCode,
    String? areaCode,
    String? lang,
    bool? checked,
  }) {
    _name = name;
    _countryCode = countryCode;
    _areaCode = areaCode;
    _lang = lang;
    _checked = checked;
  }

  CountryCodeBean.fromJson(dynamic json) {
    _name = json['name'];
    _countryCode = json['countryCode'];
    _areaCode = json['areaCode'];
    _lang = json['lang'];
  }

  String? _name;
  String? _countryCode;
  String? _areaCode;
  String? _lang;
  bool? _checked;

  CountryCodeBean copyWith({
    String? name,
    String? countryCode,
    String? areaCode,
    String? lang,
    bool? checked,
  }) =>
      CountryCodeBean(
        name: name ?? _name,
        countryCode: countryCode ?? _countryCode,
        areaCode: areaCode ?? _areaCode,
        lang: lang ?? _lang,
        checked: checked ?? _checked,
      );

  String? get name => _name;

  String? get countryCode => _countryCode;

  String get areaCode => _areaCode?.replaceAll("00", "+") ?? "";

  String? get lang => _lang;

  bool get checked => _checked ?? false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['countryCode'] = _countryCode;
    map['areaCode'] = _areaCode;
    map['lang'] = _lang;
    return map;
  }
}
