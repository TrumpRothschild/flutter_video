import 'package:base/bases/get_base_connect.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:services/models/res/video/video_bean.dart';

import '../api/video_apis.dart';
import '../models/req/video/video_search_param.dart';
import '../models/res/base_response.dart';
import '../models/res/video/video_category_model.dart';
import '../models/res/video/video_page_list_bean.dart';

/// 视频provider
class VideoProvider extends GetBaseConnect {
  /// 获取首页tab数据
  static Future<List<VideoCategoryModel>?> getVideoCategoryList() async {
    // 查询接口
    BaseResponse response = await VideoApis.of().videoCategoryList();
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return (response.data as List<dynamic>)
        .map((e) => VideoCategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// 首页面板及面板内容查询
  static Future<List<VideoPageListBean>?> getVideoIndexPanel(data) async {
    BaseResponse response = await VideoApis.of().videoIndexPanel(data);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return (response.data as List<dynamic>)
        .map((e) => VideoPageListBean.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// 视频搜索
  static Future<List<VideoBean>?> videoSearch(VideoSearchParam param) async {
    BaseResponse response = await VideoApis.of().videoSearch(param.toJson());
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return (response.data as List<dynamic>)
        .map((e) => VideoBean.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
