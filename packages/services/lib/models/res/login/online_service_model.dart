class OnlineServiceModel {
  String? context;
  String? lang;

  OnlineServiceModel({this.context, this.lang});

  OnlineServiceModel.fromJson(Map<String, dynamic> json) {
    context = json['context'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['context'] = this.context;
    data['lang'] = this.lang;
    return data;
  }
}
