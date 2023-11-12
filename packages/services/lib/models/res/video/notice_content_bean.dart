
import 'dart:convert';

/// 视频公告附件
class NoticeContentBean{
  NoticeContentBean({
    String? gameType,
    String? type,
    String? keyword,
    String? categoryId,
  }) {
    _gameType = gameType;
    _type = type;
    _keyword = keyword;
    _categoryId = categoryId;
  }

  NoticeContentBean.fromJson(String text) {
    var json = const JsonCodec().decode(text);
    _gameType = json['gameType'];
    _type = json['type'];
    _keyword = json['keyword'];
    _categoryId = json['categoryId'];
  }

  String? _gameType;
  String? _type;
  String? _keyword;
  String? _categoryId;

  NoticeContentBean copyWith({
    String? gameType,
    String? type,
    String? keyword,
    String? categoryId,
  }) =>
      NoticeContentBean(
        gameType: gameType ?? _gameType,
        type: type ?? _type,
        keyword: keyword ?? _keyword,
        categoryId: categoryId ?? _categoryId,
      );

  String? get gameType => _gameType;

  String? get type => _type;

  String? get keyword => _keyword;

  String? get categoryId => _categoryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['gameType'] = _gameType;
    map['type'] = _type;
    map['keyword'] = _keyword;
    map['categoryId'] = _categoryId;
    return map;
  }
}