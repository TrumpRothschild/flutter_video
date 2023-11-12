import 'live_anchor_bean.dart';
import 'live_online_list_bean.dart';
import 'live_video_list_bean.dart';

/// barragePrice : 0
/// channelCode : ""
/// chargeType : 0
/// endTime : 0
/// firepower : 0
/// gameIcon : ""
/// gameId : 0
/// gameName : ""
/// guardNum : 0
/// isCharge : true
/// isProductUsable : 0
/// isRelateToy : true
/// isSelectGame : true
/// liveAnchorVO : {"accno":"","avatar":"","cardEnabled":true,"fansCount":0,"isFocus":true,"nickName":"","userAccount":"","userId":0,"userType":0}
/// lotteryId : 0
/// onlineList : [{"adminType":0,"avatar":"","countryCode":"","enterRoomTime":0,"level":0,"nickName":"","personalSignature":"","sex":0,"silver":0,"userAccount":"","userId":"","userType":0}]
/// onlineNum : 0
/// productBuyTime : 0
/// productId : 0
/// productLeftTime : 0
/// productPrice : 0
/// roomConfig : {"barrageLevel":0,"enterType":0,"focusPopuTime":0,"focusStayTime":0,"isOpenBarrage":true,"isQuitRoomShowFocus":true,"remainingTime":0,"speakLevel":0}
/// sharpness : ""
/// silverBeanUnit : ""
/// sportType : 0
/// startTime : 0
/// streamingOption : 0
/// studioId : 0
/// studioLivePath : ""
/// studioLivePathOrigin : 0
/// studioLiveSecPath : ""
/// studioNum : ""
/// studioStatus : 0
/// studioThumbImage : ""
/// studioType : 0
/// sysTime : 0
/// trySeeTime : 0
/// userId : 0
/// videoList : [{"duration":0,"id":0,"s1080pUrl":"","s360pUrl":"","s480pUrl":"","s720pUrl":"","secretKey":"","sourceId":0,"title":"","url":"","videoCodeRateVOList":[{"codeRate":"","codeRateDesc":"","url":""}]}]

class LiveRoomDetail {
  LiveRoomDetail({
      num? barragePrice, 
      String? channelCode, 
      num? chargeType, 
      num? endTime, 
      num? firepower, 
      String? gameIcon, 
      num? gameId, 
      String? gameName, 
      num? guardNum, 
      bool? isCharge, 
      num? isProductUsable, 
      bool? isRelateToy, 
      bool? isSelectGame,
    LiveAnchorBean? liveAnchorVO,
      num? lotteryId, 
      List<LiveOnlineListBean>? onlineList,
      num? onlineNum, 
      num? productBuyTime, 
      num? productId, 
      num? productLeftTime, 
      num? productPrice, 
      RoomConfig? roomConfig, 
      String? sharpness, 
      String? silverBeanUnit, 
      num? sportType, 
      num? startTime, 
      num? streamingOption, 
      num? studioId, 
      String? studioLivePath, 
      num? studioLivePathOrigin, 
      String? studioLiveSecPath, 
      String? studioNum, 
      num? studioStatus, 
      String? studioThumbImage, 
      num? studioType, 
      num? sysTime, 
      num? trySeeTime, 
      num? userId, 
      List<LiveVideoListBean>? videoList,}){
    _barragePrice = barragePrice;
    _channelCode = channelCode;
    _chargeType = chargeType;
    _endTime = endTime;
    _firepower = firepower;
    _gameIcon = gameIcon;
    _gameId = gameId;
    _gameName = gameName;
    _guardNum = guardNum;
    _isCharge = isCharge;
    _isProductUsable = isProductUsable;
    _isRelateToy = isRelateToy;
    _isSelectGame = isSelectGame;
    _liveAnchorVO = liveAnchorVO;
    _lotteryId = lotteryId;
    _onlineList = onlineList;
    _onlineNum = onlineNum;
    _productBuyTime = productBuyTime;
    _productId = productId;
    _productLeftTime = productLeftTime;
    _productPrice = productPrice;
    _roomConfig = roomConfig;
    _sharpness = sharpness;
    _silverBeanUnit = silverBeanUnit;
    _sportType = sportType;
    _startTime = startTime;
    _streamingOption = streamingOption;
    _studioId = studioId;
    _studioLivePath = studioLivePath;
    _studioLivePathOrigin = studioLivePathOrigin;
    _studioLiveSecPath = studioLiveSecPath;
    _studioNum = studioNum;
    _studioStatus = studioStatus;
    _studioThumbImage = studioThumbImage;
    _studioType = studioType;
    _sysTime = sysTime;
    _trySeeTime = trySeeTime;
    _userId = userId;
    _videoList = videoList;
}

