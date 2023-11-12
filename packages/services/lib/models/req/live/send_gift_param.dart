/// giftComboId : ""
/// giftId : 0
/// giftNumber : 0
/// hostId : 0
/// isComboEnd : true

class SendGiftParam {
  SendGiftParam({
      String? giftComboId, 
      num? giftId, 
      num? giftNumber, 
      num? hostId, 
      bool? isComboEnd,}){
    _giftComboId = giftComboId;
    _giftId = giftId;
    _giftNumber = giftNumber;
    _hostId = hostId;
    _isComboEnd = isComboEnd;
}

  SendGiftParam.fromJson(dynamic json) {
    _giftComboId = json['giftComboId'];
    _giftId = json['giftId'];
    _giftNumber = json['giftNumber'];
    _hostId = json['hostId'];
    _isComboEnd = json['isComboEnd'];
  }
  String? _giftComboId;
  num? _giftId;
  num? _giftNumber;
  num? _hostId;
  bool? _isComboEnd;
SendGiftParam copyWith({  String? giftComboId,
  num? giftId,
  num? giftNumber,
  num? hostId,
  bool? isComboEnd,
}) => SendGiftParam(  giftComboId: giftComboId ?? _giftComboId,
  giftId: giftId ?? _giftId,
  giftNumber: giftNumber ?? _giftNumber,
  hostId: hostId ?? _hostId,
  isComboEnd: isComboEnd ?? _isComboEnd,
);
  String? get giftComboId => _giftComboId;
  num? get giftId => _giftId;
  num? get giftNumber => _giftNumber;
  num? get hostId => _hostId;
  bool? get isComboEnd => _isComboEnd;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['giftComboId'] = _giftComboId;
    map['giftId'] = _giftId;
    map['giftNumber'] = _giftNumber;
    map['hostId'] = _hostId;
    map['isComboEnd'] = _isComboEnd;
    return map;
  }

}