class VideoDetailModel {
  String? authorAvatar;
  int? authorId;
  String? authorName;
  int? commentNumber;
  String? cover;
  String? createTime;
  String? discountPrice;
  int? duration;
  int? id;
  String? intro;
  bool? likeFlag;
  int? likeNumber;
  String? linkAddress;
  int? playNumber;
  String? price;
  int? priceType;
  List<ResolutionRatios>? resolutionRatios;
  String? tagList;
  String? title;

  VideoDetailModel(
      {this.authorAvatar,
        this.authorId,
        this.authorName,
        this.commentNumber,
        this.cover,
        this.createTime,
        this.discountPrice,
        this.duration,
        this.id,
        this.intro,
        this.likeFlag,
        this.likeNumber,
        this.linkAddress,
        this.playNumber,
        this.price,
        this.priceType,
        this.resolutionRatios,
        this.tagList,
        this.title});

  VideoDetailModel.fromJson(Map<String, dynamic> json) {
    authorAvatar = json['authorAvatar'];
    authorId = json['authorId'];
    authorName = json['authorName'];
    commentNumber = json['commentNumber'];
    cover = json['cover'];
    createTime = json['createTime'];
    discountPrice = json['discountPrice'].toString();
    duration = json['duration'];
    id = json['id'];
    intro = json['intro'];
    likeFlag = json['likeFlag'];
    likeNumber = json['likeNumber'];
    linkAddress = json['linkAddress'];
    playNumber = json['playNumber'];
    price = json['price'].toString();
    priceType = json['priceType'];
    if (json['resolutionRatios'] != null) {
      resolutionRatios = <ResolutionRatios>[];
      json['resolutionRatios'].forEach((v) {
        resolutionRatios!.add(new ResolutionRatios.fromJson(v));
      });
    }
    tagList = json['tagList'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authorAvatar'] = this.authorAvatar;
    data['authorId'] = this.authorId;
    data['authorName'] = this.authorName;
    data['commentNumber'] = this.commentNumber;
    data['cover'] = this.cover;
    data['createTime'] = this.createTime;
    data['discountPrice'] = this.discountPrice;
    data['duration'] = this.duration;
    data['id'] = this.id;
    data['intro'] = this.intro;
    data['likeFlag'] = this.likeFlag;
    data['likeNumber'] = this.likeNumber;
    data['linkAddress'] = this.linkAddress;
    data['playNumber'] = this.playNumber;
    data['price'] = this.price;
    data['priceType'] = this.priceType;
    if (this.resolutionRatios != null) {
      data['resolutionRatios'] =
          this.resolutionRatios!.map((v) => v.toJson()).toList();
    }
    data['tagList'] = this.tagList;
    data['title'] = this.title;
    return data;
  }
}

class ResolutionRatios {
  int? size;
  int? type;
  String? typeText;
  String? url;

  ResolutionRatios({this.size, this.type, this.typeText, this.url});

  ResolutionRatios.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    type = json['type'];
    typeText = json['typeText'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['type'] = this.type;
    data['typeText'] = this.typeText;
    data['url'] = this.url;
    return data;
  }
}
