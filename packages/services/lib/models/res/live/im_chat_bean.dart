/// avatar : "https://storage.haihcoudata.top/live/others/2022/11/18/avatar1.png"
/// level : 1
/// msgContent : "yuhh"
/// nickName : "小酒窝_6NYT"
/// userId : "1735"

class ImChatBean {
  ImChatBean({
      String? avatar, 
      num? level, 
      String? msgContent, 
      String? nickName, 
      String? userId,}){
    _avatar = avatar;
    _level = level;
    _msgContent = msgContent;
    _nickName = nickName;
    _userId = userId;
}

  ImChatBean.fromJson(dynamic json) {
    _avatar = json['avatar'];
    _level = json['level'];
    _msgContent = json['msgContent'];
    _nickName = json['nickName'];
    _userId = json['userId'];
  }
  String? _avatar;
  num? _level;
  String? _msgContent;
  String? _nickName;
  String? _userId;
ImChatBean copyWith({  String? avatar,
  num? level,
  String? msgContent,
  String? nickName,
  String? userId,
}) => ImChatBean(  avatar: avatar ?? _avatar,
  level: level ?? _level,
  msgContent: msgContent ?? _msgContent,
  nickName: nickName ?? _nickName,
  userId: userId ?? _userId,
);
  String? get avatar => _avatar;
  num? get level => _level;
  String? get msgContent => _msgContent;
  String? get nickName => _nickName;
  String? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['avatar'] = _avatar;
    map['level'] = _level;
    map['msgContent'] = _msgContent;
    map['nickName'] = _nickName;
    map['userId'] = _userId;
    return map;
  }

}