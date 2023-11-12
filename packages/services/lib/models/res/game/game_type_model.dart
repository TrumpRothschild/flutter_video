/// id : 1
/// name : "百人牛牛"
/// image : ""
/// type : "NN"

class GameTypeModel {
  GameTypeModel({
    this.id,
    this.name,
    this.image,
    this.type,
  });

  GameTypeModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    type = json['type'];
  }

  int? id;
  String? name;
  String? image;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['type'] = type;
    return map;
  }
}
