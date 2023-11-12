/// noticeContent : ""
/// noticeName : ""
/// type : 0

class NoticeBean {
  NoticeBean({
      String? noticeContent, 
      String? noticeName, 
      num? type,}){
    //公告内容
    _noticeContent = noticeContent;
    //公告名称
    _noticeName = noticeName;
    //公告类型 1直播间公告 2开场公告 3循环公告 4首页公告 5推荐栏目跑马灯公告 6游戏列表跑马灯公告 7兑换钻石公告 8充值中心
    _type = type;
}

  NoticeBean.fromJson(dynamic json) {
    _noticeContent = json['noticeContent'];
    _noticeName = json['noticeName'];
    _type = json['type'];
  }
  String? _noticeContent;
  String? _noticeName;
  num? _type;
NoticeBean copyWith({  String? noticeContent,
  String? noticeName,
  num? type,
}) => NoticeBean(  noticeContent: noticeContent ?? _noticeContent,
  noticeName: noticeName ?? _noticeName,
  type: type ?? _type,
);
  String? get noticeContent => _noticeContent;
  String? get noticeName => _noticeName;
  num? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['noticeContent'] = _noticeContent;
    map['noticeName'] = _noticeName;
    map['type'] = _type;
    return map;
  }

}