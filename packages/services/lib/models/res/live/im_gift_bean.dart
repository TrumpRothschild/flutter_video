/// userId : "1362"
/// nickName : "安若汐_QFCA2"
/// avatar : "https://img.91momo50.vip/picture/2023/03/04/1799723723361637056.w.jpeg?auth_key=1678595306144-b4b8405f73f04196b53b5163f1a12ae7-0-4eebc9775d4fb194d2e3e0155630b9ea"
/// sex : null
/// area : ""
/// level : 9
/// levelName : "VIP9"
/// isTourists : true
/// giftTotal : null
/// liveGift : {"giftId":180,"liveGiftLangList":null,"lang":"zh_CN","giftName":"棒棒糖","price":3.0000,"useCountry":"zh_CN,zh_TW","imageUrl":"https://img.91momo50.vip/picture/2f5f85c0d1644d6d96b89d0ea8231f30.png?auth_key=1678595306144-48bff3ac23ba444b8967761dcfa9ed88-0-fe68fca0f6f86103bbf1fbe29d884016","fontColor":null,"dynamicImage":"https://img.91momo50.vip/picture/3182970cd8394216a3156634327116d9.svga?auth_key=1678595306144-923fc711f8d942cea9f83d10ed96b4b0-0-88083a6300277c9bc681b3081123b613","dynamicShowType":0,"giftShow":null,"isDynamic":false,"status":true,"sortNum":90,"isGiftBig":null,"isDivideAnchor":true,"giftType":4,"isDoubleHit":true,"isBarrage":true,"frequencyVibration":0,"vibrationTime":0.0,"isRelateToy":false,"giftComboId":"d570bcf2-6485-4e63-bac2-349f6e806779","giftComboNumb":null,"giftNumber":10}
/// anchorDetail : null

class ImGiftBean {
  ImGiftBean({
      String? userId, 
      String? nickName, 
      String? avatar, 
      dynamic sex, 
      String? area, 
      num? level, 
      String? levelName, 
      bool? isTourists, 
      dynamic giftTotal, 
      LiveGift? liveGift, 
      dynamic anchorDetail,}){
    _userId = userId;
    _nickName = nickName;
    _avatar = avatar;
    _sex = sex;
    _area = area;
    _level = level;
    _levelName = levelName;
    _isTourists = isTourists;
    _giftTotal = giftTotal;
    _liveGift = liveGift;
    _anchorDetail = anchorDetail;
}

  ImGiftBean.fromJson(dynamic json) {
    _userId = json['userId'];
    _nickName = json['nickName'];
    _avatar = json['avatar'];
    _sex = json['sex'];
    _area = json['area'];
    _level = json['level'];
    _levelName = json['levelName'];
    _isTourists = json['isTourists'];
    _giftTotal = json['giftTotal'];
    _liveGift = json['liveGift'] != null ? LiveGift.fromJson(json['liveGift']) : null;
    _anchorDetail = json['anchorDetail'];
  }
  String? _userId;
  String? _nickName;
  String? _avatar;
  dynamic _sex;
  String? _area;
  num? _level;
  String? _levelName;
  bool? _isTourists;
  dynamic _giftTotal;
  LiveGift? _liveGift;
  dynamic _anchorDetail;
ImGiftBean copyWith({  String? userId,
  String? nickName,
  String? avatar,
  dynamic sex,
  String? area,
  num? level,
  String? levelName,
  bool? isTourists,
  dynamic giftTotal,
  LiveGift? liveGift,
  dynamic anchorDetail,
}) => ImGiftBean(  userId: userId ?? _userId,
  nickName: nickName ?? _nickName,
  avatar: avatar ?? _avatar,
  sex: sex ?? _sex,
  area: area ?? _area,
  level: level ?? _level,
  levelName: levelName ?? _levelName,
  isTourists: isTourists ?? _isTourists,
  giftTotal: giftTotal ?? _giftTotal,
  liveGift: liveGift ?? _liveGift,
  anchorDetail: anchorDetail ?? _anchorDetail,
);
  String? get userId => _userId;
  String? get nickName => _nickName;
  String? get avatar => _avatar;
  dynamic get sex => _sex;
  String? get area => _area;
  num? get level => _level;
  String? get levelName => _levelName;
  bool? get isTourists => _isTourists;
  dynamic get giftTotal => _giftTotal;
  LiveGift? get liveGift => _liveGift;
  dynamic get anchorDetail => _anchorDetail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['nickName'] = _nickName;
    map['avatar'] = _avatar;
    map['sex'] = _sex;
    map['area'] = _area;
    map['level'] = _level;
    map['levelName'] = _levelName;
    map['isTourists'] = _isTourists;
    map['giftTotal'] = _giftTotal;
    if (_liveGift != null) {
      map['liveGift'] = _liveGift?.toJson();
    }
    map['anchorDetail'] = _anchorDetail;
    return map;
  }

}

