/// des : ""
/// logo : ""
/// value : ""

class SimpleBankModel {
  SimpleBankModel({
    this.des,
    this.logo,
    this.value,
  });

  SimpleBankModel.fromJson(dynamic json) {
    des = json['des'];
    logo = json['logo'];
    value = json['value'];
  }

  String? des;
  String? logo;
  String? value;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['des'] = des;
    map['logo'] = logo;
    map['value'] = value;
    return map;
  }
}
