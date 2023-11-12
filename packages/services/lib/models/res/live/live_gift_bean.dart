/// dynamicImage : ""
/// dynamicShowType : 0
/// fontColor : ""
/// frequencyVibration : 0
/// giftComboId : ""
/// giftComboNumb : 0
/// giftId : 0
/// giftName : ""
/// giftNumber : 0
/// giftShow : ""
/// giftType : 0
/// imageUrl : ""
/// isBarrage : true
/// isDivideAnchor : true
/// isDoubleHit : true
/// isDynamic : true
/// isGiftBig : true
/// isRelateToy : true
/// lang : ""
/// price : 0
/// useCountry : ""
/// vibrationTime : 0

class LiveGiftBean {
  LiveGiftBean({
      String? dynamicImage, 
      num? dynamicShowType, 
      String? fontColor, 
      num? frequencyVibration, 
      String? giftComboId, 
      num? giftComboNumb, 
      num? giftId, 
      String? giftName, 
      num? giftNumber, 
      String? giftShow, 
      num? giftType, 
      String? imageUrl, 
      bool? isBarrage, 
      bool? isDivideAnchor, 
      bool? isDoubleHit, 
      bool? isDynamic, 
      bool? isGiftBig, 
      bool? isRelateToy, 
      String? lang, 
      num? price, 
      String? useCountry, 
      num? vibrationTime,}){
    _dynamicImage = dynamicImage;
    _dynamicShowType = dynamicShowType;
    _fontColor = fontColor;
    _frequencyVibration = frequencyVibration;
    _giftComboId = giftComboId;
    _giftComboNumb = giftComboNumb;
    _giftId = giftId;
    _giftName = giftName;
    _giftNumber = giftNumber;
    _giftShow = giftShow;
    _giftType = giftType;
    _imageUrl = imageUrl;
    _isBarrage = isBarrage;
    _isDivideAnchor = isDivideAnchor;
    _isDoubleHit = isDoubleHit;
    _isDynamic = isDynamic;
    _isGiftBig = isGiftBig;
    _isRelateToy = isRelateToy;
    _lang = lang;
    _price = price;
    _useCountry = useCountry;
    _vibrationTime = vibrationTime;
}

