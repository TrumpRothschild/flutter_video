import '../http.dart';
import 'apis.dart';

/// @date 2023/02/14
/// @author bert
/// @des 首页相关api

class HomeApis {
  static HomeApis of() => HomeApis();

  /// 首页tab接口
  getColumn() async {
    return await HttpUtil().post(Apis.getColumn);
  }

  /// 首页推荐列+直播列表，前4个为推荐列表，剩余为其他直播列表
  getLiveList(Map<String, dynamic> params) async {
    return await HttpUtil().post(Apis.getLiveList, data: params);
  }

  /// 根据栏目code查询直播房间列表(除了推荐和关注栏目外)
  getLiveByColumnCode(Map<String, dynamic> params) async {
    return await HttpUtil().post(Apis.getLiveByColumnCode, data: params);
  }

  /// 首页热门视频+星秀
  getSearchVideo(Map<String, dynamic> params) async {
    return await HttpUtil().post(Apis.getSearchVideo, data: params);
  }

  /// 热门视频 获取10个视频(随机)
  getHotVideoList() async {
    return await HttpUtil().post(Apis.getHotVideoList);
  }

  /// 关注的直播房间列表
  getLiveFocusList(Map<String, dynamic> params) async {
    return await HttpUtil().post(Apis.getLiveFocusList, data: params);
  }

  /// 关注页推荐的直播房间列表,不包含已经关注的房间
  getLiveFocusRecommendList() async {
    return await HttpUtil().post(Apis.getLiveFocusRecommendList);
  }

  /// 首页推荐列表顶部游戏
  getTopGameList() async {
    return await HttpUtil().post(Apis.getTopGameList);
  }

  /// 定位当前国家省
  getCountryProvince() async {
    return await HttpUtil().get(Apis.getCountryProvince);
  }

  /// 获取国家省信息
  getCountryProvinceList() async {
    return await HttpUtil().post(Apis.getCountryProvinceList);
  }

  /// 获取最近浏览
  getBrowseHistory() async {
    return await HttpUtil().post(Apis.getBrowseHistory);
  }

  /// 获取直播搜索
  getLiveSearch(Map<String, dynamic> params) async {
    return await HttpUtil().post(Apis.getLiveSearch, data: params);
  }
}
