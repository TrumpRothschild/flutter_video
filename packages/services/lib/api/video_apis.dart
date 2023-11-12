import 'package:services/api/apis.dart';
import 'package:services/http.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/video/video_tag.dart';

class VideoApis {
  static VideoApis of() => VideoApis();

  ///视频分类
  videoCategoryList() async {
    return await HttpUtil().get(Apis.videoCategoryList);
  }

  videoCategoryListGroup() async {
    return await HttpUtil().get(Apis.videoCategoryListGroup);
  }

  ///视频详情
  videoDetail(data) async {
    return await HttpUtil().get(Apis.videoDetail, queryParameters: data);
  }

  /// 首页面板及面板内容查询
  videoIndexPanel(data) async {
    return await HttpUtil().get(Apis.videoIndexPanel, queryParameters: data);
  }
  /// 首页面板及面板内容查询
  videoFeedback(data) async {
    return await HttpUtil().post(Apis.videoFeedback, data: data);
  }

  /// 我收藏/喜欢的视频列表
  videoCollectList(data) async {
    return await HttpUtil().post(Apis.videoCollectList, data: data);
  }

  /// 上传图片
  uploadPicture(data) async {
    return await HttpUtil().post(
      Apis.uploadPicture,
      data: data,
      uploadImg: true,
    );
  }

  /// 统计信息(观看次数、下载次数)
  videoWatchRecordStatistics() async {
    return await HttpUtil().get(Apis.videoWatchRecordStatistics);
  }

  /// 当天观看次数
  videoWatchRecordTodayCount() async {
    return await HttpUtil().get(Apis.videoWatchRecordTodayCount);
  }

  /// 详情页视频推荐
  videoRecommend(data) async {
    return await HttpUtil().get(Apis.videoRecommend, queryParameters: data);
  }

  /// 视频观看(直接返回m3u8响应流文件)
  videoWatch(data) async {
    return await HttpUtil().get(Apis.videoWatch, queryParameters: data);
  }

  /// 视频观看增加记录
  recordWatch(data) async {
    return await HttpUtil().get(Apis.recordWatch, queryParameters: data);
  }

  /// 视频收藏(喜欢)
  videoCollect(data) async {
    return await HttpUtil().post(Apis.videoCollect, data: data);
    return await HttpUtil().get(Apis.videoCollect, queryParameters: data);
    // return await HttpUtil().postForm(Apis.videoCollect, data: data);
  }

  /// 取消视频收藏(喜欢)
  videoUnCollect(data) async {
    return await HttpUtil().get(Apis.videoUnCollect, queryParameters: data);
    // return await HttpUtil().postForm(Apis.videoUnCollect, data: data);
  }

  /// 我的视频观看删除
  deleteVideoWatchRecord(data) async {
    return await HttpUtil()
        .get(Apis.deleteVideoWatchRecord, queryParameters: data);
  }

  /// 详情页视频推荐
  download(data) async {
    return await HttpUtil().get(Apis.download, queryParameters: data);
  }

  /// 视频标签组(视频搜索用)
  videoTag() async {
    return await HttpUtil().get(Apis.videoTag);
  }

  videofilterList() async {
    return await HttpUtil().get(Apis.videofilterList);
  }

  /// 视频搜索
  videoSearch(data) async {
    return await HttpUtil().post(Apis.videoSearch, data: data);
  }

  /// 热门视频tag
  Future<VideoTags> videoDynamics() async {
    BaseResponse response = await HttpUtil().get(Apis.videoDynamics);
    VideoTags videoTags = VideoTags.fromJson(response.data);
    return videoTags;
  }

  /// 热门视频搜索
  videoHotSearch() async {
    return await HttpUtil().get(Apis.videoHotSearch);
  }

  /// 我的视频观看记录
  videoWatchRecord(data) async {
    return await HttpUtil().post(Apis.videoWatchRecord, data: data);
  }

  /// 评论列表
  videoComment(data) async {
    return await HttpUtil().get(Apis.videoComment, queryParameters: data);
  }

  /// 回复列表
  videoCommentReplyList(data) async {
    return await HttpUtil()
        .get(Apis.videoCommentReplyList, queryParameters: data);
  }

  /// 评论
  comment(data) async {
    return await HttpUtil().post(Apis.comment, data: data);
  }

  /// 回复评论
  replyComment(data) async {
    return await HttpUtil().post(Apis.replyComment, data: data);
  }

  /// 删除评论
  deleteComment(data) async {
    return await HttpUtil().get(Apis.deleteComment, queryParameters: data);
  }

  /// 删除评论
  videoCommentReplyDelete(data) async {
    return await HttpUtil()
        .get(Apis.videoCommentReplyDelete, queryParameters: data);
  }

  /// 点赞
  videoCommentLike(data) async {
    return await HttpUtil().get(Apis.videoCommentLike, queryParameters: data);
  }

  /// 点赞
  videoCommentReplyLike(data) async {
    return await HttpUtil()
        .get(Apis.videoCommentReplyLike, queryParameters: data);
  }

  /// 举报
  videoCommentReport(data) async {
    return await HttpUtil().get(Apis.videoCommentReport, queryParameters: data);
  }

  /// 举报
  videoCommentReplyReport(data) async {
    return await HttpUtil()
        .get(Apis.videoCommentReplyReport, queryParameters: data);
  }

  /// 视频详情页面板查询
  detailPanel() async {
    return await HttpUtil().get(Apis.detailPanel);
  }

  /// 分享邀请码获取
  getShareData() async {
    return await HttpUtil().post(Apis.getShareData);
  }
}
