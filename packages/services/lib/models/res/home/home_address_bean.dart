/// code : ""
/// id : 0
/// name : ""
/// provinces : [{"code":"","id":0,"name":""}]

class HomeAddressBean {
  HomeAddressBean({
      String? code, 
      num? id, 
      String? name, 
      List<Provinces>? provinces,}){
    _code = code;
    _id = id;
    _name = name;
    _provinces = provinces;
}

  HomeAddressBean.fromJson(dynamic json) {
    _code = json['code'];
    _id = json['id'];
    _name = json['name'];
    if (json['provinces'] != null) {
      _provinces = [];
      json['provinces'].forEach((v) {
        _provinces?.add(Provinces.fromJson(v));
      });
    }
  }
  String? _code;
  num? _id;
  String? _name;
  List<Provinces>? _provinces;
HomeAddressBean copyWith({  String? code,
  num? id,
  String? name,
  List<Provinces>? provinces,
}) => HomeAddressBean(  code: code ?? _code,
  id: id ?? _id,
  name: name ?? _name,
  provinces: provinces ?? _provinces,
);
  String? get code => _code;
  num? get id => _id;
  String? get name => _name;
  List<Provinces>? get provinces => _provinces;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['id'] = _id;
    map['name'] = _name;
    if (_provinces != null) {
      map['provinces'] = _provinces?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// code : ""
/// id : 0
/// name : ""

class Provinces {
  Provinces({
      String? code, 
      num? id, 
      String? name,}){
    _code = code;
    _id = id;
    _name = name;
}

  Provinces.fromJson(dynamic json) {
    _code = json['code'];
    _id = json['id'];
    _name = json['name'];
  }
  String? _code;
  num? _id;
  String? _name;
Provinces copyWith({  String? code,
  num? id,
  String? name,
}) => Provinces(  code: code ?? _code,
  id: id ?? _id,
  name: name ?? _name,
);
  String? get code => _code;
  num? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}