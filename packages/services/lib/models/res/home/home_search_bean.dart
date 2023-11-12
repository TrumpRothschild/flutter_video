import 'home_live_bean.dart';

/// anchorList : [{"accno":"","avatar":"","countryCode":"","id":0,"isAuthor":true,"nickName":"","remark":"","sex":0,"studioNum":"","userLevel":""}]
/// studioList : [{"anchorId":0,"chargeType":0,"cityName":"","colour":0,"columnCode":"","countryCode":"","countryName":"","gameId":0,"gameName":"","isCharge":true,"isLightYearRecommend":true,"isRelateToy":true,"onlineNum":0,"price":0,"provinceCode":"","provinceName":"","roomDetail":{"barragePrice":0,"channelCode":"","chargeType":0,"endTime":0,"firepower":0,"gameIcon":"","gameId":0,"gameName":"","guardNum":0,"isCharge":true,"isProductUsable":0,"isRelateToy":true,"isSelectGame":true,"liveAnchorVO":{"accno":"","avatar":"","cardEnabled":true,"fansCount":0,"isFocus":true,"nickName":"","userAccount":"","userId":0,"userType":0},"lotteryId":0,"onlineList":[{"adminType":0,"avatar":"","countryCode":"","enterRoomTime":0,"level":0,"nickName":"","personalSignature":"","sex":0,"silver":0,"userAccount":"","userId":"","userType":0}],"onlineNum":0,"productBuyTime":0,"productId":0,"productLeftTime":0,"productPrice":0,"roomConfig":{"barrageLevel":0,"enterType":0,"focusPopuTime":0,"focusStayTime":0,"isOpenBarrage":true,"isQuitRoomShowFocus":true,"remainingTime":0,"speakLevel":0},"sharpness":"","silverBeanUnit":"","sportType":0,"startTime":0,"streamingOption":0,"studioId":0,"studioLivePath":"","studioLivePathOrigin":0,"studioLiveSecPath":"","studioNum":"","studioStatus":0,"studioThumbImage":"","studioType":0,"sysTime":0,"trySeeTime":0,"userId":0,"videoList":[{"duration":0,"id":0,"s1080pUrl":"","s360pUrl":"","s480pUrl":"","s720pUrl":"","secretKey":"","sourceId":0,"title":"","url":"","videoCodeRateVOList":[{"codeRate":"","codeRateDesc":"","url":""}]}]},"sharpness":"","startTime":"","studioBackground":"","studioHeat":0,"studioId":0,"studioNum":"","studioStatus":0,"studioThumbImage":"","studioTitle":"","studioType":0,"toyBluetoothStatus":0,"trySeeTime":0,"userId":0,"weightsNum":0}]

class HomeSearchBean {
  HomeSearchBean({
      List<AnchorList>? anchorList, 
      List<HomeLiveBean>? studioList,}){
    _anchorList = anchorList;
    _studioList = studioList;
}

  HomeSearchBean.fromJson(dynamic json) {
    if (json['anchorList'] != null) {
      _anchorList = [];
      json['anchorList'].forEach((v) {
        _anchorList?.add(AnchorList.fromJson(v));
      });
    }
    if (json['studioList'] != null) {
      _studioList = [];
      json['studioList'].forEach((v) {
        _studioList?.add(HomeLiveBean.fromJson(v));
      });
    }
  }
  List<AnchorList>? _anchorList;
  List<HomeLiveBean>? _studioList;
HomeSearchBean copyWith({  List<AnchorList>? anchorList,
  List<HomeLiveBean>? studioList,
}) => HomeSearchBean(  anchorList: anchorList ?? _anchorList,
  studioList: studioList ?? _studioList,
);
  List<AnchorList>? get anchorList => _anchorList;
  List<HomeLiveBean>? get studioList => _studioList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_anchorList != null) {
      map['anchorList'] = _anchorList?.map((v) => v.toJson()).toList();
    }
    if (_studioList != null) {
      map['studioList'] = _studioList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
/// accno : ""
/// avatar : ""
/// countryCode : ""
/// id : 0
/// isAuthor : true
/// nickName : ""
/// remark : ""
/// sex : 0
/// studioNum : ""
/// userLevel : ""

class AnchorList {
  AnchorList({
      String? accno, 
      String? avatar, 
      String? countryCode, 
      num? id, 
      bool? isAuthor, 
      String? nickName, 
      String? remark, 
      num? sex,
      String? studioNum, 
      String? userLevel,}){
    _accno = accno;
    _avatar = avatar;
    _countryCode = countryCode;
    _id = id;
    _isAuthor = isAuthor;
    _nickName = nickName;
    _remark = remark;
    _sex = sex;
    _studioNum = studioNum;
    _userLevel = userLevel;
}

  AnchorList.fromJson(dynamic json) {
    _accno = json['accno'];
    _avatar = json['avatar'];
    _countryCode = json['countryCode'];
    _id = json['id'];
    _isAuthor = json['isAuthor'];
    _nickName = json['nickName'];
    _remark = json['remark'];
    _sex = json['sex'];
    _studioNum = json['studioNum'];
    _userLevel = json['userLevel'];
  }
  String? _accno;
  String? _avatar;
  String? _countryCode;
  num? _id;
  bool? _isAuthor;
  String? _nickName;
  String? _remark;
  num? _sex;
  String? _studioNum;
  String? _userLevel;
AnchorList copyWith({  String? accno,
  String? avatar,
  String? countryCode,
  num? id,
  bool? isAuthor,
  String? nickName,
  String? remark,
  num? sex,
  String? studioNum,
  String? userLevel,
}) => AnchorList(  accno: accno ?? _accno,
  avatar: avatar ?? _avatar,
  countryCode: countryCode ?? _countryCode,
  id: id ?? _id,
  isAuthor: isAuthor ?? _isAuthor,
  nickName: nickName ?? _nickName,
  remark: remark ?? _remark,
  sex: sex ?? _sex,
  studioNum: studioNum ?? _studioNum,
  userLevel: userLevel ?? _userLevel,
);
  String? get accno => _accno;
  String? get avatar => _avatar;
  String? get countryCode => _countryCode;
  num? get id => _id;
  bool? get isAuthor => _isAuthor;
  String? get nickName => _nickName;
  String? get remark => _remark;
  num? get sex => _sex;
  String? get studioNum => _studioNum;
  String? get userLevel => _userLevel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accno'] = _accno;
    map['avatar'] = _avatar;
    map['countryCode'] = _countryCode;
    map['id'] = _id;
    map['isAuthor'] = _isAuthor;
    map['nickName'] = _nickName;
    map['remark'] = _remark;
    map['sex'] = _sex;
    map['studioNum'] = _studioNum;
    map['userLevel'] = _userLevel;
    return map;
  }

}