/// giftId : 180
/// liveGiftLangList : null
/// lang : "zh_CN"
/// giftName : "棒棒糖"
/// price : 3.0000
/// useCountry : "zh_CN,zh_TW"
/// imageUrl : "https://img.91momo50.vip/picture/2f5f85c0d1644d6d96b89d0ea8231f30.png?auth_key=1678595306144-48bff3ac23ba444b8967761dcfa9ed88-0-fe68fca0f6f86103bbf1fbe29d884016"
/// fontColor : null
/// dynamicImage : "https://img.91momo50.vip/picture/3182970cd8394216a3156634327116d9.svga?auth_key=1678595306144-923fc711f8d942cea9f83d10ed96b4b0-0-88083a6300277c9bc681b3081123b613"
/// dynamicShowType : 0
/// giftShow : null
/// isDynamic : false
/// status : true
/// sortNum : 90
/// isGiftBig : null
/// isDivideAnchor : true
/// giftType : 4
/// isDoubleHit : true
/// isBarrage : true
/// frequencyVibration : 0
/// vibrationTime : 0.0
/// isRelateToy : false
/// giftComboId : "d570bcf2-6485-4e63-bac2-349f6e806779"
/// giftComboNumb : null
/// giftNumber : 10

class LiveGift {
  LiveGift({
      num? giftId, 
      dynamic liveGiftLangList, 
      String? lang, 
      String? giftName, 
      num? price, 
      String? useCountry, 
      String? imageUrl, 
      dynamic fontColor, 
      String? dynamicImage, 
      num? dynamicShowType, 
      dynamic giftShow, 
      bool? isDynamic, 
      bool? status, 
      num? sortNum, 
      dynamic isGiftBig, 
      bool? isDivideAnchor, 
      num? giftType, 
      bool? isDoubleHit, 
      bool? isBarrage, 
      num? frequencyVibration, 
      num? vibrationTime, 
      bool? isRelateToy, 
      String? giftComboId, 
      dynamic giftComboNumb, 
      num? giftNumber,}){
    _giftId = giftId;
    _liveGiftLangList = liveGiftLangList;
    _lang = lang;
    _giftName = giftName;
    _price = price;
    _useCountry = useCountry;
    _imageUrl = imageUrl;
    _fontColor = fontColor;
    _dynamicImage = dynamicImage;
    _dynamicShowType = dynamicShowType;
    _giftShow = giftShow;
    _isDynamic = isDynamic;
    _status = status;
    _sortNum = sortNum;
    _isGiftBig = isGiftBig;
    _isDivideAnchor = isDivideAnchor;
    _giftType = giftType;
    _isDoubleHit = isDoubleHit;
    _isBarrage = isBarrage;
    _frequencyVibration = frequencyVibration;
    _vibrationTime = vibrationTime;
    _isRelateToy = isRelateToy;
    _giftComboId = giftComboId;
    _giftComboNumb = giftComboNumb;
    _giftNumber = giftNumber;
}

