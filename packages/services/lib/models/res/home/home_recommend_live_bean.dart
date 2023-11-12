import 'home_live_bean.dart';

/// list : [{"anchorId":0,"chargeType":0,"cityName":"","colour":0,"columnCode":"","countryCode":"","countryName":"","gameId":0,"gameName":"","isCharge":true,"isLightYearRecommend":true,"isRelateToy":true,"onlineNum":0,"price":0,"provinceCode":"","provinceName":"","roomDetail":{"barragePrice":0,"channelCode":"","chargeType":0,"endTime":0,"firepower":0,"gameIcon":"","gameId":0,"gameName":"","guardNum":0,"isCharge":true,"isProductUsable":0,"isRelateToy":true,"isSelectGame":true,"liveAnchorVO":{"accno":"","avatar":"","cardEnabled":true,"fansCount":0,"isFocus":true,"nickName":"","userAccount":"","userId":0,"userType":0},"lotteryId":0,"onlineList":[{"adminType":0,"avatar":"","countryCode":"","enterRoomTime":0,"level":0,"nickName":"","personalSignature":"","sex":0,"silver":0,"userAccount":"","userId":"","userType":0}],"onlineNum":0,"productBuyTime":0,"productId":0,"productLeftTime":0,"productPrice":0,"roomConfig":{"barrageLevel":0,"enterType":0,"focusPopuTime":0,"focusStayTime":0,"isOpenBarrage":true,"isQuitRoomShowFocus":true,"remainingTime":0,"speakLevel":0},"silverBeanUnit":"","sportType":0,"startTime":0,"streamingOption":0,"studioId":0,"studioLivePath":"","studioLivePathOrigin":0,"studioLiveSecPath":"","studioNum":"","studioStatus":0,"studioThumbImage":"","studioType":0,"sysTime":0,"trySeeTime":0,"userId":0,"videoList":[{"duration":0,"id":0,"s1080pUrl":"","s360pUrl":"","s480pUrl":"","s720pUrl":"","secretKey":"","sourceId":0,"title":"","url":"","videoCodeRateVOList":[{"codeRate":"","codeRateDesc":"","url":""}]}]},"sharpness":"","startTime":"","studioBackground":"","studioHeat":0,"studioId":0,"studioNum":"","studioStatus":0,"studioThumbImage":"","studioTitle":"","studioType":0,"toyBluetoothStatus":0,"trySeeTime":0,"userId":0,"weightsNum":0}]
/// searchTime : 0

class HomeRecommendLiveBean {
  HomeRecommendLiveBean({
    List<HomeLiveBean>? list,
    num searchTime = 0,
  }) {
    _list = list;
    _searchTime = searchTime;
  }

  HomeRecommendLiveBean.fromJson(dynamic json) {
    if (json['list'] != null) {
      _list = [];
      json['list'].forEach((v) {
        _list?.add(HomeLiveBean.fromJson(v));
      });
    }
    _searchTime = json['searchTime'];
  }

  List<HomeLiveBean>? _list;
  num _searchTime = 0;

  HomeRecommendLiveBean copyWith({
    List<HomeLiveBean>? list,
    num searchTime = 0,
  }) =>
      HomeRecommendLiveBean(
        list: list ?? _list,
        searchTime: searchTime,
      );

  List<HomeLiveBean>? get list => _list;

  num get searchTime => _searchTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_list != null) {
      map['list'] = _list?.map((v) => v.toJson()).toList();
    }
    map['searchTime'] = _searchTime;
    return map;
  }
}
