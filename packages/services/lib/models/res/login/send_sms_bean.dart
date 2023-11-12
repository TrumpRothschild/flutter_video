/// countDown : 0

class SendSmsBean {
  SendSmsBean({
      num? countDown,}){
    _countDown = countDown;
}

  SendSmsBean.fromJson(dynamic json) {
    _countDown = json['countDown'];
  }
  num? _countDown;
SendSmsBean copyWith({  num? countDown,
}) => SendSmsBean(  countDown: countDown ?? _countDown,
);
  num? get countDown => _countDown;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['countDown'] = _countDown;
    return map;
  }

}