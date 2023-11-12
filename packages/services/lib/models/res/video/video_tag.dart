import 'dart:convert';

class VideoTags {
  VideoTags({
    this.sortTags,
    this.dynamicTags,
  });

  List<VideoTag>? sortTags;
  List<VideoTag>? dynamicTags;

  VideoTags.fromJson(Map<String, dynamic> json) {
    if (json['sortTags'] != null) {
      sortTags = <VideoTag>[];
      //List list = jsonDecode(json['sortTags']);
      List list = json['sortTags']; // 不需要解析
      list.forEach((v) {
        sortTags!.add(VideoTag.fromJson(v));
      });
    }
    if (json['dynamicTags'] != null) {
      dynamicTags = <VideoTag>[];
      List list = json['dynamicTags'];
      list.forEach((v) {
        dynamicTags!.add(VideoTag.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sortTags != null) {
      data['sortTags'] = this.sortTags!.map((v) => v.toJson()).toList();
    }
    if (this.dynamicTags != null) {
      data['dynamicTags'] = this.dynamicTags!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VideoTag {
  VideoTag({
    this.id,
    this.label,
    this.checked,
  });

  int? id;
  String? label;
  bool? checked;

  VideoTag.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    label = json["label"];
    checked = json["checked"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['id'] = this.id;
    data['checked'] = this.checked;
    return data;
  }
}
