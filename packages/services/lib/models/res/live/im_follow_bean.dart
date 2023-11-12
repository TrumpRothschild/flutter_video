/// toUserNickName : "操作者"
/// foUserNickName : "被操作者"
class ImFollowBean {
  ImFollowBean({
      String? toUserNickName, 
      String? foUserNickName,}){
    _toUserNickName = toUserNickName;
    _foUserNickName = foUserNickName;
}

  ImFollowBean.fromJson(dynamic json) {
    _toUserNickName = json['toUserNickName'];
    _foUserNickName = json['foUserNickName'];
  }
  String? _toUserNickName;
  String? _foUserNickName;
ImFollowBean copyWith({  String? toUserNickName,
  String? foUserNickName,
}) => ImFollowBean(  toUserNickName: toUserNickName ?? _toUserNickName,
  foUserNickName: foUserNickName ?? _foUserNickName,
);
  String? get toUserNickName => _toUserNickName;
  String? get foUserNickName => _foUserNickName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['toUserNickName'] = _toUserNickName;
    map['foUserNickName'] = _foUserNickName;
    return map;
  }

}