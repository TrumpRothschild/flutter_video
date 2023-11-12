/// columnCode : ""
/// columnName : ""

class GameSlideData {
  int? id;
  String? advName;
  String? advImg;
  String? skipModel;
  String? skipUrl;
  int? type;


  GameSlideData(
      {this.id,
        this.advName,
        this.advImg,
        this.skipModel,
        this.skipUrl,
        this.type});

  GameSlideData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advName = json['advName'];
    advImg = json['advImg'];
    skipModel = json['skipModel'];
    skipUrl = json['skipUrl'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['advName'] = this.advName;
    data['advImg'] = this.advImg;
    data['skipModel'] = this.skipModel;
    data['skipUrl'] = this.skipUrl;
    data['type'] = this.type;
    return data;
  }
}