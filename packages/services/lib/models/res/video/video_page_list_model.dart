class VideoPageListModel {
  int? showTitleFlag;
  int? showMoreFlag;
  String? panelName;
  String? extraParams;
  int? id;
  List<ContentList>? contentList;

  VideoPageListModel(
      {this.showTitleFlag,
        this.showMoreFlag,
        this.panelName,
        this.extraParams,
        this.id,
        this.contentList});

  VideoPageListModel.fromJson(Map<String, dynamic> json) {
    showTitleFlag = json['showTitleFlag'];
    showMoreFlag = json['showMoreFlag'];
    panelName = json['panelName'];
    extraParams = json['extraParams'];
    id = json['id'];
    if (json['contentList'] != null) {
      contentList = <ContentList>[];
      json['contentList'].forEach((v) {
        contentList!.add(ContentList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['showTitleFlag'] = showTitleFlag;
    data['showMoreFlag'] = showMoreFlag;
    data['panelName'] = panelName;
    data['extraParams'] = extraParams;
    data['id'] = id;
    if (contentList != null) {
      data['contentList'] = contentList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContentList {
  int? bannerShowType;
  int? columnNum;
  int? refrenceId;
  int? refrenceType;
  BannerData? banner;
  List<BannerList>? bannerList;
  List<NoticeList>? noticeList;
  Video? video;

  ContentList(
      {this.bannerShowType,
        this.columnNum,
        this.refrenceId,
        this.refrenceType,
        this.banner,
        this.bannerList,
        this.noticeList,
        this.video});

  ContentList.fromJson(Map<String, dynamic> json) {
    bannerShowType = json['bannerShowType'];
    columnNum = json['columnNum'];
    refrenceId = json['refrenceId'];
    refrenceType = json['refrenceType'];
    banner =
    json['banner'] != null ? BannerData.fromJson(json['banner']) : null;
    if (json['bannerList'] != null) {
      bannerList = <BannerList>[];
      json['bannerList'].forEach((v) {
        bannerList!.add(new BannerList.fromJson(v));
      });
    }
    if (json['noticeList'] != null) {
      noticeList = <NoticeList>[];
      json['noticeList'].forEach((v) {
        noticeList!.add(new NoticeList.fromJson(v));
      });
    }
    video = json['video'] != null ? new Video.fromJson(json['video']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bannerShowType'] = this.bannerShowType;
    data['columnNum'] = this.columnNum;
    data['refrenceId'] = this.refrenceId;
    data['refrenceType'] = this.refrenceType;
    if (this.banner != null) {
      data['banner'] = this.banner!.toJson();
    }
    if (this.bannerList != null) {
      data['bannerList'] = this.bannerList!.map((v) => v.toJson()).toList();
    }
    if (this.noticeList != null) {
      data['noticeList'] = this.noticeList!.map((v) => v.toJson()).toList();
    }
    if (this.video != null) {
      data['video'] = this.video!.toJson();
    }
    return data;
  }
}
class BannerList {
  int? type;
  String? skipValue;
  int? skipModel;
  int? id;
  String? extraParams;
  String? bannerName;
  String? bannerImage;

  BannerList(
      {this.type,
        this.skipValue,
        this.skipModel,
        this.id,
        this.extraParams,
        this.bannerName,
        this.bannerImage});

  BannerList.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    skipValue = json['skipValue'];
    skipModel = json['skipModel'];
    id = json['id'];
    extraParams = json['extraParams'];
    bannerName = json['bannerName'];
    bannerImage = json['bannerImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['skipValue'] = this.skipValue;
    data['skipModel'] = this.skipModel;
    data['id'] = this.id;
    data['extraParams'] = this.extraParams;
    data['bannerName'] = this.bannerName;
    data['bannerImage'] = this.bannerImage;
    return data;
  }
}

class BannerData {
  int? type;
  String? skipValue;
  int? skipModel;
  int? id;
  String? extraParams;
  String? bannerName;
  String? bannerImage;

  BannerData(
      {this.type,
        this.skipValue,
        this.skipModel,
        this.id,
        this.extraParams,
        this.bannerName,
        this.bannerImage});

  BannerData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    skipValue = json['skipValue'];
    skipModel = json['skipModel'];
    id = json['id'];
    extraParams = json['extraParams'];
    bannerName = json['bannerName'];
    bannerImage = json['bannerImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['skipValue'] = this.skipValue;
    data['skipModel'] = this.skipModel;
    data['id'] = this.id;
    data['extraParams'] = this.extraParams;
    data['bannerName'] = this.bannerName;
    data['bannerImage'] = this.bannerImage;
    return data;
  }
}

class NoticeList {
  String? content;
  int? id;

  NoticeList({this.content, this.id});

  NoticeList.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['id'] = this.id;
    return data;
  }
}

class Video {
  String? cover;
  int? duration;
  int? videoId;
  int? likeNumber;
  int? priceType;
  String? tagList;
  String? title;
  bool?flag;
  int? offlineFlag;
  String? id;

  Video(
      {this.cover,
        this.duration,
        this.videoId,
        this.likeNumber,
        this.priceType,
        this.tagList,
        this.flag,
        this.title,
        this.offlineFlag,
        this.id});

  Video.fromJson(Map<String, dynamic> json) {
    cover = json['cover'];
    duration = json['duration'];
    videoId = json['videoId'];
    likeNumber = json['likeNumber'];
    priceType = json['priceType'];
    tagList = json['tagList'];
    title = json['title'];
    flag = json['flag'];
    offlineFlag = json['offlineFlag'];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cover'] = this.cover;
    data['duration'] = this.duration;
    data['videoId'] = this.videoId;
    data['likeNumber'] = this.likeNumber;
    data['priceType'] = this.priceType;
    data['tagList'] = this.tagList;
    data['title'] = this.title;
    data['flag'] = this.flag;
    data['offlineFlag'] = this.offlineFlag;
    data['id'] = this.id;
    return data;
  }
}
