import 'package:base/bases/get_base_connect.dart';
import 'package:get/get.dart';
import 'package:services/api/home_apis.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/home/home_address_bean.dart';
import 'package:services/models/res/home/home_live_bean.dart';
import 'package:services/models/res/home/home_location_bean.dart';
import 'package:services/models/res/home/home_recommend_live_bean.dart';
import 'package:services/models/res/home/home_search_bean.dart';
import 'package:services/models/res/home/home_tab_bean.dart';
import 'package:services/models/res/home/home_top_game_bean.dart';
import 'package:services/models/res/home/home_video_bean.dart';

class HomeProvider extends GetBaseConnect {
  /// 获取首页tab数据
  static Future<List<HomeTabBean>?> getColumn() async {
    BaseResponse response = await HomeApis.of().getColumn();
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return (response.data as List<dynamic>)
        .map((e) => HomeTabBean.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// 获取首页推荐列+直播列表
  static Future<HomeRecommendLiveBean?> getLiveList(
      Map<String, dynamic> params) async {
    BaseResponse response = await HomeApis.of().getLiveList(params);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return HomeRecommendLiveBean.fromJson(response.data);
  }

  ///根据栏目code查询直播房间列表(除了推荐和关注栏目外)
  static Future<List<HomeLiveBean>?> getLiveByColumnCode(
      Map<String, dynamic> params) async {
    BaseResponse response = await HomeApis.of().getLiveByColumnCode(params);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return (response.data as List<dynamic>)
        .map((e) => HomeLiveBean.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// 首页热门视频+星秀
  static Future<List<HomeVideoBean>?> getSearchVideo(
      Map<String, dynamic> params) async {
    BaseResponse response = await HomeApis.of().getSearchVideo(params);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return (response.data as List<dynamic>)
        .map((e) => HomeVideoBean.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// 热门视频 获取10个视频(随机)
  static Future<List<HomeVideoBean>?> getHotVideoList() async {
    BaseResponse response = await HomeApis.of().getHotVideoList();
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return (response.data as List<dynamic>)
        .map((e) => HomeVideoBean.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// 关注的直播房间列表
  static Future<List<HomeLiveBean>?> getLiveFocusList(
      Map<String, dynamic> params) async {
    BaseResponse response = await HomeApis.of().getLiveFocusList(params);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return (response.data as List<dynamic>)
        .map((e) => HomeLiveBean.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// 关注页推荐的直播房间列表,不包含已经关注的房间
  static Future<List<HomeLiveBean>?> getLiveFocusRecommendList() async {
    BaseResponse response = await HomeApis.of().getLiveFocusRecommendList();
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return (response.data as List<dynamic>)
        .map((e) => HomeLiveBean.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// 首页推荐列表顶部游戏
  static Future<List<HomeTopGameBean>?> getTopGameList() async {
    BaseResponse response = await HomeApis.of().getTopGameList();
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return (response.data as List<dynamic>)
        .map((e) => HomeTopGameBean.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// 定位当前国家省
  static Future<HomeLocationBean?> getCountryProvince() async {
    BaseResponse response = await HomeApis.of().getCountryProvince();
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return HomeLocationBean.fromJson(response.data);
  }

  /// 获取国家省信息
  static Future<List<HomeAddressBean>?> getCountryProvinceList() async {
    BaseResponse response = await HomeApis.of().getCountryProvinceList();
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return (response.data as List<dynamic>)
        .map((e) => HomeAddressBean.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// 获取最近浏览
  static Future<List<HomeLiveBean>?> getBrowseHistory() async {
    BaseResponse response = await HomeApis.of().getBrowseHistory();
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return (response.data as List<dynamic>)
        .map((e) => HomeLiveBean.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// 获取直播搜索
  static Future<HomeSearchBean?> getLiveSearch(
      Map<String, dynamic> params) async {
    BaseResponse response = await HomeApis.of().getLiveSearch(params);
    if (GetUtils.isNull(response) == true) {
      return null;
    }
    return HomeSearchBean.fromJson(response.data);
  }
}