  LiveRoomDetail.fromJson(dynamic json) {
    _barragePrice = json['barragePrice'];
    _channelCode = json['channelCode'];
    _chargeType = json['chargeType'];
    _endTime = json['endTime'];
    _firepower = json['firepower'];
    _gameIcon = json['gameIcon'];
    _gameId = json['gameId'];
    _gameName = json['gameName'];
    _guardNum = json['guardNum'];
    _isCharge = json['isCharge'];
    _isProductUsable = json['isProductUsable'];
    _isRelateToy = json['isRelateToy'];
    _isSelectGame = json['isSelectGame'];
    _liveAnchorVO = json['liveAnchorVO'] != null ? LiveAnchorBean.fromJson(json['liveAnchorVO']) : null;
    _lotteryId = json['lotteryId'];
    if (json['onlineList'] != null) {
      _onlineList = [];
      json['onlineList'].forEach((v) {
        _onlineList?.add(LiveOnlineListBean.fromJson(v));
      });
    }
    _onlineNum = json['onlineNum'];
    _productBuyTime = json['productBuyTime'];
    _productId = json['productId'];
    _productLeftTime = json['productLeftTime'];
    _productPrice = json['productPrice'];
    _roomConfig = json['roomConfig'] != null ? RoomConfig.fromJson(json['roomConfig']) : null;
    _sharpness = json['sharpness'];
    _silverBeanUnit = json['silverBeanUnit'];
    _sportType = json['sportType'];
    _startTime = json['startTime'];
    _streamingOption = json['streamingOption'];
    _studioId = json['studioId'];
    _studioLivePath = json['studioLivePath'];
    _studioLivePathOrigin = json['studioLivePathOrigin'];
    _studioLiveSecPath = json['studioLiveSecPath'];
    _studioNum = json['studioNum'];
    _studioStatus = json['studioStatus'];
    _studioThumbImage = json['studioThumbImage'];
    _studioType = json['studioType'];
    _sysTime = json['sysTime'];
    _trySeeTime = json['trySeeTime'];
    _userId = json['userId'];
    if (json['videoList'] != null) {
      _videoList = [];
      json['videoList'].forEach((v) {
        _videoList?.add(LiveVideoListBean.fromJson(v));
      });
    }
  }
  num? _barragePrice;
  String? _channelCode;
  num? _chargeType;
  num? _endTime;
  num? _firepower;
  String? _gameIcon;
  num? _gameId;
  String? _gameName;
  num? _guardNum;
  bool? _isCharge;
  num? _isProductUsable;
  bool? _isRelateToy;
  bool? _isSelectGame;
  LiveAnchorBean? _liveAnchorVO;
  num? _lotteryId;
  List<LiveOnlineListBean>? _onlineList;
  num? _onlineNum;
  num? _productBuyTime;
  num? _productId;
  num? _productLeftTime;
  num? _productPrice;
  RoomConfig? _roomConfig;
  String? _sharpness;
  String? _silverBeanUnit;
  num? _sportType;
  num? _startTime;
  num? _streamingOption;
  num? _studioId;
  String? _studioLivePath;
  num? _studioLivePathOrigin;
  String? _studioLiveSecPath;
  String? _studioNum;
  num? _studioStatus;
  String? _studioThumbImage;
  num? _studioType;
  num? _sysTime;
  num? _trySeeTime;
  num? _userId;
  List<LiveVideoListBean>? _videoList;
LiveRoomDetail copyWith({  num? barragePrice,
  String? channelCode,
  num? chargeType,
  num? endTime,
  num? firepower,
  String? gameIcon,
  num? gameId,
  String? gameName,
  num? guardNum,
  bool? isCharge,
  num? isProductUsable,
  bool? isRelateToy,
  bool? isSelectGame,
  LiveAnchorBean? liveAnchorVO,
  num? lotteryId,
  List<LiveOnlineListBean>? onlineList,
  num? onlineNum,
  num? productBuyTime,
  num? productId,
  num? productLeftTime,
  num? productPrice,
  RoomConfig? roomConfig,
  String? sharpness,
  String? silverBeanUnit,
  num? sportType,
  num? startTime,
  num? streamingOption,
  num? studioId,
  String? studioLivePath,
  num? studioLivePathOrigin,
  String? studioLiveSecPath,
  String? studioNum,
  num? studioStatus,
  String? studioThumbImage,
  num? studioType,
  num? sysTime,
  num? trySeeTime,
  num? userId,
  List<LiveVideoListBean>? videoList,
}) => LiveRoomDetail(  barragePrice: barragePrice ?? _barragePrice,
  channelCode: channelCode ?? _channelCode,
  chargeType: chargeType ?? _chargeType,
  endTime: endTime ?? _endTime,
  firepower: firepower ?? _firepower,
  gameIcon: gameIcon ?? _gameIcon,
  gameId: gameId ?? _gameId,
  gameName: gameName ?? _gameName,
  guardNum: guardNum ?? _guardNum,
  isCharge: isCharge ?? _isCharge,
  isProductUsable: isProductUsable ?? _isProductUsable,
  isRelateToy: isRelateToy ?? _isRelateToy,
  isSelectGame: isSelectGame ?? _isSelectGame,
  liveAnchorVO: liveAnchorVO ?? _liveAnchorVO,
  lotteryId: lotteryId ?? _lotteryId,
  onlineList: onlineList ?? _onlineList,
  onlineNum: onlineNum ?? _onlineNum,
  productBuyTime: productBuyTime ?? _productBuyTime,
  productId: productId ?? _productId,
  productLeftTime: productLeftTime ?? _productLeftTime,
  productPrice: productPrice ?? _productPrice,
  roomConfig: roomConfig ?? _roomConfig,
  sharpness: sharpness ?? _sharpness,
  silverBeanUnit: silverBeanUnit ?? _silverBeanUnit,
  sportType: sportType ?? _sportType,
  startTime: startTime ?? _startTime,
  streamingOption: streamingOption ?? _streamingOption,
  studioId: studioId ?? _studioId,
  studioLivePath: studioLivePath ?? _studioLivePath,
  studioLivePathOrigin: studioLivePathOrigin ?? _studioLivePathOrigin,
  studioLiveSecPath: studioLiveSecPath ?? _studioLiveSecPath,
  studioNum: studioNum ?? _studioNum,
  studioStatus: studioStatus ?? _studioStatus,
  studioThumbImage: studioThumbImage ?? _studioThumbImage,
  studioType: studioType ?? _studioType,
  sysTime: sysTime ?? _sysTime,
  trySeeTime: trySeeTime ?? _trySeeTime,
  userId: userId ?? _userId,
  videoList: videoList ?? _videoList,
);
  num? get barragePrice => _barragePrice;
  String? get channelCode => _channelCode;
  num? get chargeType => _chargeType;
  num? get endTime => _endTime;
  num? get firepower => _firepower;
  String? get gameIcon => _gameIcon;
  num? get gameId => _gameId;
  String? get gameName => _gameName;
  num? get guardNum => _guardNum;
  bool? get isCharge => _isCharge;
  num? get isProductUsable => _isProductUsable;
  bool? get isRelateToy => _isRelateToy;
  bool? get isSelectGame => _isSelectGame;
  LiveAnchorBean? get liveAnchorVO => _liveAnchorVO;
  num? get lotteryId => _lotteryId;
  List<LiveOnlineListBean>? get onlineList => _onlineList;
  num? get onlineNum => _onlineNum;
  num? get productBuyTime => _productBuyTime;
  num? get productId => _productId;
  num? get productLeftTime => _productLeftTime;
  num? get productPrice => _productPrice;
  RoomConfig? get roomConfig => _roomConfig;
  String? get sharpness => _sharpness;
  String? get silverBeanUnit => _silverBeanUnit;
  num? get sportType => _sportType;
  num? get startTime => _startTime;
  num? get streamingOption => _streamingOption;
  num? get studioId => _studioId;
  String? get studioLivePath => _studioLivePath;
  num? get studioLivePathOrigin => _studioLivePathOrigin;
  String? get studioLiveSecPath => _studioLiveSecPath;
  String? get studioNum => _studioNum;
  num? get studioStatus => _studioStatus;
  String? get studioThumbImage => _studioThumbImage;
  num? get studioType => _studioType;
  num? get sysTime => _sysTime;
  num? get trySeeTime => _trySeeTime;
  num? get userId => _userId;
  List<LiveVideoListBean>? get videoList => _videoList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['barragePrice'] = _barragePrice;
    map['channelCode'] = _channelCode;
    map['chargeType'] = _chargeType;
    map['endTime'] = _endTime;
    map['firepower'] = _firepower;
    map['gameIcon'] = _gameIcon;
    map['gameId'] = _gameId;
    map['gameName'] = _gameName;
    map['guardNum'] = _guardNum;
    map['isCharge'] = _isCharge;
    map['isProductUsable'] = _isProductUsable;
    map['isRelateToy'] = _isRelateToy;
    map['isSelectGame'] = _isSelectGame;
    if (_liveAnchorVO != null) {
      map['liveAnchorVO'] = _liveAnchorVO?.toJson();
    }
    map['lotteryId'] = _lotteryId;
    if (_onlineList != null) {
      map['onlineList'] = _onlineList?.map((v) => v.toJson()).toList();
    }
    map['onlineNum'] = _onlineNum;
    map['productBuyTime'] = _productBuyTime;
    map['productId'] = _productId;
    map['productLeftTime'] = _productLeftTime;
    map['productPrice'] = _productPrice;
    if (_roomConfig != null) {
      map['roomConfig'] = _roomConfig?.toJson();
    }
    map['sharpness'] = _sharpness;
    map['silverBeanUnit'] = _silverBeanUnit;
    map['sportType'] = _sportType;
    map['startTime'] = _startTime;
    map['streamingOption'] = _streamingOption;
    map['studioId'] = _studioId;
    map['studioLivePath'] = _studioLivePath;
    map['studioLivePathOrigin'] = _studioLivePathOrigin;
    map['studioLiveSecPath'] = _studioLiveSecPath;
    map['studioNum'] = _studioNum;
    map['studioStatus'] = _studioStatus;
    map['studioThumbImage'] = _studioThumbImage;
    map['studioType'] = _studioType;
    map['sysTime'] = _sysTime;
    map['trySeeTime'] = _trySeeTime;
    map['userId'] = _userId;
    if (_videoList != null) {
      map['videoList'] = _videoList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


/// barrageLevel : 0
/// enterType : 0
/// focusPopuTime : 0
/// focusStayTime : 0
/// isOpenBarrage : true
/// isQuitRoomShowFocus : true
/// remainingTime : 0
/// speakLevel : 0

class RoomConfig {
  RoomConfig({
      num? barrageLevel, 
      num? enterType, 
      num? focusPopuTime, 
      num? focusStayTime, 
      bool? isOpenBarrage, 
      bool? isQuitRoomShowFocus, 
      num? remainingTime, 
      num? speakLevel,}){
    _barrageLevel = barrageLevel;
    _enterType = enterType;
    _focusPopuTime = focusPopuTime;
    _focusStayTime = focusStayTime;
    _isOpenBarrage = isOpenBarrage;
    _isQuitRoomShowFocus = isQuitRoomShowFocus;
    _remainingTime = remainingTime;
    _speakLevel = speakLevel;
}

  RoomConfig.fromJson(dynamic json) {
    _barrageLevel = json['barrageLevel'];
    _enterType = json['enterType'];
    _focusPopuTime = json['focusPopuTime'];
    _focusStayTime = json['focusStayTime'];
    _isOpenBarrage = json['isOpenBarrage'];
    _isQuitRoomShowFocus = json['isQuitRoomShowFocus'];
    _remainingTime = json['remainingTime'];
    _speakLevel = json['speakLevel'];
  }
  num? _barrageLevel;
  num? _enterType;
  num? _focusPopuTime;
  num? _focusStayTime;
  bool? _isOpenBarrage;
  bool? _isQuitRoomShowFocus;
  num? _remainingTime;
  num? _speakLevel;
RoomConfig copyWith({  num? barrageLevel,
  num? enterType,
  num? focusPopuTime,
  num? focusStayTime,
  bool? isOpenBarrage,
  bool? isQuitRoomShowFocus,
  num? remainingTime,
  num? speakLevel,
}) => RoomConfig(  barrageLevel: barrageLevel ?? _barrageLevel,
  enterType: enterType ?? _enterType,
  focusPopuTime: focusPopuTime ?? _focusPopuTime,
  focusStayTime: focusStayTime ?? _focusStayTime,
  isOpenBarrage: isOpenBarrage ?? _isOpenBarrage,
  isQuitRoomShowFocus: isQuitRoomShowFocus ?? _isQuitRoomShowFocus,
  remainingTime: remainingTime ?? _remainingTime,
  speakLevel: speakLevel ?? _speakLevel,
);
  num? get barrageLevel => _barrageLevel;
  num? get enterType => _enterType;
  num? get focusPopuTime => _focusPopuTime;
  num? get focusStayTime => _focusStayTime;
  bool? get isOpenBarrage => _isOpenBarrage;
  bool? get isQuitRoomShowFocus => _isQuitRoomShowFocus;
  num? get remainingTime => _remainingTime;
  num? get speakLevel => _speakLevel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['barrageLevel'] = _barrageLevel;
    map['enterType'] = _enterType;
    map['focusPopuTime'] = _focusPopuTime;
    map['focusStayTime'] = _focusStayTime;
    map['isOpenBarrage'] = _isOpenBarrage;
    map['isQuitRoomShowFocus'] = _isQuitRoomShowFocus;
    map['remainingTime'] = _remainingTime;
    map['speakLevel'] = _speakLevel;
    return map;
  }

}
