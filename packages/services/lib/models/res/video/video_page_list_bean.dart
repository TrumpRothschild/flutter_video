import 'dart:convert';

import 'banner_data_bean.dart';
import 'banner_list_bean.dart';
import 'notice_list_bean.dart';
import 'video_bean.dart';

/// banner : {"bannerImage":"","bannerName":"","extraParams":"","id":0,"skipModel":0,"skipValue":"","type":0}
/// bannerList : [{"bannerImage":"","bannerName":"","extraParams":"","id":0,"skipModel":0,"skipValue":"","type":0}]
/// bannerShowType : 0
/// columnNum : 0
/// noticeList : [{"content":"","id":0,"richText":""}]
/// panelInfo : {"extraParams":"","id":0,"panelName":"","showMoreFlag":0,"showTitleFlag":0,"sortNum":0}
/// refrenceType : 0
/// video : {"cover":"","duration":0,"id":"","likeNumber":0,"offlineFlag":0,"price":0,"priceType":0,"tagList":"","title":"","videoId":0}

///首页面板
class VideoPageListBean {
  VideoPageListBean({
    BannerDataBean? banner,
    List<BannerListBean>? bannerList,
    num? bannerShowType,
    num? columnNum,
    List<NoticeListBean>? noticeList,
    PanelInfo? panelInfo,
    num? refrenceType,
    VideoBean? video,
  }) {
    _banner = banner;
    _bannerList = bannerList;
    _bannerShowType = bannerShowType;
    _columnNum = columnNum;
    _noticeList = noticeList;
    _panelInfo = panelInfo;
    _refrenceType = refrenceType;
    _video = video;
  }

  VideoPageListBean.fromJson(dynamic json) {
    _banner =
        json['banner'] != null ? BannerDataBean.fromJson(json['banner']) : null;
    if (json['bannerList'] != null) {
      _bannerList = [];
      json['bannerList'].forEach((v) {
        _bannerList?.add(BannerListBean.fromJson(v));
      });
    }
    _bannerShowType = json['bannerShowType'];
    _columnNum = json['columnNum'];
    if (json['noticeList'] != null) {
      _noticeList = [];
      json['noticeList'].forEach((v) {
        _noticeList?.add(NoticeListBean.fromJson(v));
      });
    }
    _panelInfo = json['panelInfo'] != null
        ? PanelInfo.fromJson(json['panelInfo'])
        : null;
    _refrenceType = json['refrenceType'];
    _video = json['video'] != null ? VideoBean.fromJson(json['video']) : null;
  }

  BannerDataBean? _banner;
  List<BannerListBean>? _bannerList;
  num? _bannerShowType;
  num? _columnNum;
  List<NoticeListBean>? _noticeList;
  PanelInfo? _panelInfo;
  num? _refrenceType;
  VideoBean? _video;
  List<VideoBean> videos = [];

  VideoPageListBean copyWith({
    BannerDataBean? banner,
    List<BannerListBean>? bannerList,
    num? bannerShowType,
    num? columnNum,
    List<NoticeListBean>? noticeList,
    PanelInfo? panelInfo,
    num? refrenceType,
    VideoBean? video,
  }) =>
      VideoPageListBean(
        banner: banner ?? _banner,
        bannerList: bannerList ?? _bannerList,
        bannerShowType: bannerShowType ?? _bannerShowType,
        columnNum: columnNum ?? _columnNum,
        noticeList: noticeList ?? _noticeList,
        panelInfo: panelInfo ?? _panelInfo,
        refrenceType: refrenceType ?? _refrenceType,
        video: video ?? _video,
      );

  BannerDataBean? get banner => _banner;

  List<BannerListBean>? get bannerList => _bannerList;

  num? get bannerShowType => _bannerShowType;

  num? get columnNum => _columnNum;

  List<NoticeListBean>? get noticeList => _noticeList;

  PanelInfo? get panelInfo => _panelInfo;

  num? get refrenceType => _refrenceType;

  VideoBean? get video => _video;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_banner != null) {
      map['banner'] = _banner?.toJson();
    }
    if (_bannerList != null) {
      map['bannerList'] = _bannerList?.map((v) => v.toJson()).toList();
    }
    map['bannerShowType'] = _bannerShowType;
    map['columnNum'] = _columnNum;
    if (_noticeList != null) {
      map['noticeList'] = _noticeList?.map((v) => v.toJson()).toList();
    }
    if (_panelInfo != null) {
      map['panelInfo'] = _panelInfo?.toJson();
    }
    map['refrenceType'] = _refrenceType;
    if (_video != null) {
      map['video'] = _video?.toJson();
    }
    return map;
  }
}

/// extraParams : ""
/// id : 0
/// panelName : ""
/// showMoreFlag : 0
/// showTitleFlag : 0
/// sortNum : 0

class PanelInfo {
  PanelInfo({
    String? extraParams,
    num? id,
    String? panelName,
    int? showMoreFlag,
    int? showTitleFlag,
    int? sortNum,
  }) {
    _extraParams = extraParams;
    _id = id;
    _panelName = panelName;
    _showMoreFlag = showMoreFlag;
    _showTitleFlag = showTitleFlag;
    _sortNum = sortNum;
  }

  PanelInfo.fromJson(dynamic json) {
    _extraParams = json['extraParams'];
    _id = json['id'];
    _panelName = json['panelName'];
    _showMoreFlag = json['showMoreFlag'];
    _showTitleFlag = json['showTitleFlag'];
    _sortNum = json['sortNum'];
  }

  String? _extraParams;
  num? _id;
  String? _panelName;
  int? _showMoreFlag;
  int? _showTitleFlag;
  int? _sortNum;

  PanelInfo copyWith({
    String? extraParams,
    num? id,
    String? panelName,
    int? showMoreFlag,
    int? showTitleFlag,
    int? sortNum,
  }) =>
      PanelInfo(
        extraParams: extraParams ?? _extraParams,
        id: id ?? _id,
        panelName: panelName ?? _panelName,
        showMoreFlag: showMoreFlag ?? _showMoreFlag,
        showTitleFlag: showTitleFlag ?? _showTitleFlag,
        sortNum: sortNum ?? _sortNum,
      );

  String? get extraParams => _extraParams;

  int get sortType {
    if (_extraParams?.isEmpty ?? true) return 0;
    try {
      final extraJson = jsonDecode(_extraParams ?? '');
      return extraJson['sortType'] as int? ?? 0;
    } catch (e) {
      return 0;
    }
  }

  num? get id => _id;

  String? get panelName => _panelName;

  int? get showMoreFlag => _showMoreFlag;

  int? get showTitleFlag => _showTitleFlag;

  int? get sortNum => _sortNum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['extraParams'] = _extraParams;
    map['id'] = _id;
    map['panelName'] = _panelName;
    map['showMoreFlag'] = _showMoreFlag;
    map['showTitleFlag'] = _showTitleFlag;
    map['sortNum'] = _sortNum;
    return map;
  }
}
