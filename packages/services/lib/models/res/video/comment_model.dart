class CommentModel {
  String? content;
  int? id;
  int? likeCount;
  bool? likes;
  String? nickName;
  int? replyCount;
  bool? report;
  int? reportCount;
  String? timeText;
  String? userAvatar;
  int? videoId;
  int? createBy;
  List<NextList>? nextList;

  CommentModel(
      {this.content,
        this.id,
        this.likeCount,
        this.likes,
        this.nickName,
        this.replyCount,
        this.report,
        this.reportCount,
        this.timeText,
        this.userAvatar,
        this.createBy,
        this.videoId,
        this.nextList});

  CommentModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    id = json['id'];
    likeCount = json['likeCount'];
    createBy = json['createBy'];
    likes = json['likes'];
    nickName = json['nickName'];
    replyCount = json['replyCount'];
    report = json['report'];
    reportCount = json['reportCount'];
    timeText = json['timeText'];
    userAvatar = json['userAvatar'];
    videoId = json['videoId'];
    if (json['nextList'] != null) {
      nextList = <NextList>[];
      json['nextList'].forEach((v) {
        nextList!.add(new NextList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['id'] = this.id;
    data['likeCount'] = this.likeCount;
    data['likes'] = this.likes;
    data['nickName'] = this.nickName;
    data['replyCount'] = this.replyCount;
    data['report'] = this.report;
    data['reportCount'] = this.reportCount;
    data['timeText'] = this.timeText;
    data['userAvatar'] = this.userAvatar;
    data['videoId'] = this.videoId;
    data['createBy'] = this.createBy;
    if (this.nextList != null) {
      data['nextList'] = this.nextList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NextList {
  int? commentId;
  String? content;
  int? id;
  int? likeCount;
  bool? likes;
  String? nickName;
  int? pid;
  int? replyCount;
  String? replyNickName;
  int? replyUserId;
  bool? report;
  int? reportCount;
  String? timeText;
  String? userAvatar;
  int? videoId;
  int? createBy;

  NextList(
      {this.commentId,
        this.content,
        this.id,
        this.likeCount,
        this.likes,
        this.nickName,
        this.pid,
        this.replyCount,
        this.replyNickName,
        this.replyUserId,
        this.report,
        this.reportCount,
        this.timeText,
        this.userAvatar,
        this.createBy,
        this.videoId});

  NextList.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    content = json['content'];
    id = json['id'];
    likeCount = json['likeCount'];
    likes = json['likes'];
    nickName = json['nickName'];
    pid = json['pid'];
    replyCount = json['replyCount'];
    replyNickName = json['replyNickName'];
    replyUserId = json['replyUserId'];
    report = json['report'];
    reportCount = json['reportCount'];
    timeText = json['timeText'];
    userAvatar = json['userAvatar'];
    videoId = json['videoId'];
    createBy= json['createBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentId'] = this.commentId;
    data['content'] = this.content;
    data['id'] = this.id;
    data['likeCount'] = this.likeCount;
    data['likes'] = this.likes;
    data['nickName'] = this.nickName;
    data['pid'] = this.pid;
    data['replyCount'] = this.replyCount;
    data['replyNickName'] = this.replyNickName;
    data['replyUserId'] = this.replyUserId;
    data['report'] = this.report;
    data['reportCount'] = this.reportCount;
    data['timeText'] = this.timeText;
    data['userAvatar'] = this.userAvatar;
    data['videoId'] = this.videoId;
    data['createBy'] = this.createBy;
    return data;
  }
}
