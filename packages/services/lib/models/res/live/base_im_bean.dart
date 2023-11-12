/// body : {"chatType":2,"content":"xxx","operatorType":0,"sendTime":"1678204820492"}
/// code : 0
/// isReceive : false
/// receiptTime : 0
/// sendTime : 1678204820492

class BaseImBean {
  BaseImBean({
      Body? body, 
      num? code, 
      bool? isReceive, 
      num? receiptTime, 
      num? sendTime,}){
    _body = body;
    _code = code;
    _isReceive = isReceive;
    _receiptTime = receiptTime;
    _sendTime = sendTime;
}

  BaseImBean.fromJson(dynamic json) {
    _body = json['body'] != null ? Body.fromJson(json['body']) : null;
    _code = json['code'];
    _isReceive = json['isReceive'];
    _receiptTime = json['receiptTime'];
    _sendTime = json['sendTime'];
  }
  Body? _body;
  num? _code;
  bool? _isReceive;
  num? _receiptTime;
  num? _sendTime;
BaseImBean copyWith({  Body? body,
  num? code,
  bool? isReceive,
  num? receiptTime,
  num? sendTime,
}) => BaseImBean(  body: body ?? _body,
  code: code ?? _code,
  isReceive: isReceive ?? _isReceive,
  receiptTime: receiptTime ?? _receiptTime,
  sendTime: sendTime ?? _sendTime,
);
  Body? get body => _body;
  num? get code => _code;
  bool? get isReceive => _isReceive;
  num? get receiptTime => _receiptTime;
  num? get sendTime => _sendTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_body != null) {
      map['body'] = _body?.toJson();
    }
    map['code'] = _code;
    map['isReceive'] = _isReceive;
    map['receiptTime'] = _receiptTime;
    map['sendTime'] = _sendTime;
    return map;
  }

}

/// chatType : 2
/// content : "xxx"
/// operatorType : 0
/// sendTime : "1678204820492"

class Body {
  Body({
      num? chatType, 
      String? content, 
      num? operatorType, 
      String? sendTime,}){
    _chatType = chatType;
    _content = content;
    _operatorType = operatorType;
    _sendTime = sendTime;
}

  Body.fromJson(dynamic json) {
    _chatType = json['chatType'];
    _content = json['content'];
    _operatorType = json['operatorType'];
    _sendTime = json['sendTime'];
  }
  num? _chatType;
  String? _content;
  num? _operatorType;
  String? _sendTime;
Body copyWith({  num? chatType,
  String? content,
  num? operatorType,
  String? sendTime,
}) => Body(  chatType: chatType ?? _chatType,
  content: content ?? _content,
  operatorType: operatorType ?? _operatorType,
  sendTime: sendTime ?? _sendTime,
);
  num? get chatType => _chatType;
  String? get content => _content;
  num? get operatorType => _operatorType;
  String? get sendTime => _sendTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['chatType'] = _chatType;
    map['content'] = _content;
    map['operatorType'] = _operatorType;
    map['sendTime'] = _sendTime;
    return map;
  }

}