  LiveGift.fromJson(dynamic json) {
    _giftId = json['giftId'];
    _liveGiftLangList = json['liveGiftLangList'];
    _lang = json['lang'];
    _giftName = json['giftName'];
    _price = json['price'];
    _useCountry = json['useCountry'];
    _imageUrl = json['imageUrl'];
    _fontColor = json['fontColor'];
    _dynamicImage = json['dynamicImage'];
    _dynamicShowType = json['dynamicShowType'];
    _giftShow = json['giftShow'];
    _isDynamic = json['isDynamic'];
    _status = json['status'];
    _sortNum = json['sortNum'];
    _isGiftBig = json['isGiftBig'];
    _isDivideAnchor = json['isDivideAnchor'];
    _giftType = json['giftType'];
    _isDoubleHit = json['isDoubleHit'];
    _isBarrage = json['isBarrage'];
    _frequencyVibration = json['frequencyVibration'];
    _vibrationTime = json['vibrationTime'];
    _isRelateToy = json['isRelateToy'];
    _giftComboId = json['giftComboId'];
    _giftComboNumb = json['giftComboNumb'];
    _giftNumber = json['giftNumber'];
  }
  num? _giftId;
  dynamic _liveGiftLangList;
  String? _lang;
  String? _giftName;
  num? _price;
  String? _useCountry;
  String? _imageUrl;
  dynamic _fontColor;
  String? _dynamicImage;
  num? _dynamicShowType;
  dynamic _giftShow;
  bool? _isDynamic;
  bool? _status;
  num? _sortNum;
  dynamic _isGiftBig;
  bool? _isDivideAnchor;
  num? _giftType;
  bool? _isDoubleHit;
  bool? _isBarrage;
  num? _frequencyVibration;
  num? _vibrationTime;
  bool? _isRelateToy;
  String? _giftComboId;
  dynamic _giftComboNumb;
  num? _giftNumber;
LiveGift copyWith({  num? giftId,
  dynamic liveGiftLangList,
  String? lang,
  String? giftName,
  num? price,
  String? useCountry,
  String? imageUrl,
  dynamic fontColor,
  String? dynamicImage,
  num? dynamicShowType,
  dynamic giftShow,
  bool? isDynamic,
  bool? status,
  num? sortNum,
  dynamic isGiftBig,
  bool? isDivideAnchor,
  num? giftType,
  bool? isDoubleHit,
  bool? isBarrage,
  num? frequencyVibration,
  num? vibrationTime,
  bool? isRelateToy,
  String? giftComboId,
  dynamic giftComboNumb,
  num? giftNumber,
}) => LiveGift(  giftId: giftId ?? _giftId,
  liveGiftLangList: liveGiftLangList ?? _liveGiftLangList,
  lang: lang ?? _lang,
  giftName: giftName ?? _giftName,
  price: price ?? _price,
  useCountry: useCountry ?? _useCountry,
  imageUrl: imageUrl ?? _imageUrl,
  fontColor: fontColor ?? _fontColor,
  dynamicImage: dynamicImage ?? _dynamicImage,
  dynamicShowType: dynamicShowType ?? _dynamicShowType,
  giftShow: giftShow ?? _giftShow,
  isDynamic: isDynamic ?? _isDynamic,
  status: status ?? _status,
  sortNum: sortNum ?? _sortNum,
  isGiftBig: isGiftBig ?? _isGiftBig,
  isDivideAnchor: isDivideAnchor ?? _isDivideAnchor,
  giftType: giftType ?? _giftType,
  isDoubleHit: isDoubleHit ?? _isDoubleHit,
  isBarrage: isBarrage ?? _isBarrage,
  frequencyVibration: frequencyVibration ?? _frequencyVibration,
  vibrationTime: vibrationTime ?? _vibrationTime,
  isRelateToy: isRelateToy ?? _isRelateToy,
  giftComboId: giftComboId ?? _giftComboId,
  giftComboNumb: giftComboNumb ?? _giftComboNumb,
  giftNumber: giftNumber ?? _giftNumber,
);
  num? get giftId => _giftId;
  dynamic get liveGiftLangList => _liveGiftLangList;
  String? get lang => _lang;
  String? get giftName => _giftName;
  num? get price => _price;
  String? get useCountry => _useCountry;
  String? get imageUrl => _imageUrl;
  dynamic get fontColor => _fontColor;
  String? get dynamicImage => _dynamicImage;
  num? get dynamicShowType => _dynamicShowType;
  dynamic get giftShow => _giftShow;
  bool? get isDynamic => _isDynamic;
  bool? get status => _status;
  num? get sortNum => _sortNum;
  dynamic get isGiftBig => _isGiftBig;
  bool? get isDivideAnchor => _isDivideAnchor;
  num? get giftType => _giftType;
  bool? get isDoubleHit => _isDoubleHit;
  bool? get isBarrage => _isBarrage;
  num? get frequencyVibration => _frequencyVibration;
  num? get vibrationTime => _vibrationTime;
  bool? get isRelateToy => _isRelateToy;
  String? get giftComboId => _giftComboId;
  dynamic get giftComboNumb => _giftComboNumb;
  num? get giftNumber => _giftNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['giftId'] = _giftId;
    map['liveGiftLangList'] = _liveGiftLangList;
    map['lang'] = _lang;
    map['giftName'] = _giftName;
    map['price'] = _price;
    map['useCountry'] = _useCountry;
    map['imageUrl'] = _imageUrl;
    map['fontColor'] = _fontColor;
    map['dynamicImage'] = _dynamicImage;
    map['dynamicShowType'] = _dynamicShowType;
    map['giftShow'] = _giftShow;
    map['isDynamic'] = _isDynamic;
    map['status'] = _status;
    map['sortNum'] = _sortNum;
    map['isGiftBig'] = _isGiftBig;
    map['isDivideAnchor'] = _isDivideAnchor;
    map['giftType'] = _giftType;
    map['isDoubleHit'] = _isDoubleHit;
    map['isBarrage'] = _isBarrage;
    map['frequencyVibration'] = _frequencyVibration;
    map['vibrationTime'] = _vibrationTime;
    map['isRelateToy'] = _isRelateToy;
    map['giftComboId'] = _giftComboId;
    map['giftComboNumb'] = _giftComboNumb;
    map['giftNumber'] = _giftNumber;
    return map;
  }

}