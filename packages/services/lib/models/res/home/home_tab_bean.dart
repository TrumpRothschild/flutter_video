/// columnCode : ""
/// columnName : ""

class HomeTabBean {
  HomeTabBean({
      String? columnCode, 
      String? columnName,}){
    _columnCode = columnCode;
    _columnName = columnName;
}

  HomeTabBean.fromJson(dynamic json) {
    _columnCode = json['columnCode'];
    _columnName = json['columnName'];
  }
  String? _columnCode;
  String? _columnName;
HomeTabBean copyWith({  String? columnCode,
  String? columnName,
}) => HomeTabBean(  columnCode: columnCode ?? _columnCode,
  columnName: columnName ?? _columnName,
);
  String? get columnCode => _columnCode;
  String? get columnName => _columnName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['columnCode'] = _columnCode;
    map['columnName'] = _columnName;
    return map;
  }

}