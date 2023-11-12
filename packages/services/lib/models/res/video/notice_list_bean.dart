
import 'package:services/models/res/video/notice_content_bean.dart';

/// content : ""
/// id : 0
/// richText : ""

class NoticeListBean{
  NoticeListBean({
    String? content,
    num? id,
    String? richText,
    String? extraParam,
  }) {
    _content = content;
    _id = id;
    _richText = richText;
    _extraParam = extraParam;
  }

  NoticeListBean.fromJson(dynamic json) {
    _content = json['content'];
    _id = json['id'];
    _richText = json['richText'];
    _extraParam = json['extraParam'];
  }

  String? _content;
  num? _id;
  String? _richText;
  String? _extraParam;

  NoticeListBean copyWith({
    String? content,
    num? id,
    String? richText,
    String? extraParam,
  }) =>
      NoticeListBean(
        content: content ?? _content,
        id: id ?? _id,
        richText: richText ?? _richText,
        extraParam: extraParam ?? _extraParam,
      );

  String? get content => _content;

  num? get id => _id;

  String? get richText => _richText;

  String? get extraParam => _extraParam;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['content'] = _content;
    map['id'] = _id;
    map['richText'] = _richText;
    map['extraParam'] = _extraParam;
    return map;
  }
}