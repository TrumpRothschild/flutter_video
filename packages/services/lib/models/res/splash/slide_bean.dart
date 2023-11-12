/// advImg : "https://img.91momo50.vip/picture/2023/01/24/1785257961136122560.w.png?auth_key=1676208052971-a89e3153c86f44e9a209a5c1c0911b5b-0-8025a3db271daab86739d2e81dc7e81b"
/// slideType : null
/// showTime : 3

class SlideBean {
  SlideBean({
      String? advImg, 
      dynamic slideType,
      String? link,
      num? showTime,}){
    _advImg = advImg;
    _slideType = slideType;
    _link = link;
    _showTime = showTime;
}

  SlideBean.fromJson(dynamic json) {
    _advImg = json['advImg'];
    _slideType = json['slideType'];
    _link = json['link'];
    _showTime = json['showTime'];
  }
  String? _advImg;
  dynamic _slideType;
  String? _link;
  num? _showTime;
SlideBean copyWith({  String? advImg,
  dynamic slideType,
  String? link,
  num? showTime,
}) => SlideBean(  advImg: advImg ?? _advImg,
  slideType: slideType ?? _slideType,
  link: link ?? _link,
  showTime: showTime ?? _showTime,
);
  String? get advImg => _advImg;
  dynamic get slideType => _slideType;
  String? get link => _link;
  num? get showTime => _showTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['advImg'] = _advImg;
    map['slideType'] = _slideType;
    map['link'] = _link;
    map['showTime'] = _showTime;
    return map;
  }

}