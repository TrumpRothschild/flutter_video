class GameTabModel {
  GameTabModel({
    this.name,
    this.code,
  });

  GameTabModel.fromJson(dynamic json) {
    name = json['name'];
    code = json['code'];
  }

  String? name;
  String? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['code'] = code;
    return map;
  }
}