  LiveGiftBean.fromJson(dynamic json) {
    _dynamicImage = json['dynamicImage'];
    _dynamicShowType = json['dynamicShowType'];
    _fontColor = json['fontColor'];
    _frequencyVibration = json['frequencyVibration'];
    _giftComboId = json['giftComboId'];
    _giftComboNumb = json['giftComboNumb'];
    _giftId = json['giftId'];
    _giftName = json['giftName'];
    _giftNumber = json['giftNumber'];
    _giftShow = json['giftShow'];
    _giftType = json['giftType'];
    _imageUrl = json['imageUrl'];
    _isBarrage = json['isBarrage'];
    _isDivideAnchor = json['isDivideAnchor'];
    _isDoubleHit = json['isDoubleHit'];
    _isDynamic = json['isDynamic'];
    _isGiftBig = json['isGiftBig'];
    _isRelateToy = json['isRelateToy'];
    _lang = json['lang'];
    _price = json['price'];
    _useCountry = json['useCountry'];
    _vibrationTime = json['vibrationTime'];
  }
  String? _dynamicImage;
  num? _dynamicShowType;
  String? _fontColor;
  num? _frequencyVibration;
  String? _giftComboId;
  num? _giftComboNumb;
  num? _giftId;
  String? _giftName;
  num? _giftNumber;
  String? _giftShow;
  num? _giftType;
  String? _imageUrl;
  bool? _isBarrage;
  bool? _isDivideAnchor;
  bool? _isDoubleHit;
  bool? _isDynamic;
  bool? _isGiftBig;
  bool? _isRelateToy;
  String? _lang;
  num? _price;
  String? _useCountry;
  num? _vibrationTime;
LiveGiftBean copyWith({  String? dynamicImage,
  num? dynamicShowType,
  String? fontColor,
  num? frequencyVibration,
  String? giftComboId,
  num? giftComboNumb,
  num? giftId,
  String? giftName,
  num? giftNumber,
  String? giftShow,
  num? giftType,
  String? imageUrl,
  bool? isBarrage,
  bool? isDivideAnchor,
  bool? isDoubleHit,
  bool? isDynamic,
  bool? isGiftBig,
  bool? isRelateToy,
  String? lang,
  num? price,
  String? useCountry,
  num? vibrationTime,
}) => LiveGiftBean(  dynamicImage: dynamicImage ?? _dynamicImage,
  dynamicShowType: dynamicShowType ?? _dynamicShowType,
  fontColor: fontColor ?? _fontColor,
  frequencyVibration: frequencyVibration ?? _frequencyVibration,
  giftComboId: giftComboId ?? _giftComboId,
  giftComboNumb: giftComboNumb ?? _giftComboNumb,
  giftId: giftId ?? _giftId,
  giftName: giftName ?? _giftName,
  giftNumber: giftNumber ?? _giftNumber,
  giftShow: giftShow ?? _giftShow,
  giftType: giftType ?? _giftType,
  imageUrl: imageUrl ?? _imageUrl,
  isBarrage: isBarrage ?? _isBarrage,
  isDivideAnchor: isDivideAnchor ?? _isDivideAnchor,
  isDoubleHit: isDoubleHit ?? _isDoubleHit,
  isDynamic: isDynamic ?? _isDynamic,
  isGiftBig: isGiftBig ?? _isGiftBig,
  isRelateToy: isRelateToy ?? _isRelateToy,
  lang: lang ?? _lang,
  price: price ?? _price,
  useCountry: useCountry ?? _useCountry,
  vibrationTime: vibrationTime ?? _vibrationTime,
);
  String? get dynamicImage => _dynamicImage;
  num? get dynamicShowType => _dynamicShowType;
  String? get fontColor => _fontColor;
  num? get frequencyVibration => _frequencyVibration;
  String? get giftComboId => _giftComboId;
  num? get giftComboNumb => _giftComboNumb;
  num? get giftId => _giftId;
  String? get giftName => _giftName;
  num? get giftNumber => _giftNumber;
  String? get giftShow => _giftShow;
  num? get giftType => _giftType;
  String? get imageUrl => _imageUrl;
  bool? get isBarrage => _isBarrage;
  bool? get isDivideAnchor => _isDivideAnchor;
  bool? get isDoubleHit => _isDoubleHit;
  bool? get isDynamic => _isDynamic;
  bool? get isGiftBig => _isGiftBig;
  bool? get isRelateToy => _isRelateToy;
  String? get lang => _lang;
  num? get price => _price;
  String? get useCountry => _useCountry;
  num? get vibrationTime => _vibrationTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dynamicImage'] = _dynamicImage;
    map['dynamicShowType'] = _dynamicShowType;
    map['fontColor'] = _fontColor;
    map['frequencyVibration'] = _frequencyVibration;
    map['giftComboId'] = _giftComboId;
    map['giftComboNumb'] = _giftComboNumb;
    map['giftId'] = _giftId;
    map['giftName'] = _giftName;
    map['giftNumber'] = _giftNumber;
    map['giftShow'] = _giftShow;
    map['giftType'] = _giftType;
    map['imageUrl'] = _imageUrl;
    map['isBarrage'] = _isBarrage;
    map['isDivideAnchor'] = _isDivideAnchor;
    map['isDoubleHit'] = _isDoubleHit;
    map['isDynamic'] = _isDynamic;
    map['isGiftBig'] = _isGiftBig;
    map['isRelateToy'] = _isRelateToy;
    map['lang'] = _lang;
    map['price'] = _price;
    map['useCountry'] = _useCountry;
    map['vibrationTime'] = _vibrationTime;
    return map;
  }

}