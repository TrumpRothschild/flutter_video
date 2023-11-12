/// amount : 0
/// balance : 0
/// giftComboId : ""
/// giftId : 0
/// giftNumber : 0
/// hostId : 0
/// silver : 0
/// studioNum : ""

class LiveSendGiftBean {
  LiveSendGiftBean({
      num? amount, 
      num? balance, 
      String? giftComboId, 
      num? giftId, 
      num? giftNumber, 
      num? hostId, 
      num? silver, 
      String? studioNum,}){
    _amount = amount;
    _balance = balance;
    _giftComboId = giftComboId;
    _giftId = giftId;
    _giftNumber = giftNumber;
    _hostId = hostId;
    _silver = silver;
    _studioNum = studioNum;
}

  LiveSendGiftBean.fromJson(dynamic json) {
    _amount = json['amount'];
    _balance = json['balance'];
    _giftComboId = json['giftComboId'];
    _giftId = json['giftId'];
    _giftNumber = json['giftNumber'];
    _hostId = json['hostId'];
    _silver = json['silver'];
    _studioNum = json['studioNum'];
  }
  num? _amount;
  num? _balance;
  String? _giftComboId;
  num? _giftId;
  num? _giftNumber;
  num? _hostId;
  num? _silver;
  String? _studioNum;
LiveSendGiftBean copyWith({  num? amount,
  num? balance,
  String? giftComboId,
  num? giftId,
  num? giftNumber,
  num? hostId,
  num? silver,
  String? studioNum,
}) => LiveSendGiftBean(  amount: amount ?? _amount,
  balance: balance ?? _balance,
  giftComboId: giftComboId ?? _giftComboId,
  giftId: giftId ?? _giftId,
  giftNumber: giftNumber ?? _giftNumber,
  hostId: hostId ?? _hostId,
  silver: silver ?? _silver,
  studioNum: studioNum ?? _studioNum,
);
  num? get amount => _amount;
  num? get balance => _balance;
  String? get giftComboId => _giftComboId;
  num? get giftId => _giftId;
  num? get giftNumber => _giftNumber;
  num? get hostId => _hostId;
  num? get silver => _silver;
  String? get studioNum => _studioNum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['amount'] = _amount;
    map['balance'] = _balance;
    map['giftComboId'] = _giftComboId;
    map['giftId'] = _giftId;
    map['giftNumber'] = _giftNumber;
    map['hostId'] = _hostId;
    map['silver'] = _silver;
    map['studioNum'] = _studioNum;
    return map;
  }

}