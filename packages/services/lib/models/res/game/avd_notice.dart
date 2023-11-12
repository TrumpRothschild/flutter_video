/// type : 6
/// noticeName : "欢迎光临【啪体直播】6：游戏列表路马灯公告"
/// noticeContent : "欢迎光临【啪体直播】，我们致力于让您时刻享受愉悦的娱乐直播和游戏体验。6：游戏列表路马灯公告"

class AvdNotice {
  AvdNotice({
      this.type, 
      this.noticeName, 
      this.noticeContent,});

  AvdNotice.fromJson(dynamic json) {
    type = json['type'];
    noticeName = json['noticeName'];
    noticeContent = json['noticeContent'];
  }
  int? type;
  String? noticeName;
  String? noticeContent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['noticeName'] = noticeName;
    map['noticeContent'] = noticeContent;
    return map;
  }

}